extends Node

const CHECK_SLOT := 254
const MANIFEST_KEY := "black_vector_slice_living_save"

var _results: Array[Dictionary] = []
var _label: Label

func _ready() -> void:
	var slice := load("res://scenes/slice/slice_main.tscn")
	if slice:
		add_child(slice.instantiate())
	await get_tree().process_frame
	await get_tree().process_frame
	_build_ui()
	await _run_checks()
	_report()

func _build_ui() -> void:
	var layer := CanvasLayer.new()
	layer.name = "SelfCheckUI"
	add_child(layer)
	_label = Label.new()
	_label.name = "ResultLabel"
	_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_label.add_theme_color_override("font_color", Color(1.0, 0.95, 0.9, 1.0))
	_label.add_theme_font_size_override("font_size", 16)
	layer.add_child(_label)

func _add(name: String, ok: bool, detail: String) -> void:
	_results.append({
		"name": name,
		"ok": ok,
		"detail": detail,
	})
	print("SELF-CHECK [%s] %s: %s" % ["PASS" if ok else "FAIL", name, detail])

func _run_checks() -> void:
	_check_boot()
	_check_main_scene()
	_check_autoloads()
	_check_input_abstraction()
	_check_touch_harness()
	_check_keyboard_controller()
	_check_game_world()
	_check_camera_structure()
	await _check_save_round_trip()
	_check_gl_compat()
	_check_d032_cannery()
	_check_d032_kit()
	_check_d032_narrative()
	_check_d032_presence()
	_check_d032_firearm_absent()
	_check_d032_power()
	_check_d032_dependency()
	_check_d032_heat_off()
	_check_d032_deepgate()
	_check_d032_restore_marker()

func _check_boot() -> void:
	_add("1 project boot", true, "Godot %s" % Engine.get_version_info()["string"])

func _check_main_scene() -> void:
	var main_scene: String = ProjectSettings.get_setting("application/run/main_scene", "")
	if main_scene == "res://scenes/slice/slice_main.tscn":
		_add("2 main scene", true, main_scene)
	else:
		_add("2 main scene", false, main_scene)

func _check_autoloads() -> void:
	var root := get_tree().root
	var im := root.get_node_or_null("InputManager")
	var settings := root.get_node_or_null("Settings")
	if im and settings:
		_add("3 autoloads", true, "InputManager + Settings")
	else:
		_add("3 autoloads", false, "InputManager missing=%s Settings missing=%s" % [im == null, settings == null])

func _check_input_abstraction() -> void:
	var map := AbstractActionMap.new()
	var declared: PackedStringArray = InputMap.get_actions()
	var missing: Array[String] = []
	for action in map.all_actions():
		if not action in declared:
			missing.append(action)
	var root := get_tree().root
	var im := root.get_node_or_null("InputManager")
	var touch := im.get_node_or_null("TouchInputAdapter") if im else null
	if missing.is_empty() and touch != null:
		_add("4 input abstraction", true, "all %d abstract actions bound; touch adapter live" % map.all_actions().size())
	else:
		_add("4 input abstraction", false, "missing actions=%s touch=%s" % [missing, touch != null])

func _check_touch_harness() -> void:
	_add("5 touch movement", true, "adapter injected; live-finger test is manual (run on device with both thumbs)")

func _check_keyboard_controller() -> void:
	var root := get_tree().root
	var im := root.get_node_or_null("InputManager")
	var kb_ok := im != null and im.get_node_or_null("KeyboardAdapter") != null
	var ctrl_ok := im != null and im.get_node_or_null("ControllerAdapter") != null
	if kb_ok and ctrl_ok:
		_add("6 keyboard/controller", true, "adapters present; functional test manual")
	else:
		_add("6 keyboard/controller", false, "keyboard=%s controller=%s" % [kb_ok, ctrl_ok])

func _check_game_world() -> void:
	var gw := get_tree().get_first_node_in_group("game_world")
	if gw == null:
		_add("7 game world", false, "no GameWorld in tree")
		return
	var ws: WorldStateManager = gw.get_node_or_null("WorldState") as WorldStateManager
	if ws == null:
		_add("7 game world", false, "WorldState missing")
		return
	_add("7 game world", true, "GameWorld + WorldState live (seed=%s)" % str(ws.seed_value))

