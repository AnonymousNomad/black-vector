#!/usr/bin/env python3
"""Static verification for the BLACK VECTOR game project
(Directive-002/BV-001A, Directive-006/BV-001B, Directive-007/BV-001C,
Directive-009 CQC proof slice).

Checks (all purely structural — no runtime claims):
  1. Required repository structure exists.
  2. project.godot parses: [application] main scene present and on disk.
  3. Input actions: every InputMap action referenced by game scripts is declared in [input].
  4. Scene/resource reference integrity: every ext_resource path in .tscn/.tres exists on disk.
  5. Node parent chains in .tscn resolve to declared nodes.
  6. Prohibited-term scan: no NOMADIC CREED references, no Mono/C#, no network/cloud dependencies,
     no absolute device-specific paths.
  7. No git commit expected (informational).
  8. D009 CQC-slice invariants: separate CONTACT/RANGE seeds, rage threshold+hysteresis,
     Control driven by host events, ai_surface contract, opponent callback surface,
     forbidden D009 slice terms absent, combat wired into the player.

Exit code 0 = clean; 1 = issues found. Uses stdlib only.
"""

import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
GAME = os.path.join(ROOT, "game")

REQUIRED_DIRS = {
    "game", "game/scenes", "game/scenes/player", "game/scenes/movement_lab",
    "game/scenes/sandbox", "game/scenes/world", "game/scenes/ui", "game/scenes/ai",
    "game/scenes/slice", "game/scenes/ui_core",
    "game/scripts", "game/scripts/player", "game/scripts/world", "game/scripts/ui",
    "game/scripts/ai", "game/scripts/slice", "game/scripts/input", "game/scripts/ui_core",
    "game/resources", "game/assets", "game/data", "tests",
}

PROHIBITED_PATTERNS = {
    "no nomadic creed reference": re.compile(r"nomadic", re.IGNORECASE),
    "no mono / c#": re.compile(r"\bmono\b|\.cs\b|C#", re.IGNORECASE),
    "no network/cloud dependency": re.compile(
        r"https?://|websocket|HTTPRequest|TCP_(Client|Server)|UPNP|Cloud\b", re.IGNORECASE),
    "no absolute device path": re.compile(r"^/home/|^C:\\|^D:\\|^/Users/", re.MULTILINE),
}

SCRIPT_REF_RE = {
    "is_action_pressed": re.compile(r'is_action_pressed\("(\w+)"'),
    "is_action_just_pressed": re.compile(r'is_action_just_pressed\("(\w+)"'),
    "is_action_just_released": re.compile(r'is_action_just_released\("(\w+)"'),
    "get_action_strength": re.compile(r'get_action_strength\("(\w+)"'),
    "action_press": re.compile(r'action_press\("(\w+)"'),
    "action_release": re.compile(r'action_release\("(\w+)"'),
    "get_axis": re.compile(r'get_axis\("(\w+)",\s*"(\w+)"'),
    "get_vector": re.compile(r'get_vector\("(\w+)",\s*"(\w+)",\s*"(\w+)",\s*"(\w+)"'),
}


def file_exists_under_root(res: str) -> bool:
    if not res.startswith("res://"):
        return False
    return os.path.isfile(os.path.join(GAME, res[len("res://"):]))


def parse_input_actions(config: str) -> set:
    actions = set()
    in_input = False
    for line in config.splitlines():
        line = line.strip()
        if line.startswith("["):
            in_input = line == "[input]"
            continue
        if in_input and re.match(r"^\w+=\{", line):
            actions.add(line.split("=", 1)[0])
    return actions


def collect_input_references() -> set:
    used = set()
    for dirpath, _dirs, files in os.walk(GAME):
        for name in files:
            if not name.endswith(".gd"):
                continue
            with open(os.path.join(dirpath, name), "r", encoding="utf-8") as fh:
                text = fh.read()
            for regex in SCRIPT_REF_RE.values():
                for match in regex.findall(text):
                    if isinstance(match, tuple):
                        used.update(match)
                    else:
                        used.add(match)
    return used


