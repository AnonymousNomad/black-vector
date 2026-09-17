# BLACK VECTOR — HANDOFF: TABLET → LAPTOP

Transfer metadata. This is transfer documentation, not game design.

## Identity

- **Project:** BLACK VECTOR — edge-native third-person survival/stealth assassin game, set in one large fictional Alaska-inspired coastal world; GDScript only; Android-tablet first; fully offline.
- **Source environment (this tablet):** Linux, kernel `#1 SMP PREEMPT_DYNAMIC`, arm64, Godot 4.7.2.stable.official.ed1daf0bf (binary `/root/godot/Godot_v4.7.2-stable_linux.arm64`, headless-capable).
- **Resolved project root:** `/black-vector`
- **Godot version:** 4.7.2.stable.official.ed1daf0bf
- **Renderer / platform target:** GL Compatibility (`project.godot` `config/features=PackedStringArray("4.4","GL Compatibility")`); Android-tablet first (viewport 1280×720; touch + keyboard + controller inputs; `game/` contains no platform-specific build output).
- **Repository name (expected):** `black-vector` — PRIVATE.

## Accepted state at transfer

- **Accepted implementation candidate:** `9c0cc96eb586cc9fae11e6083dbcb3123b038048f931d42ea1cf886ef226cd9c` (STEP 11 artifact zip sha256; served historically at `:8899`).
- **Repo history:** historically UNBORN before this handoff — this is the first commit; no prior commits, no remotes, no tags existed.
- **D027 — Execution:** STEP 11 accepted (runtime probe 51/51 PASS, deterministic ×2; foundation gate 10/10; static CLEAN 36/0; methodology PASSED).
- **D028 / BV-D152:** COMPLETE — Corley Alexandra Ferrell protagonist bible (`docs/lore/CORLEY_ALEXANDRA_FERRELL_BIBLE.md`).
- **D029 / BV-D153:** COMPLETE — BLACK HAND generations / Hidden Hand synchronization / Shade bible (`docs/lore/BLACK_HAND_GENERATIONS_SHADE_BIBLE.md`).
- **D030 / BV-D154:** COMPLETE — psychological horror / inner voice / memory reliability / anomaly / SECOND architecture bible (`docs/lore/PSYCHOLOGICAL_HORROR_MEMORY_ANOMALY_BIBLE.md`).
- **D031:** NOT YET COMPLETE (frozen on completion; no work yet).

## Validator / test commands (discovered from repository)

- `python3 tests/static_verify_game.py` — expected `RESULT: CLEAN (36 ok, 0 fail)`.
- `python3 tools/validate_methodology.py` — expected `VALIDATION PASSED`.
- Godot headless foundation gate (Godot binary required): `/root/godot/Godot_v4.7.2-stable_linux.arm64 --headless --path /black-vector/game --scene scenes/slice/foundation_self_check.tscn --time-limit 8` — expected `TOTAL: 10 pass / 0 fail`, exit 0.
- No native Android verification is possible in the development environment (no editor, no device, no emulator). Per `tests/README.md`: "Static analysis never proves runtime behavior"; runtime/device QA remains a gated manual item (touch dual-thumb, keyboard/controller function, camera follow, GL device boot).

## Development startup (where known)

- Engine binary: `/root/godot/Godot_v4.7.2-stable_linux.arm64`.
- Project file: `game/project.godot`; main scene `res://scenes/slice/slice_main.tscn`.
- Headless project path: `--path /black-vector/game`.
- Slice test scene: `game/scenes/slice/foundation_self_check.tscn` (10 deterministic checks).

## Files excluded from Git (and why)

| Pattern | Reason |
|---|---|
| `.godot/` | Godot editor / import cache (generated, reproducible) |
| `game/build/` | build output directory |
| `*.apk`, `*.aab`, `*.tmp` | build artifacts |
| `.DS_Store`, `Thumbs.db`, `desktop.ini` | OS metadata |

`game/.godot` is covered by the `.godot/` rule (gitignore matches at any depth). No file is deleted from disk; they simply stay out of Git.

## Git LFS

Not used and not required. Largest tracked file is 0.2 MB (`doctrine/BLACK_VECTOR_DOCTRINE.md`); total working tree 2.8 MB; no file exceeds 50 MB; no symlinks. No LFS patterns.

## Pre-commit verification (VERIFIED on this tree)

- static (tests/static_verify_game.py): CLEAN 36/0
- methodology (tools/validate_methodology.py): PASSED (2 governing + 36 BV skills, 6 SOPs, registry, gameplay confined to game/)
- foundation gate (Godot headless): 10/10 PASS, exit 0
- STEP 11 runtime probe: historically 51/51 PASS ×2 deterministic; throwaway probe file removed per documented artifact rebuild recipe (`rsync --exclude '.godot' --exclude '_probe*'`), so not re-runnable in this environment. No code changed since STEP 11 acceptance.

## Remaining known future work

- D031 — Season 1 playable narrative / reveal / production spine (NOT YET COMPLETE).
- D032 — Production Sprint 1: Prologue Foundation (HALF-LIGHT) + S-1 Strand → Gyle Cannery playable build.
- Subsequent production sprints toward the first tablet-playable BLACK VECTOR slice.
- Device runtime QA (touch/keyboard/controller/camera-follow/GL-device boot) remains gated, manual, and out of scope of this repository baseline.

## Notes

- This handoff is a migration only: no redesign, refactor, gameplay code change, canon change, or Godot upgrade was performed.
- The pre-Git backup archive (`/black-vector-pre-git-handoff-<timestamp>.tar.gz`) is retained outside the repository and is not deleted.
