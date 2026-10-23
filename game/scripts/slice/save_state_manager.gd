class_name SaveStateManager
extends Node

signal save_completed(slot: int)
signal load_completed(slot: int)
signal save_failed(reason: String)
signal load_failed(reason: String)
signal snapshot_requested

const MANIFEST_KEY := "black_vector_slice_living_save"
const SCHEMA := DataPaths.SAVE_SCHEMA_VERSION

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
	snapshot_requested.emit()
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
	var temp_path := path + ".tmp"
	var temp_absolute := ProjectSettings.globalize_path(temp_path)
	if FileAccess.file_exists(temp_path):
		DirAccess.remove_absolute(temp_absolute)
	var text := JSON.stringify(manifest, "  ")
	var f := FileAccess.open(temp_path, FileAccess.WRITE)
	if f == null:
		save_failed.emit("open")
		return
	f.store_string(text)
	f.flush()
	f.close()
	if not verify_slot(temp_path):
		DirAccess.remove_absolute(temp_absolute)
		save_failed.emit("verify")
		return
	if not _replace_slot(temp_path, path):
		if FileAccess.file_exists(temp_path):
			DirAccess.remove_absolute(temp_absolute)
		save_failed.emit("replace")
		return
	save_completed.emit(slot)

func load_slot(slot: int) -> void:
	var path := DataPaths.save_path(slot)
	var backup_path := path + ".bak"
	var source := path
	var error := _slot_error(path)
	if error != "":
		var backup_error := _slot_error(backup_path)
		if backup_error == "":
			source = backup_path
		else:
			load_failed.emit("%s:%s" % [error, backup_error])
			return
	var data: Dictionary = _read_slot(source)["data"]
	var player_snap: Dictionary = data.get("player", {})
	var world_snap: Dictionary = data["world"]
	world.restore(world_snap)
	player_state.restore(player_snap)
	clock = float(data.get("clock", clock))
	world.clock_hour = clock
	if time_weather:
		time_weather.restore_clock(clock, world.channel_value(WorldStateManager.CHANNEL_WEATHER))
	if pressure:
		var pres: Dictionary = data.get("pressure", {})
		pressure.resting = bool(pres.get("resting", false))
	load_completed.emit(slot)

func verify_slot(path: String) -> bool:
	return _slot_error(path) == ""

func _replace_slot(temp_path: String, path: String) -> bool:
	var temp_absolute := ProjectSettings.globalize_path(temp_path)
	var target_absolute := ProjectSettings.globalize_path(path)
	if DirAccess.rename_absolute(temp_absolute, target_absolute) == OK:
		return true
	var backup_path := path + ".bak"
	var backup_absolute := ProjectSettings.globalize_path(backup_path)
	if FileAccess.file_exists(backup_path):
		DirAccess.remove_absolute(backup_absolute)
	var had_previous := FileAccess.file_exists(path)
	if had_previous and DirAccess.rename_absolute(target_absolute, backup_absolute) != OK:
		return false
	if DirAccess.rename_absolute(temp_absolute, target_absolute) != OK:
		if had_previous and FileAccess.file_exists(backup_path):
			DirAccess.rename_absolute(backup_absolute, target_absolute)
		return false
	if had_previous and FileAccess.file_exists(backup_path):
		DirAccess.remove_absolute(backup_absolute)
	return true

func _slot_error(path: String) -> String:
	if not FileAccess.file_exists(path):
		return "missing"
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return "open"
	var text := file.get_as_text()
	file.close()
	if text.is_empty():
		return "empty"
	var parser := JSON.new()
	if parser.parse(text) != OK or not parser.data is Dictionary:
		return "parse"
	return _manifest_error(parser.data as Dictionary)

func _read_slot(path: String) -> Dictionary:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return {"data": {}}
	var parser := JSON.new()
	var parse_error := parser.parse(file.get_as_text())
	file.close()
	return {"data": parser.data as Dictionary if parse_error == OK and parser.data is Dictionary else {}}

func _manifest_error(data: Dictionary) -> String:
	if str(data.get("manifest", "")) != MANIFEST_KEY:
		return "manifest"
	if not _is_integer_number(data.get("schema")) or int(data["schema"]) not in [1, SCHEMA]:
		return "schema"
	var world_snap: Variant = data.get("world")
	var player_snap: Variant = data.get("player")
	if not world_snap is Dictionary or not player_snap is Dictionary:
		return "state_shape"
	if not _valid_world_snapshot(world_snap as Dictionary):
		return "world_shape"
	if int(data["schema"]) >= 2 and not (world_snap as Dictionary).has("presence_records"):
		return "world_shape"
	if not _valid_player_snapshot(player_snap as Dictionary):
		return "player_shape"
	if int((world_snap as Dictionary).get("seed", -1)) != int((player_snap as Dictionary).get("seed", -2)):
		return "seed_mismatch"
	if typeof(data.get("clock")) not in [TYPE_INT, TYPE_FLOAT]:
		return "clock"
	var pressure_data: Variant = data.get("pressure", {})
	if not pressure_data is Dictionary:
		return "pressure_shape"
	if (pressure_data as Dictionary).has("resting") and typeof((pressure_data as Dictionary)["resting"]) != TYPE_BOOL:
		return "pressure_shape"
	return ""

