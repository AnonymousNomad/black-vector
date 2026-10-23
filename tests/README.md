# BLACK VECTOR — verification workflow

Run checks from `/workspace/black-vector`. The cloud onboarding install script provides the pinned Godot 4.7.2 runtime at `/tmp/black-vector-toolchain/godot-4.7.2/Godot_v4.7.2-stable_linux.x86_64` and verifies its official archive SHA-512 before extraction.

Initialize writable runtime paths and run the repository checks:

```sh
export GODOT_BIN=/tmp/black-vector-toolchain/godot-4.7.2/Godot_v4.7.2-stable_linux.x86_64
export XDG_DATA_HOME=/tmp/black-vector-runtime/data
export XDG_CACHE_HOME=/tmp/black-vector-runtime/cache
export XDG_CONFIG_HOME=/tmp/black-vector-runtime/config
export XDG_STATE_HOME=/tmp/black-vector-runtime/state
export FONTCONFIG_CACHE_HOME=/tmp/black-vector-runtime/fontconfig
mkdir -p "$XDG_DATA_HOME" "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_STATE_HOME" "$FONTCONFIG_CACHE_HOME"

python3 tests/static_verify_game.py
python3 tools/validate_methodology.py
"$GODOT_BIN" --headless --editor --path game --quit
"$GODOT_BIN" --headless --path game res://scenes/slice/foundation_self_check.tscn
"$GODOT_BIN" --headless --path game res://scenes/slice/human_routine_check.tscn
```

The foundation scene runs deterministic runtime checks and reports its exact total. Touch, controller, and other interactive hardware checks are listed separately in the output and remain manual.

## Cold process restart

The restart fixture writes and reads reserved slot 254 from separate Godot processes. Use an isolated user-data directory so it cannot touch a developer save:

```sh
export XDG_DATA_HOME=/tmp/black-vector-cold-restart/data
export XDG_CACHE_HOME=/tmp/black-vector-cold-restart/cache
export XDG_CONFIG_HOME=/tmp/black-vector-cold-restart/config
export XDG_STATE_HOME=/tmp/black-vector-cold-restart/state
export FONTCONFIG_CACHE_HOME=/tmp/black-vector-cold-restart/fontconfig
mkdir -p "$XDG_DATA_HOME" "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_STATE_HOME" "$FONTCONFIG_CACHE_HOME"
BV_COLD_RESTART_MODE=WRITE "$GODOT_BIN" --headless --path game res://scenes/slice/foundation_self_check.tscn
BV_COLD_RESTART_MODE=READ "$GODOT_BIN" --headless --path game res://scenes/slice/foundation_self_check.tscn
```

The second process verifies restored player and human transforms, world state, awareness/contact state, clock, and one-shot cannery events. Keep the same isolated `XDG_DATA_HOME` for both runs.