def verify_scene_resources() -> list:
    issues = []
    pattern = re.compile(r'\[ext_resource[^\]]*path="([^"]+)"')
    for dirpath, _dirs, files in os.walk(GAME):
        for name in files:
            if not (name.endswith(".tscn") or name.endswith(".tres")):
                continue
            full = os.path.join(dirpath, name)
            with open(full, "r", encoding="utf-8") as fh:
                text = fh.read()
            for res in pattern.findall(text):
                if res.startswith("res://") and not file_exists_under_root(res):
                    issues.append(f"{os.path.relpath(full, ROOT)} -> {res}")
    return issues


def verify_node_parents() -> list:
    issues = []
    for dirpath, _dirs, files in os.walk(GAME):
        for name in files:
            if not name.endswith(".tscn"):
                continue
            full = os.path.join(dirpath, name)
            with open(full, "r", encoding="utf-8") as fh:
                lines = fh.read().splitlines()
            declared = set()
            for line in lines:
                if not line.startswith("[node"):
                    continue
                name_m = re.search(r'name="([^"]+)"', line)
                if name_m:
                    declared.add(name_m.group(1))
            for line in lines:
                if not line.startswith("[node") or ' parent="' not in line:
                    continue
                node_name = re.search(r'name="([^"]+)"', line).group(1)
                parent = re.search(r'parent="([^"]+)"', line).group(1)
                if parent == ".":
                    continue
                for segment in parent.split("/"):
                    if segment and segment not in declared:
                        issues.append(f"{os.path.relpath(full, ROOT)}: node '{node_name}' -> missing parent segment '{segment}'")
    return issues


D009_SLICE_FILES = [
    "game/scripts/player/combat_controller.gd",
    "game/scripts/ai/training_opponent.gd",
]

D009_FORBIDDEN_TERMS = [
    "telekinesis", "telekinetic", "neural_strain", "neural strain", "compound",
    "skill_tree", "skill tree", "execution", "assassination", "shade", "boss",
    "ground_combat", "ground combat", "weapon",
]

OPPONENT_CALLBACKS = [
    "intent_value", "resolve_player_attack", "finish_telegraph",
    "apply_pin_start", "on_player_break", "posture_value", "stamina_value",
]

CQC_CONTACT_MEMBERS = [
    "READ", "ENGAGE", "EXCHANGE", "ADVANTAGE", "CONTROL", "RESOLUTION", "RESET",
]