func _check_camera_structure() -> void:
	var player := get_tree().get_first_node_in_group("player") as Node3D
	if player == null:
		_add("8 camera structure", false, "no player node")
		return
	var cam := player.get_node_or_null("CameraRig")
	if cam == null:
		_add("8 camera structure", false, "CameraRig missing on player")
		return
	_add("8 camera structure", true, "CameraRig present on player (follow test manual)")

func _check_save_round_trip() -> void:
	var gw := get_tree().get_first_node_in_group("game_world")
	if gw == null:
		_add("9/10 save round trip + persistence", false, "no GameWorld")
		return
	var save_state: SaveStateManager = gw.get_node_or_null("SaveState") as SaveStateManager
	var ws: WorldStateManager = gw.get_node_or_null("WorldState") as WorldStateManager
	var ps: PlayerStateManager = gw.get_node_or_null("PlayerState") as PlayerStateManager
	if save_state == null or ws == null or ps == null:
		_add("9/10 save round trip + persistence", false, "managers missing")
		return
	var ready_body := get_tree().get_first_node_in_group("player") as CharacterBody3D
	if ready_body == null:
		_add("9/10 save round trip + persistence", false, "no player node for readiness")
		return
	const READY_TIMEOUT_FRAMES := 240
	var ready_frames := 0
	while not ready_body.is_on_floor() and ready_frames < READY_TIMEOUT_FRAMES:
		await get_tree().physics_frame
		ready_frames += 1
	if not ready_body.is_on_floor():
		_add("9/10 save round trip + persistence", false,
			"readiness timeout: player not on floor after %d physics frames" % READY_TIMEOUT_FRAMES)
		return
	var before_world: Dictionary = ws.call("snapshot").duplicate(true)
	var before_body: Dictionary = ps.snapshot()["body"].duplicate(true)
	var before_pos: Vector3 = ps.position
	save_state.save_slot(CHECK_SLOT)
	var path := DataPaths.save_path(CHECK_SLOT)
	if not FileAccess.file_exists(path):
		_add("9/10 save round trip + persistence", false, "save file not created")
		return
	var parse_v: Variant = JSON.parse_string(FileAccess.get_file_as_string(path))
	if not (parse_v is Dictionary) or (parse_v as Dictionary).get("manifest", "") != MANIFEST_KEY:
		_add("9/10 save round trip + persistence", false, "save file manifest invalid")
		return
	save_state.load_slot(CHECK_SLOT)
	var after_world: Dictionary = ws.call("snapshot")
	var after_body: Dictionary = ps.snapshot()["body"]
	var values_match := _channel_values(before_world) == _channel_values(after_world)
	var body_match := _body_match(before_body, after_body)
	var seed_match := int(before_world.get("seed", -1)) == int(after_world.get("seed", -2))
	var pos_restored := ps.position.distance_to(before_pos) < 0.001
	await get_tree().process_frame
	var player := get_tree().get_first_node_in_group("player") as Node3D
	var relocated := player != null and player.global_position.distance_to(before_pos) < 0.5
	if values_match and body_match and seed_match and pos_restored and relocated:
		_add("9/10 save round trip + persistence", true, "readiness is_on_floor in %d physics frames; write->verify->load; world+body+seed+player restored" % ready_frames)
	else:
		_add("9/10 save round trip + persistence", false,
			"values=%s body=%s[%s] seed=%s pos=%s relocated=%s" % [values_match, body_match, _body_diff(before_body, after_body), seed_match, pos_restored, relocated])

func _body_diff(a: Dictionary, b: Dictionary) -> String:
	var parts: Array[String] = []
	for key in a.keys():
		if not b.has(key) or not _band_equal(a[key], b[key]):
			parts.append("%s:%s->%s" % [key, str(a.get(key)), str(b.get(key))])
	for key in b.keys():
		if not a.has(key):
			parts.append("%s:missing->%s" % [key, str(b[key])])
	return ",".join(parts)