func _valid_world_snapshot(snap: Dictionary) -> bool:
	if not _is_integer_number(snap.get("seed")):
		return false
	for key in ["time", "weather", "facility", "aftermath", "wildlife"]:
		if typeof(snap.get(key)) != TYPE_STRING:
			return false
	var container_types := {
		"objects": TYPE_DICTIONARY,
		"observations": TYPE_DICTIONARY,
		"pois": TYPE_DICTIONARY,
		"field_record": TYPE_ARRAY,
		"traces": TYPE_ARRAY,
		"routes": TYPE_ARRAY,
		"human_records": TYPE_DICTIONARY,
		"awareness_records": TYPE_DICTIONARY,
		"contact_records": TYPE_DICTIONARY,
		"narrative_seen": TYPE_DICTIONARY,
	}
	for key in container_types:
		if typeof(snap.get(key)) != int(container_types[key]):
			return false
	if not _valid_boolean_records(snap["objects"]) \
			or not _valid_string_records(snap["observations"]) \
			or not _valid_poi_records(snap["pois"]) \
			or not _valid_field_records(snap["field_record"]) \
			or not _valid_trace_records(snap["traces"]) \
			or not _valid_route_records(snap["routes"]) \
			or not _valid_human_records(snap["human_records"]) \
			or not _valid_awareness_records(snap["awareness_records"]) \
			or not _valid_contact_records(snap["contact_records"]) \
			or not _valid_boolean_map(snap["narrative_seen"]):
		return false
	return not snap.has("presence_records") or _valid_presence_records(snap["presence_records"])

func _valid_player_snapshot(snap: Dictionary) -> bool:
	if not _is_integer_number(snap.get("seed")) or not _is_vector_array(snap.get("position")) or not _is_vector_array(snap.get("checkpoint")):
		return false
	var body: Variant = snap.get("body")
	var equipment: Variant = snap.get("equipment")
	if not body is Dictionary or not equipment is Dictionary or typeof(snap.get("equipped_slot")) != TYPE_STRING:
		return false
	for band in PlayerStateManager.BODY_BANDS:
		if not _is_number((body as Dictionary).get(band)):
			return false
	for item in (equipment as Dictionary).values():
		if not item is Dictionary or not _valid_equipment_item(item as Dictionary):
			return false
	return true

func _valid_boolean_records(value: Variant) -> bool:
	if not value is Dictionary:
		return false
	for record in (value as Dictionary).values():
		if not record is Dictionary:
			return false
		for flag in (record as Dictionary).values():
			if typeof(flag) != TYPE_BOOL:
				return false
	return true

func _valid_boolean_map(value: Variant) -> bool:
	if not value is Dictionary:
		return false
	for entry in (value as Dictionary).values():
		if typeof(entry) != TYPE_BOOL:
			return false
	return true

func _valid_string_records(value: Variant) -> bool:
	if not value is Dictionary:
		return false
	for entry in (value as Dictionary).values():
		if typeof(entry) != TYPE_STRING:
			return false
	return true

func _valid_poi_records(value: Variant) -> bool:
	for record in (value as Dictionary).values():
		if not record is Dictionary:
			return false
		var item := record as Dictionary
		if typeof(item.get("kind")) != TYPE_STRING \
				or not _is_vector_array(item.get("position")) \
				or not _is_number(item.get("distance")) \
				or not _is_number(item.get("bearing")) \
				or typeof(item.get("time")) != TYPE_STRING:
			return false
	return true

func _valid_field_records(value: Variant) -> bool:
	for record in (value as Array):
		if not record is Dictionary:
			return false
		var item := record as Dictionary
		if typeof(item.get("kind")) != TYPE_STRING \
				or typeof(item.get("subject")) != TYPE_STRING \
				or typeof(item.get("detail")) != TYPE_STRING \
				or not _is_vector_array(item.get("position")) \
				or typeof(item.get("time")) != TYPE_STRING:
			return false
	return true