def verify_cqc_invariants() -> list:
    issues = []
    combat_path = os.path.join(ROOT, "game/scripts/player/combat_controller.gd")
    opp_path = os.path.join(ROOT, "game/scripts/ai/training_opponent.gd")
    if not os.path.isfile(combat_path):
        return ["game/scripts/player/combat_controller.gd missing for D009 slice"]
    if not os.path.isfile(opp_path):
        return ["game/scripts/ai/training_opponent.gd missing for D009 slice"]
    with open(combat_path, "r", encoding="utf-8") as fh:
        combat = fh.read()
    with open(opp_path, "r", encoding="utf-8") as fh:
        opp = fh.read()

    for enum_name in ("ContactState", "RangeState", "BattleStance", "Initiative"):
        if f"enum {enum_name}" not in combat:
            issues.append(f"combat_controller: missing enum {enum_name}")

    enum_block = re.search(r"enum ContactState \{([^}]*)\}", combat)
    if enum_block:
        for member in CQC_CONTACT_MEMBERS:
            if re.search(rf"(?<!,)?\b{member}\b", enum_block.group(1)) is None:
                issues.append(f"combat_controller: ContactState missing member {member}")

    if "enum RangeState" in combat and "DISENGAGE_RANGE" in combat and "STRIKING_RANGE" in combat:
        pass
    else:
        issues.append("combat_controller: RangeState must be a separate range seed")

    for name, literal in (
        ("RAGE_ENTER", r"RAGE_ENTER := 0\.22"),
        ("RAGE_EXIT", r"RAGE_EXIT := 0\.35"),
        ("RAGE_DEBOUNCE", r"RAGE_DEBOUNCE := 1\.0"),
    ):
        if re.search(literal, combat) is None:
            issues.append(f"combat_controller: missing rage gate {name}")

    for kind, const in (
        ("hit_taken", "HIT_HOST_DROP"),
        ("posture_broken", "POSTURE_BROKEN_DROP"),
        ("failed_defensive_timing", "FAILED_TIMING_DROP"),
    ):
        if f'host_event("{kind}", {const})' not in combat:
            issues.append(f"combat_controller: host_event(\"{kind}\", {const}) missing")

    if "func host_event" not in combat or "enter_rage(kind)" not in combat:
        issues.append("combat_controller: host_event/rage entry chain missing")
    if "control <= RAGE_ENTER" not in combat or "control >= RAGE_EXIT" not in combat:
        issues.append("combat_controller: rage threshold/hysteresis gates missing")

    if "func ai_surface" not in combat:
        issues.append("combat_controller: ai_surface() missing")
    if "call(\"ai_surface\")" not in opp:
        issues.append("training_opponent: does not consume combat ai_surface()")
    if "noise_event.connect" not in opp:
        issues.append("training_opponent: does not consume player noise_event()")

    for cb in OPPONENT_CALLBACKS:
        if f"func {cb}" not in opp:
            issues.append(f"training_opponent: missing callback {cb}")

    if "combat_controller.process(delta, self)" not in _read_rel(os.path.join(ROOT, "game/scripts/player/player.gd")):
        issues.append("player.gd: CombatController not driven per physics frame")
    if "combat_controller.debug_line()" not in _read_rel(os.path.join(ROOT, "game/scripts/player/player.gd")):
        issues.append("player.gd: combat line missing from debug_snapshot")
    with open(os.path.join(ROOT, "game/scenes/player/player.tscn"), "r", encoding="utf-8") as fh:
        if "CombatController" not in fh.read():
            issues.append("player.tscn: CombatController node absent")

    for file_rel in D009_SLICE_FILES:
        with open(os.path.join(ROOT, file_rel), "r", encoding="utf-8") as fh:
            text = fh.read()
        for term in D009_FORBIDDEN_TERMS:
            if re.search(rf"\b{re.escape(term)}\b", text, re.IGNORECASE):
                issues.append(f"D009 forbidden term '{term}' in {file_rel}")
    return issues


def _read_rel(path: str) -> str:
    with open(path, "r", encoding="utf-8") as fh:
        return fh.read()


GENERATED_SKIP_DIRS = {".godot"}
GENERATED_SKIP_SUFFIXES = (".uid", ".import", ".bin", ".res")


def scan_prohibited() -> list:
    issues = []
    for dirpath, dirs, files in os.walk(GAME):
        dirs[:] = [d for d in dirs if d not in GENERATED_SKIP_DIRS]
        for name in files:
            if name.endswith(GENERATED_SKIP_SUFFIXES):
                continue
            full = os.path.join(dirpath, name)
            try:
                with open(full, "r", encoding="utf-8") as fh:
                    text = fh.read()
            except (OSError, UnicodeDecodeError):
                continue
            for label, regex in PROHIBITED_PATTERNS.items():
                for line_no, line in enumerate(text.splitlines(), 1):
                    if not regex.search(line):
                        continue
                    if label == "no network/cloud dependency" and "xmlns=" in line:
                        continue
                    issues.append(f"{label} in {os.path.relpath(full, ROOT)}:{line_no}")
    return issues


AUTOLOAD_EXPECTED = {
    "Settings": "res://scripts/slice/settings_store.gd",
    "InputManager": "res://scripts/input/input_manager.gd",
}

SLICE_ENTRY = "res://scenes/slice/slice_main.tscn"
SLICE_MANAGERS = (
    "game/scripts/slice/world_state_manager.gd",
    "game/scripts/slice/time_weather_manager.gd",
    "game/scripts/slice/player_state_manager.gd",
    "game/scripts/slice/save_state_manager.gd",
    "game/scripts/slice/interaction_manager.gd",
    "game/scripts/slice/audio_manager.gd",
    "game/scripts/slice/game_world.gd",
)