func _band_equal(a: Variant, b: Variant) -> bool:
	return absf(float(a) - float(b)) <= 0.000001

func _body_match(a: Dictionary, b: Dictionary) -> bool:
	if a.size() != b.size():
		return false
	for key in a.keys():
		if not b.has(key) or not _band_equal(a[key], b[key]):
			return false
	return true

func _check_gl_compat() -> void:
	var renderer: String = ProjectSettings.get_setting("rendering/renderer/rendering_method", "")
	if renderer == "gl_compatibility":
		_add("10 gl compatibility", true, renderer)
	else:
		_add("10 gl compatibility", false, renderer)

func _check_d032_cannery() -> void:
	var gw := get_tree().get_first_node_in_group("game_world")
	if gw == null:
		_add("11 D032 cannery structure", false, "no GameWorld")
		return
	var state: CanneryState = gw.get_node_or_null("CanneryState") as CanneryState
	var beats: BeatStaging = gw.get_node_or_null("BeatStaging") as BeatStaging
	var cannery := gw.get_node_or_null("GyleCannery")
	var door := cannery.get_node_or_null("EntryDoor") if cannery else null
	var light := cannery.get_node_or_null("InteriorLight") if cannery else null
	var switch_node := cannery.get_node_or_null("LightSwitch") if cannery else null
	var gate := cannery.get_node_or_null("DeepGate") if cannery else null
	var ok := state != null and beats != null and cannery != null
	ok = ok and door != null and light != null and switch_node != null and gate != null
	if ok:
		_add("11 D032 cannery structure", true, "CanneryState+BeatStaging+EntryDoor+InteriorLight+LightSwitch+DeepGate present")
	else:
		_add("11 D032 cannery structure", false,
			"state=%s beats=%s cannery=%s door=%s light=%s switch=%s gate=%s" % [state != null, beats != null, cannery != null, door != null, light != null, switch_node != null, gate != null])

func _check_d032_kit() -> void:
	var gw := get_tree().get_first_node_in_group("game_world")
	if gw == null:
		_add("12 D032 starting kit", false, "no GameWorld")
		return
	var ps: PlayerStateManager = gw.get_node_or_null("PlayerState") as PlayerStateManager
	if ps == null:
		_add("12 D032 starting kit", false, "no PlayerState")
		return
	var equipment := ps.equipment
	var weapon: Dictionary = equipment.get(FieldItem.SLOT_WEAPON, {})
	var ammo: Dictionary = equipment.get(FieldItem.SLOT_AMMO, {})
	var photo: Dictionary = equipment.get(FieldItem.SLOT_PERSONAL, {})
	var knife: Dictionary = equipment.get(FieldItem.SLOT_TOOL, {})
	var weapon_ok: bool = weapon.get("id", "") == "sidearm" and weapon.get("hooks", []) == ["INSPECT"]
	var ammo_ok: bool = ammo.get("id", "") == "magazines"
	var photo_ok: bool = photo.get("id", "") == "photograph" and photo.get("hooks", []) == ["INSPECT"]
	var knife_ok: bool = knife.get("id", "") == "boot_knife"
	var equipped_ok := ps.equipped_slot == FieldItem.SLOT_TOOL
	if weapon_ok and ammo_ok and photo_ok and knife_ok and equipped_ok:
		_add("12 D032 starting kit", true, "sidearm(INSPECT)+magazines+photograph(INSPECT)+boot_knife equipped")
	else:
		_add("12 D032 starting kit", false,
			"weapon=%s ammo=%s photo=%s knife=%s equipped=%s" % [weapon_ok, ammo_ok, photo_ok, knife_ok, equipped_ok])

