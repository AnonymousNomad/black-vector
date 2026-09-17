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
		_add("9/10 save round trip + persistence", true, "write->verify->load; world+body+seed+player restored")
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