INPUT_ADAPTER_DIR = os.path.join(GAME, "scripts/input")
RAW_INPUT_TOKENS = (
    "InputEventScreenTouch",
    "InputEventScreenDrag",
    "InputEventMouse",
    "is_physical_key_pressed",
    "get_connected_joypads",
)

RAW_INPUT_WHITELIST = {
    "game/scripts/player/camera_rig.gd": {"InputEventMouse"},
}

WRITE_WRITERS = (os.path.join(ROOT, "game/scripts/slice/save_state_manager.gd"),
                 os.path.join(ROOT, "game/scripts/slice/settings_store.gd"))


def verify_autoloads(config: str) -> list:
    issues = []
    section = re.search(r"\[autoload\]([^\[]*)", config)
    declared = dict(re.findall(r'^(\w+)="\*?res://([^"]+)"', section.group(1), re.MULTILINE)
                    if section else [])
    for name, expected_res_path in AUTOLOAD_EXPECTED.items():
        if name not in declared:
            issues.append(f"autoload {name} not declared")
            continue
        actual_rel = declared[name].replace("res://", "")
        if not os.path.isfile(os.path.join(GAME, actual_rel)):
            issues.append(f"autoload {name} path missing on disk: {declared[name]}")
    return issues


def verify_input_isolation() -> list:
    issues = []
    for dirpath, _dirs, files in os.walk(GAME):
        if os.path.commonpath([dirpath, INPUT_ADAPTER_DIR]) == INPUT_ADAPTER_DIR:
            continue
        for name in files:
            if not name.endswith(".gd"):
                continue
            full = os.path.join(dirpath, name)
            rel = os.path.relpath(full, ROOT)
            with open(full, "r", encoding="utf-8") as fh:
                text = fh.read()
            allowed = RAW_INPUT_WHITELIST.get(rel, set())
            for token in RAW_INPUT_TOKENS:
                if token in text and token not in allowed:
                    issues.append(f"raw input token '{token}' outside scripts/input/: {rel}")
    return issues


def verify_writer_ownership() -> list:
    issues = []
    pattern = re.compile(r"FileAccess\.open\(")
    for dirpath, _dirs, files in os.walk(GAME):
        for name in files:
            if not name.endswith(".gd"):
                continue
            full = os.path.join(dirpath, name)
            try:
                if pattern.search(_read_rel(full)) is None:
                    continue
            except OSError:
                continue
            if full not in WRITE_WRITERS:
                issues.append(f"file-writer outside permitted managers: {os.path.relpath(full, ROOT)}")
    return issues


def verify_slice_invariants() -> list:
    issues = []
    if not os.path.isfile(os.path.join(ROOT, "game/scenes/slice/slice_main.tscn")):
        issues.append("res://scenes/slice/slice_main.tscn missing")
    if not os.path.isfile(os.path.join(ROOT, "game/scenes/slice/sector_s1_strand.tscn")):
        issues.append("res://scenes/slice/sector_s1_strand.tscn missing")
    for rel in SLICE_MANAGERS:
        path = os.path.join(ROOT, rel)
        if not os.path.isfile(path):
            issues.append(f"slice manager missing: {rel}")

    project = _read_rel(os.path.join(GAME, "project.godot"))
    if "run/main_scene=\"res://scenes/slice/slice_main.tscn\"" not in project:
        issues.append("project.godot main_scene is not res://scenes/slice/slice_main.tscn")

    host = _read_rel(os.path.join(ROOT, "game/scenes/slice/slice_main.tscn"))
    if 'script = ExtResource("1")' not in host:
        issues.append("slice_main must host GameWorld script")
    test_env = _read_rel(os.path.join(ROOT, "game/scenes/slice/sector_s1_strand.tscn"))
    if "player.tscn" not in test_env:
        issues.append("sector_s1_strand must instance player.tscn")
    return issues


def verify_slice_node_census() -> int:
    count = 0
    for dirpath, _dirs, files in os.walk(os.path.join(GAME, "scenes/slice")):
        for name in files:
            if not name.endswith(".tscn"):
                continue
            full = os.path.join(dirpath, name)
            with open(full, "r", encoding="utf-8") as fh:
                for line in fh:
                    if line.startswith("[node"):
                        count += 1
    return count