func _check_d032_narrative() -> void:
	var gw := get_tree().get_first_node_in_group("game_world")
	if gw == null:
		_add("13 D032 narrative keys", false, "no GameWorld")
		return
	var nc: NarrativeChannels = gw.get_node_or_null("Narrative") as NarrativeChannels
	if nc == null:
		_add("13 D032 narrative keys", false, "no NarrativeChannels")
		return
	var keys := [
		"inner_strand_awakening",
		"inner_photograph",
		"inner_cannery_unsealed",
		"reality_gyle_cannery",
	]
	var missing: Array[String] = []
	for k in keys:
		if nc.text_for(k) == k:
			missing.append(k)
	if missing.is_empty():
		_add("13 D032 narrative keys", true, "4 D031 keys present")
	else:
		_add("13 D032 narrative keys", false, "missing: %s" % ", ".join(missing))

func _check_d032_presence() -> void:
	var found := false
	for p in get_tree().get_nodes_in_group("human_presence"):
		if str(p.get("presence_id")) == "presence_f1":
			found = true
			break
	if found:
		_add("14 D032 presence_f1", true, "presence_f1 live in human_presence group")
	else:
		_add("14 D032 presence_f1", false, "presence_f1 not found")

func _scan_scripts_for(banned: Array[String]) -> Array[String]:
	var hits: Array[String] = []
	var dir := DirAccess.open("res://scripts")
	if dir == null:
		return hits
	_scan_dir_r(dir, banned, hits)
	return hits

func _scan_dir_r(dir: DirAccess, banned: Array[String], hits: Array[String]) -> void:
	dir.list_dir_begin()
	var entry := dir.get_next()
	while entry != "":
		if dir.current_is_dir():
			if entry != "." and entry != "..":
				var sub := DirAccess.open("%s/%s" % [dir.get_current_dir(), entry])
				if sub:
					_scan_dir_r(sub, banned, hits)
		elif entry.ends_with(".gd"):
			var path := "%s/%s" % [dir.get_current_dir(), entry]
			var txt := FileAccess.get_file_as_string(path)
			var line_no := 0
			for line in txt.split("\n"):
				line_no += 1
				var trimmed := line.strip_edges()
				if trimmed.begins_with("static "):
					trimmed = trimmed.substr(7).strip_edges()
				for pat in banned:
					if trimmed.begins_with(pat):
						hits.append("%s:%d: %s" % [path, line_no, line.strip_edges()])
		entry = dir.get_next()
	dir.list_dir_end()

func _check_d032_firearm_absent() -> void:
	var hits := _scan_scripts_for(["func fire", "func shoot"])
	if hits.is_empty():
		_add("15 D032 firearm absent", true, "no fire/shoot function definitions in res://scripts")
	else:
		_add("15 D032 firearm absent", false, hits[0])

func _d032_cannery_root() -> Node:
	var gw := get_tree().get_first_node_in_group("game_world")
	return gw.get_node_or_null("GyleCannery") if gw else null

func _check_d032_power() -> void:
	var gw := get_tree().get_first_node_in_group("game_world")
	var cannery: CanneryState = gw.get_node_or_null("CanneryState") as CanneryState if gw else null
	var ws: WorldStateManager = gw.get_node_or_null("WorldState") as WorldStateManager if gw else null
	if cannery == null or ws == null:
		_add("16 D032 S-3 power contract", false, "CanneryState/WorldState missing")
		return
	var unpowered := not cannery.is_powered() and not ws.object_state("f1_gyle_cannery_power").has("powered")
	_add("16 D032 S-3 power contract", unpowered,
		"canonical f1_gyle_cannery_power initial=%s owner=CanneryState" % ("UNPOWERED" if unpowered else "POWERED"))

func _check_d032_dependency() -> void:
	var gw := get_tree().get_first_node_in_group("game_world")
	var ws: WorldStateManager = gw.get_node_or_null("WorldState") as WorldStateManager if gw else null
	var cannery := _d032_cannery_root()
	var mach: Node = cannery.get_node_or_null("Machinery01") if cannery else null
	if ws == null or mach == null:
		_add("17 D032 S-3 dependency", false, "WorldState/Machinery01 missing")
		return
	var fuel_collected := ws.object_state("f1_cannery_fuel").has("collect")
	var ok: bool = str(mach.get("object_id")) == "f1_cannery_machinery_01" \
		and not fuel_collected and mach.is_in_group("context_inspect") and not mach.is_in_group("context_restore")
	_add("17 D032 S-3 dependency", ok,
		"machinery object_id=%s fuel_collected=%s inspect=%s restore=%s" % [
			str(mach.get("object_id")), fuel_collected, mach.is_in_group("context_inspect"), mach.is_in_group("context_restore")])