func _valid_trace_records(value: Variant) -> bool:
	for record in (value as Array):
		if not record is Dictionary:
			return false
		var item := record as Dictionary
		if typeof(item.get("kind")) != TYPE_STRING \
				or not _is_vector_array(item.get("position")) \
				or not _is_number(item.get("intensity")) \
				or typeof(item.get("detail")) != TYPE_STRING \
				or typeof(item.get("source")) != TYPE_STRING \
				or not _is_number(item.get("hour")):
			return false
	return true

func _valid_route_records(value: Variant) -> bool:
	for record in (value as Array):
		if not record is Dictionary:
			return false
		var item := record as Dictionary
		if typeof(item.get("id")) != TYPE_STRING \
				or not _is_vector_array(item.get("from")) \
				or not _is_vector_array(item.get("to")) \
				or typeof(item.get("classification")) != TYPE_STRING \
				or not _is_number(item.get("disturbance_risk")) \
				or not _is_integer_number(item.get("count")) \
				or not _is_number(item.get("first_hour")) \
				or not _is_number(item.get("last_hour")) \
				or not _is_integer_number(item.get("disturbance")):
			return false
	return true

func _valid_human_records(value: Variant) -> bool:
	for record in (value as Dictionary).values():
		if not record is Dictionary:
			return false
		var item := record as Dictionary
		if not _is_integer_number(item.get("evidence")) or typeof(item.get("level")) != TYPE_STRING:
			return false
		for key in ["first_hour", "last_hour"]:
			if item.has(key) and not _is_number(item[key]):
				return false
	return true

func _valid_awareness_records(value: Variant) -> bool:
	for record in (value as Dictionary).values():
		if not record is Dictionary:
			return false
		var item := record as Dictionary
		if item.is_empty():
			continue
		if typeof(item.get("state", "UNAWARE")) != TYPE_STRING \
				or not HumanAwareness.STATE_NAMES.has(str(item.get("state", "UNAWARE"))):
			return false
		for key in ["last_known_position", "investigation_target"]:
			if item.has(key) and not _is_vector_array(item[key]):
				return false
		for key in ["last_known_time", "evidence_confidence", "suspicion"]:
			if item.has(key) and not _is_number(item[key]):
				return false
		if item.has("evidence_source") and typeof(item["evidence_source"]) != TYPE_STRING:
			return false
	return true

func _valid_contact_records(value: Variant) -> bool:
	for record in (value as Dictionary).values():
		if not record is Dictionary:
			return false
		var item := record as Dictionary
		if item.has("outcome") and (typeof(item["outcome"]) != TYPE_STRING or not ContactManager.STATE_NAMES.has(item["outcome"])):
			return false
		for key in ["position", "last_position"]:
			if item.has(key) and not _is_vector_array(item[key]):
				return false
		for key in ["first_hour", "last_hour"]:
			if item.has(key) and not _is_number(item[key]):
				return false
		for key in ["occurred", "communicated", "withdrew"]:
			if item.has(key) and typeof(item[key]) != TYPE_BOOL:
				return false
	return true

func _valid_presence_records(value: Variant) -> bool:
	for record in (value as Dictionary).values():
		if not record is Dictionary:
			return false
		var item := record as Dictionary
		if item.is_empty():
			continue
		if item.has("position") and not _is_vector_array(item["position"]):
			return false
		if item.has("rotation_y") and not _is_number(item["rotation_y"]):
			return false
		for key in ["posture", "activity", "threat_level", "routine_state"]:
			if item.has(key) and typeof(item[key]) != TYPE_STRING:
				return false
		if item.has("routine_index") and not _is_integer_number(item["routine_index"]):
			return false
		if item.has("routine_dwell_elapsed") and not _is_number(item["routine_dwell_elapsed"]):
			return false
	return true

func _valid_equipment_item(item: Dictionary) -> bool:
	for key in ["id", "slot", "name", "ownership"]:
		if typeof(item.get(key)) != TYPE_STRING:
			return false
	if not _is_number(item.get("condition")):
		return false
	for key in ["history", "hooks"]:
		var entries: Variant = item.get(key)
		if not entries is Array:
			return false
		for entry in entries:
			if typeof(entry) != TYPE_STRING:
				return false
	return true

func _is_vector_array(value: Variant) -> bool:
	if not value is Array or (value as Array).size() != 3:
		return false
	for coordinate in value:
		if not _is_number(coordinate):
			return false
	return true

func _is_number(value: Variant) -> bool:
	return typeof(value) in [TYPE_INT, TYPE_FLOAT] and is_finite(float(value))

func _is_integer_number(value: Variant) -> bool:
	if not _is_number(value):
		return false
	return is_equal_approx(float(value), roundf(float(value)))