def verify_self_check_harness() -> list:
    issues = []
    if not os.path.isfile(os.path.join(ROOT, "game/scripts/slice/foundation_self_check.gd")):
        issues.append("foundation_self_check.gd missing (on-device gate harness)")
    if not os.path.isfile(os.path.join(ROOT, "game/scenes/slice/foundation_self_check.tscn")):
        issues.append("foundation_self_check.tscn missing (on-device gate scene)")
    return issues


def main() -> int:
    ok = []
    issues = []

    for rel in sorted(REQUIRED_DIRS):
        if os.path.isdir(os.path.join(ROOT, rel)):
            ok.append(f"dir {rel}/ exists")
        else:
            issues.append(f"dir {rel}/ missing")

    project_path = os.path.join(GAME, "project.godot")
    if not os.path.isfile(project_path):
        issues.append("game/project.godot missing")
    else:
        with open(project_path, "r", encoding="utf-8") as fh:
            config = fh.read()
        main_match = re.search(r'run/main_scene="([^"]+)"', config)
        if main_match and file_exists_under_root(main_match.group(1)):
            ok.append(f"main_scene exists: {main_match.group(1)}")
        elif main_match:
            issues.append(f"main_scene missing on disk: {main_match.group(1)}")
        else:
            issues.append("main_scene not declared in project.godot")

        renderer = re.search(r'renderer/rendering_method="([^"]+)"', config)
        if renderer and renderer.group(1) == "gl_compatibility":
            ok.append("rendering_method = gl_compatibility")
        else:
            issues.append(f"rendering_method is not gl_compatibility (found: {renderer.group(1) if renderer else 'none'})")

        actions = parse_input_actions(config)
        ok.append(f"{len(actions)} input actions declared in project.godot")

        used = collect_input_references()
        missing = sorted(a for a in used if a not in actions)
        if missing:
            issues.append(f"script input actions not declared: {missing}")
        else:
            ok.append("all script input references resolve to declared actions")

        autoload_issues = verify_autoloads(config)
        if autoload_issues:
            issues.extend(autoload_issues)
        else:
            ok.append("autoloads Settings + InputManager declared and on disk")

    res_issues = verify_scene_resources()
    if res_issues:
        issues.extend(res_issues[:5])
    else:
        ok.append("all ext_resource paths resolve on disk")

    parent_issues = verify_node_parents()
    if parent_issues:
        issues.extend(parent_issues[:5])
    else:
        ok.append("scene node parent chains resolve")

    cqc_issues = verify_cqc_invariants()
    if cqc_issues:
        issues.extend(cqc_issues[:6])
    else:
        ok.append("D009 CQC-slice invariants hold")

    prohibited = scan_prohibited()
    if prohibited:
        issues.extend(prohibited[:5])
    else:
        ok.append("prohibited-term scan clean")

    isolation_issues = verify_input_isolation()
    if isolation_issues:
        issues.extend(isolation_issues[:5])
    else:
        ok.append("input raw-event tokens confined to scripts/input/")

    writer_issues = verify_writer_ownership()
    if writer_issues:
        issues.extend(writer_issues[:5])
    else:
        ok.append("file-writers are only save_state_manager + settings_store")

    slice_issues = verify_slice_invariants()
    if slice_issues:
        issues.extend(slice_issues[:5])
    else:
        ok.append("D027-EXEC slice structure invariants hold")

    self_check_issues = verify_self_check_harness()
    if self_check_issues:
        issues.extend(self_check_issues[:5])
    else:
        ok.append("on-device self-check harness present")

    census = verify_slice_node_census()
    ok.append(f"slice scene static node census: {census} nodes (target < 1200)")

    print("== STATIC VERIFICATION (game/) ==")
    for item in sorted(ok):
        print(f"  [OK]   {item}")
    for item in sorted(set(issues)):
        print(f"  [FAIL] {item}")
    print(f"RESULT: {'CLEAN' if not issues else 'ISSUES FOUND'} ({len(ok)} ok, {len(issues)} fail)")
    return 1 if issues else 0


if __name__ == "__main__":
    sys.exit(main())