#!/usr/bin/env python3
"""Static validation of BLACK VECTOR methodology (Directive 002 scope).

Checks:
  A. Skill SKILL.md presence and YAML frontmatter (name, description).
  B. Required section headers present in every skill.
  C. BV-SKILL numbering in body matches what the registry expects.
  D. SOP files exist with required headers.
  E. Doctrine + docs + registry exist.
  F. No gameplay implementation files OUTSIDE the authorized game directory
     (Directive 002 authorizes the Godot project under /black-vector/game).
  G. No forbidden zero-tolerance code patterns in living documents
     (present-tense guidance, not anti-pattern quotes). Use source markers.
"""
import re
import sys
from pathlib import Path

ROOT = Path("/black-vector")
GAME_DIR = ROOT / "game"
SKILLS = ROOT / ".opencode" / "skills"
REGISTRY = ROOT / "skills" / "registry.md"

REQUIRED_SECTIONS = [
    "## NAME",
    "## PURPOSE",
    "## WHEN TO LOAD",
    "## DO NOT LOAD WHEN",
    "## PRECONDITIONS",
    "## GOVERNING INVARIANTS",
    "## WORKFLOW",
    "## IMPLEMENTATION GUIDANCE",
    "## ANTI-PATTERNS",
    "## KNOWN FAILURE MODES",
    "## VERIFICATION",
    "## STOP CONDITIONS",
    "## RELATED SKILLS",
]

BV_SKILLS = [
    ("BV-SKILL-001", "godot-android-edge"),
    ("BV-SKILL-002", "scene-composition"),
    ("BV-SKILL-003", "third-person-character-controller"),
    ("BV-SKILL-004", "stance-system"),
    ("BV-SKILL-005", "systemic-traversal"),
    ("BV-SKILL-006", "environmental-affordances"),
    ("BV-SKILL-007", "stealth-and-concealment"),
    ("BV-SKILL-008", "tactical-ai-perception"),
    ("BV-SKILL-009", "contextual-assassination"),
    ("BV-SKILL-010", "close-combat-exchange"),
    ("BV-SKILL-011", "weapon-handling-ballistics"),
    ("BV-SKILL-012", "diegetic-memory-progression"),
    ("BV-SKILL-013", "large-world-sector-architecture"),
    ("BV-SKILL-014", "mobile-graphics-atmosphere"),
    ("BV-SKILL-015", "gameplay-debugging-instrumentation"),
    ("BV-SKILL-016", "vertical-slice-discipline"),
    ("BV-SKILL-017", "survival-wilderness-systems"),
    ("BV-SKILL-018", "psychological-horror-perceptual-events"),
    ("BV-SKILL-019", "psionic-gameplay-neural-load"),
    ("BV-SKILL-020", "facility-and-ally-support"),
    ("BV-SKILL-021", "cqc-combat-architecture"),
    ("BV-SKILL-022", "visual-equipment-doctrine"),
    ("BV-SKILL-023", "historical-provenance-research"),
    ("BV-SKILL-024", "alaska-site-environment-reference"),
    ("BV-SKILL-025", "weapon-platform-role-design"),
    ("BV-SKILL-026", "anomalous-consciousness-research"),
    ("BV-SKILL-027", "island-population-threat-ecology"),
    ("BV-SKILL-028", "prologue-narrative-architecture"),
    ("BV-SKILL-029", "simse-island-systems"),
    ("BV-SKILL-030", "anomalous-capability-architecture"),
    ("BV-SKILL-031", "persistent-character-state-architecture"),
    ("BV-SKILL-032", "visual-presentation-architecture"),
    ("BV-SKILL-033", "enemy-architecture"),
    ("BV-SKILL-034", "companion-relationship-architecture"),
    ("BV-SKILL-035", "operator-discipline-architecture"),
    ("BV-SKILL-036", "touchscreen-input-architecture"),
]

SOP_FILES = {
    "SOP-001": ("verify-first", ["## Purpose", "## When Mandatory", "## Workflow", "## Invariants", "## Stop Conditions"]),
    "SOP-002": ("scope-authority", ["## Purpose", "## When Mandatory", "## Scope Classification", "## Rules", "## Invariants", "## Stop Conditions"]),
    "SOP-003": ("godot-change-procedure", ["## Purpose", "## When Mandatory", "## Workflow", "## Invariants", "## Stop Conditions"]),
    "SOP-004": ("mobile-performance", ["## Purpose", "## When Mandatory", "## Workflow", "## Budgets", "## Invariants", "## Stop Conditions"]),
    "SOP-005": ("gameplay-verification", ["## Purpose", "## Verification Categories", "## Rules", "## Workflow", "## Invariants", "## Stop Conditions"]),
    "SOP-006": ("debug-observability", ["## Purpose", "## When Mandatory", "## Requirements for Every System", "## Conventions", "## Invariants", "## Stop Conditions"]),
}

