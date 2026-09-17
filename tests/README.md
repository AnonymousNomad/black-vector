# BLACK VECTOR — TESTS

Static (non-runtime) verification for the game project. No Godot binary is available in the development
environment, so the tests in this directory are structural checks only — they verify layout, references,
input-action consistency, and the prohibited-scope scan. Runtime behavior is validated separately in the
Godot Android Editor (SOP-005: static analysis never proves runtime behavior).

Run game static checks:

```
python3 tests/static_verify_game.py
```

Run methodology validation (doctrine/skills/SOP registry):

```
python3 tools/validate_methodology.py
```

Expected result: `RESULT: CLEAN` (or a concrete list of issues).