func _check_d032_heat_off() -> void:
	var cannery := _d032_cannery_root()
	var mach: Node = cannery.get_node_or_null("Machinery01") if cannery else null
	var light: OmniLight3D = cannery.get_node_or_null("InteriorLight") as OmniLight3D if cannery else null
	if mach == null or light == null:
		_add("18 D032 S-3 unpowered projection", false, "Machinery01/InteriorLight missing")
		return
	var ok: bool = not mach.is_in_group("shelter_zone") and float(mach.get("shelter_radius")) == 0.0 and not light.visible
	_add("18 D032 S-3 unpowered projection", ok,
		"heat_zone=%s shelter_radius=%.1f light_visible=%s" % [
			mach.is_in_group("shelter_zone"), float(mach.get("shelter_radius")), light.visible])

func _check_d032_deepgate() -> void:
	var gw := get_tree().get_first_node_in_group("game_world")
	var ws: WorldStateManager = gw.get_node_or_null("WorldState") as WorldStateManager if gw else null
	var cannery := _d032_cannery_root()
	var gate: Node = cannery.get_node_or_null("DeepGate") if cannery else null
	var deep: OmniLight3D = cannery.get_node_or_null("DeepBayLight") as OmniLight3D if cannery else null
	if ws == null or gate == null or deep == null:
		_add("19 D032 S-3 deep gate sealed", false, "WorldState/DeepGate/DeepBayLight missing")
		return
	var ok: bool = gate.is_in_group("context_inspect") and not gate.is_in_group("context_open") \
		and not ws.object_state("f1_gyle_cannery_gate").has("open") \
		and int(gate.get("collision_layer")) == 1 and not deep.visible
	_add("19 D032 S-3 deep gate sealed", ok,
		"inspect=%s open=%s layer=%d deep_light=%s" % [
			gate.is_in_group("context_inspect"), gate.is_in_group("context_open"), int(gate.get("collision_layer")), deep.visible])

func _check_d032_restore_marker() -> void:
	var gw := get_tree().get_first_node_in_group("game_world")
	var ws: WorldStateManager = gw.get_node_or_null("WorldState") as WorldStateManager if gw else null
	if ws == null:
		_add("20 D032 S-3 restore marker", false, "no WorldState")
		return
	var ok: bool = not ws.has_seen("f1_gyle_cannery_first_restore") \
		and not ws.object_state("f1_cannery_signature").has("heat_light")
	_add("20 D032 S-3 restore marker", ok,
		"first_restore_seen=%s signature=%s" % [
			ws.has_seen("f1_gyle_cannery_first_restore"), ws.object_state("f1_cannery_signature").has("heat_light")])

func _channel_values(snap: Dictionary) -> Dictionary:
	var out := {}
	for key in ["time", "weather", "facility", "aftermath", "wildlife"]:
		out[key] = snap.get(key)
	return out

func _report() -> void:
	var passed := 0
	var failed := 0
	var lines: Array[String] = ["FOUNDATION SELF-CHECK"]
	for result in _results:
		var tag: String = "PASS" if result["ok"] else "FAIL"
		if result["ok"]:
			passed += 1
		else:
			failed += 1
		lines.append("%s  %s  (%s)" % [tag, result["name"], result["detail"]])
	lines.append("TOTAL: %d pass / %d fail" % [passed, failed])
	_label.text = "\n".join(lines)
	print("=== %s ===" % lines[-1])
	if failed == 0:
		print("SELF-CHECK RESULT: FOUNDATION PASSES (deterministic checks). Manual items remaining: touch/keyboard/controller/camera-follow.")
	else:
		print("SELF-CHECK RESULT: FAILURES PRESENT — STOP, repair only the failed boundary, then rerun.")
	_label.visible = true
	if DisplayServer.get_name() == "headless":
		get_tree().quit(0 if failed == 0 else 1)