errors = []


def err(msg):
    errors.append(msg)


regex_hidden = re.compile(r".*=\s*true\s*#?\s*.*hidden|hidden\s*=\s*true", re.IGNORECASE)


def validate_frontmatter(path):
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        err(f"{path}: missing frontmatter opener")
        return {}
    end = text.find("\n---", 4)
    if end < 0:
        err(f"{path}: missing frontmatter closer")
        return {}
    fm = text[4:end]

    def field(name):
        m = re.search(rf"^{name}:\s*(.+)$", fm, re.MULTILINE)
        return m.group(1).strip() if m else None

    name, desc = field("name"), field("description")
    if not name:
        err(f"{path}: frontmatter missing 'name'")
    if not desc:
        err(f"{path}: frontmatter missing 'description'")
    # scan body (after frontmatter) for zero-tolerance CODE patterns.
    # The ANTI-PATTERNS section legitimately quotes forbidden code, so it is
    # excluded; negation lines ("no/never/forbidden/the is no/zero-tolerance")
    # are doctrine prose, not living guidance, and are allowed anywhere.
    body = re.split(r"## ANTI-PATTERNS", text[end + 4 :], maxsplit=1)[0]
    negations = re.compile(r"\b(no|never|not|forbidden|prohibited|zero-tolerance|there is no)\b", re.IGNORECASE)
    for n, line in enumerate(body.splitlines(), 3):
        if re.search(r"\b(hidden|is_hidden|hiding)\s*=\s*true\b", line) and not negations.search(line):
            err(f"{path}:{n}: zero-tolerance pattern 'hidden = true' as living guidance")
        if re.search(r"\bplayer\s*\.\s*get\s*\(\s*[\"']xp", line) and not negations.search(line):
            err(f"{path}:{n}: living XP-tree code pattern")
    return {"name": name}


def validate_skill_file(number, slug):
    path = SKILLS / slug / "SKILL.md"
    if not path.exists():
        err(f"missing skill file {number} -> {path}")
        return
    fm = validate_frontmatter(path)
    text = path.read_text(encoding="utf-8")
    missing = [s for s in REQUIRED_SECTIONS if s not in text]
    if missing:
        err(f"{path}: missing sections {missing}")
    if fm.get("name") != slug:
        err(f"{path}: frontmatter name '{fm.get('name')}' != slug '{slug}'")
    if number != "governing" and f"({number})" not in text and fm.get("name"):
        err(f"{path}: body/header does not carry its number {number}")


def main():
    # F. gameplay implementation confined to the authorized game directory
    for pat in ("**/project.godot", "**/*.tscn", "**/*.gd", "**/*.godot"):
        hits = [p for p in ROOT.glob(pat) if not p.is_relative_to(GAME_DIR)]
        if hits:
            err(f"gameplay implementation file outside game/: {hits}")

    # A/B/C: skill files (two governing skills + 20 domain skills)
    validate_skill_file("governing", "developers-way")
    validate_skill_file("governing", "black-vector-project-doctrine")
    for number, slug in BV_SKILLS:
        validate_skill_file(number, slug)

    # D: SOPs
    for number, (slug, need) in SOP_FILES.items():
        p = ROOT / "sop" / f"{slug}.md"
        if not p.exists():
            err(f"missing {number} -> {p}")
            continue
        text = p.read_text(encoding="utf-8")
        missing = [s for s in need if s not in text]
        if missing:
            err(f"{p}: missing sections {missing}")

    # E: doctrine / docs / registry presence
    for p in [
        ROOT / "doctrine" / "DEVELOPERS_WAY.md",
        ROOT / "doctrine" / "BLACK_VECTOR_DOCTRINE.md",
        ROOT / "docs" / "methodology" / "README.md",
        REGISTRY,
    ]:
        if not p.exists():
            err(f"missing {p}")

    # C: registry carries every BV-SKILL
    if REGISTRY.exists():
        reg = REGISTRY.read_text(encoding="utf-8")
        for number, slug in BV_SKILLS:
            if f"{number}" not in reg:
                err(f"{REGISTRY}: missing {number}")
            if f"{slug}" not in reg:
                err(f"{REGISTRY}: missing slug {slug}")

    if errors:
        print(f"VALIDATION FAILED ({len(errors)} issue(s))")
        for e in errors:
            print("  - " + e)
        sys.exit(1)
    print(f"VALIDATION PASSED — 2 governing skills + {len(BV_SKILLS)} BV skills, 6 SOPs, registry, gameplay confined to game/.")


if __name__ == "__main__":
    main()