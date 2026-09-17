class_name SaveStateManager
extends Node

signal save_completed(slot: int)
signal load_completed(slot: int)
signal save_failed(reason: String)
signal load_failed(reason: String)

const MANIFEST_KEY := "black_vector_slice_living_save"
const SCHEMA := 1

var world: WorldStateManager
var player_state: PlayerStateManager
var time_weather: TimeWeatherManager
var pressure: PressureManager
var clock: float = 0.0

func setup(w: WorldStateManager, ps: PlayerStateManager, tw: TimeWeatherManager, pr: PressureManager = null) -> void:
	world = w
	player_state = ps
	time_weather = tw
	pressure = pr

func save_slot(slot: int) -> void:
	DataPaths.ensure_save_dir()
	var manifest := {
		"manifest": MANIFEST_KEY,
		"schema": SCHEMA,
		"seed": world.seed_value,
		"clock": time_weather.hour if time_weather else clock,
		"world": world.snapshot(),
		"player": player_state.snapshot(),
		"pressure": {"resting": pressure.resting} if pressure else {},
	}
	var path := DataPaths.save_path(slot)
	var text := JSON.stringify(manifest, "  ")
	if FileAccess.file_exists(path):
		DirAccess.remove_absolute(path)
	var f := FileAccess.open(path, FileAccess.WRITE)
	if f == null:
		save_failed.emit("open")
		return
	f.store_string(text)
	f.close()
	if not verify_slot(path):
		save_failed.emit("verify")
		return
	save_completed.emit(slot)

func load_slot(slot: int) -> void:
	var path := DataPaths.save_path(slot)
	if not FileAccess.file_exists(path):
		load_failed.emit("missing")
		return
	var text := FileAccess.get_file_as_string(path)
	if text.is_empty():
		load_failed.emit("empty")
		return
	var parsed: Variant = JSON.parse_string(text)
	if not (parsed is Dictionary):
		load_failed.emit("parse")
		return
	var data: Dictionary = parsed
	if data.get("manifest", "") != MANIFEST_KEY:
		load_failed.emit("manifest")
		return
	var player_snap: Dictionary = data.get("player", {})
	var player_seed: int = int(player_snap.get("seed", 0))
	var world_snap: Dictionary = data.get("world", {})
	var loaded_seed: int = int(world_snap.get("seed", 0))
	if player_seed != loaded_seed:
		load_failed.emit("seed_mismatch")
		return
	world.restore(world_snap)
	player_state.restore(player_snap)
	clock = float(data.get("clock", clock))
	if pressure:
		var pres: Dictionary = data.get("pressure", {})
		pressure.resting = bool(pres.get("resting", false))
	load_completed.emit(slot)

func verify_slot(path: String) -> bool:
	var text := FileAccess.get_file_as_string(path)
	if text.is_empty():
		return false
	var parsed: Variant = JSON.parse_string(text)
	if not (parsed is Dictionary):
		return false
	return (parsed as Dictionary).get("manifest", "") == MANIFEST_KEY