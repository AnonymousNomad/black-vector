extends Node

const CHECK_SLOT := 254
const MANIFEST_KEY := "black_vector_slice_living_save"

var _results: Array[Dictionary] = []
var _label: Label

func _ready() -> void:
	var restart_mode := OS.get_environment("BV_COLD_RESTART_MODE")
	if restart_mode == "WRITE" or restart_mode == "READ":
		call_deferred("_run_cold_restart_probe", restart_mode)
		return
	var slice := load("res://scenes/slice/slice_main.tscn")
	if slice:
		add_child(slice.instantiate())
	await get_tree().process_frame
	await get_tree().process_frame
	_build_ui()
	await _run_checks()
	await _report()

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
	_check_character_presentation_contract()
	await _check_save_round_trip()
	_check_save_failure_recovery()
	_check_gl_compat()
	_check_d032_cannery()
	_check_d032_kit()
	_check_d032_narrative()
	_check_d032_presence()
	_check_f1_routine_contract()
	_check_d032_firearm_absent()
	_check_d032_power()
	_check_d032_dependency()
	await _check_f1_route_choices()
	_check_d032_heat_off()
	_check_d032_deepgate()
	_check_d032_restore_marker()
	_check_d032_light_energy_projection()
	_check_visual_ambient_contract()
	_check_visual_instanced_material_contract()
	_check_terrain_surface_normals()
	_check_mobile_world_quality_profiles()
	_check_perception_integration_contract()
	_check_evidence_identity_persistence()
	_check_combat_physiology_contract()
	await _check_motion_grounding()

func _run_cold_restart_probe(mode: String) -> void:
	var save_path := DataPaths.save_path(CHECK_SLOT)
	if mode == "WRITE":
		for path in [save_path, save_path + ".tmp", save_path + ".bak"]:
			if FileAccess.file_exists(path):
				DirAccess.remove_absolute(ProjectSettings.globalize_path(path))
	var slice_scene := load("res://scenes/slice/slice_main.tscn") as PackedScene
	var instance: Node = slice_scene.instantiate()
	if _has_property(instance, "startup_slot"):
		instance.set("startup_slot", CHECK_SLOT)
	add_child(instance)
	var gw := get_tree().get_first_node_in_group("game_world") as GameWorld
	if gw == null:
		_finish_cold_restart_probe(false, mode, "GameWorld missing")
		return
	if mode == "WRITE":
		var player := get_tree().get_first_node_in_group("player") as Node3D
		var human: HumanPresence
		for node in get_tree().get_nodes_in_group("human_presence"):
			var candidate := node as HumanPresence
			if candidate and candidate.presence_id == "presence_01":
				human = candidate
				break
		if player == null or human == null:
			_finish_cold_restart_probe(false, mode, "player or test presence missing")
			return
		gw.world_state.set_channel(WorldStateManager.CHANNEL_AFTERMATH, "COLD_RESTART_SENTINEL")
		gw.world_state.set_object_flag("cold_restart_fixture", "completed", true)
		gw.world_state.mark_object(CanneryState.DOOR_ID, "open")
		gw.world_state.set_object_flag(CanneryState.FUEL_ID, "collect", true)
		gw.world_state.mark_object(CanneryState.MACHINERY_ID, "restore")
		var persisted_trace_a := gw.world_state.record_trace("SOUND", Vector3(2.0, 0.0, 2.0), 0.4, "kind=FOOTSTEP;surface=SOIL")
		var persisted_trace_b := gw.world_state.record_trace("SOUND", Vector3(2.0, 0.0, 2.0), 0.4, "kind=FOOTSTEP;surface=SOIL")
		var trace_id_a := str(persisted_trace_a.get("id", ""))
		var trace_id_b := str(persisted_trace_b.get("id", ""))
		gw.world_state.set_awareness("presence_01", {
			"state": "TRACKING",
			"last_known_position": [9.0, 0.0, 1.0],
			"last_known_time": 17.25,
			"investigation_target": [9.5, 0.0, 1.2],
			"evidence_source": "SIGHT",
			"evidence_confidence": 0.8,
			"identity_confidence": 0.0,
			"believed_identity": "UNKNOWN",
			"evidence_count": 2,
			"processed_traces": [trace_id_a, trace_id_b],
			"suspicion": 0.7,
		})
		gw.world_state.record_contact("presence_01", {
			"occurred": true,
			"outcome": "FEARFUL",
			"position": [8.0, 0.0, 5.0],
			"last_position": [8.0, 0.0, 5.0],
			"first_hour": 17.25,
			"last_hour": 17.25,
			"communicated": true,
			"withdrew": false,
		})
		var player_position := Vector3(4.0, 1.0, 4.0)
		player.global_position = player_position
		gw.player_state.position = player_position
		var combat := player.get_node_or_null("CombatController")
		if combat != null:
			combat.call("host_event", "hit_taken", 0.1)
		human.global_position = Vector3(8.0, 0.0, 5.0)
		gw.time_weather.hour = 17.25
		gw.world_state.clock_hour = 17.25
		gw.save_state.save_slot(CHECK_SLOT)
		var saved := gw.save_state.verify_slot(save_path)
		_finish_cold_restart_probe(saved, mode, "reserved-slot snapshot %s" % ["verified" if saved else "invalid"])
		return
	var player := get_tree().get_first_node_in_group("player") as Node3D
	var human: HumanPresence
	for node in get_tree().get_nodes_in_group("human_presence"):
		var candidate := node as HumanPresence
		if candidate and candidate.presence_id == "presence_01":
			human = candidate
			break
	var expected_player := Vector3(4.0, 1.0, 4.0)
	var expected_human := Vector3(8.0, 0.0, 5.0)
	var duplicate_opening := 0
	for entry in gw.narrative.log:
		if str(entry.get("id", "")) in ["beat_strand_awakening", "beat_photograph", "beat_cannery_unsealed"]:
			duplicate_opening += 1
	var door_facility_entries := 0
	var restore_signature_entries := 0
	for entry in gw.world_state.field_record:
		if str(entry.get("kind", "")) == "FACILITY" and str(entry.get("subject", "")) == CanneryState.DOOR_ID:
			door_facility_entries += 1
		if str(entry.get("kind", "")) == "SIGNATURE" and str(entry.get("subject", "")) == "f1_gyle_cannery" and str(entry.get("detail", "")) == "heat_light":
			restore_signature_entries += 1
	var restored_awareness := gw.world_state.awareness_record("presence_01")
	var processed_traces: Array = restored_awareness.get("processed_traces", [])
	var restored_trace_ids: Array[String] = []
	for trace in gw.world_state.traces:
		var trace_id := str(trace.get("id", ""))
		if processed_traces.has(trace_id) and not restored_trace_ids.has(trace_id):
			restored_trace_ids.append(trace_id)
	var memory_restored := str(restored_awareness.get("believed_identity", "")) == "UNKNOWN" \
		and is_zero_approx(float(restored_awareness.get("identity_confidence", -1.0))) \
		and int(restored_awareness.get("evidence_count", -1)) == 2 and restored_trace_ids.size() == 2
	var injury_restored := is_equal_approx(gw.player_state.band("INJURY"), 0.14) \
		and is_equal_approx(gw.player_state.band("EXERTION"), 0.1)
	var restored: bool = player != null and human != null \
		and gw.world_state.channel_value(WorldStateManager.CHANNEL_AFTERMATH) == "COLD_RESTART_SENTINEL" \
		and bool(gw.world_state.object_state("cold_restart_fixture").get("completed", false)) \
		and gw.player_state.position.distance_to(expected_player) < 0.05 \
		and player.global_position.distance_to(expected_player) < 0.15 \
		and human.global_position.distance_to(expected_human) < 0.15 \
		and is_equal_approx(gw.time_weather.hour, 17.25) \
		and gw.world_state.awareness_record("presence_01").get("state", "") == "TRACKING" \
		and gw.contact.state_name_for("presence_01") == "FEARFUL" \
		and gw.world_state.object_state(CanneryState.DOOR_ID).has("open") \
		and gw.world_state.object_state(CanneryState.POWER_ID).has("powered") \
		and gw.world_state.object_state(CanneryState.FUEL_ID).has("consumed") \
		and gw.world_state.has_seen("beat_cannery_unsealed") \
		and gw.world_state.has_seen(CanneryState.FIRST_RESTORE_SEEN) \
		and memory_restored and injury_restored \
		and door_facility_entries == 1 and restore_signature_entries == 1 and duplicate_opening == 0
	_finish_cold_restart_probe(restored, mode,
		"world/player/human/awareness/contact/clock/evidence/injury restored=%s/%s; first-open=%d restore=%d; opening replay=%d" % [memory_restored, injury_restored, door_facility_entries, restore_signature_entries, duplicate_opening])

func _finish_cold_restart_probe(ok: bool, mode: String, detail: String) -> void:
	print("COLD RESTART %s [%s]: %s" % [mode, "PASS" if ok else "FAIL", detail])
	_orderly_shutdown.call_deferred(0 if ok else 1)

func _orderly_shutdown(exit_code: int) -> void:
	for audio in get_tree().get_nodes_in_group("wilderness_audio"):
		if audio.has_method("shutdown_audio"):
			audio.call("shutdown_audio")
	await get_tree().create_timer(0.15).timeout
	get_tree().quit(exit_code)

func _has_property(target: Object, property_name: String) -> bool:
	for property in target.get_property_list():
		if str(property.get("name", "")) == property_name:
			return true
	return false

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
	var camera_rig := player.get_node_or_null("CameraRig")
	var camera := player.get_node_or_null("CameraRig/PitchPivot/SpringArm3D/Camera3D") as Camera3D
	var spring_arm := player.get_node_or_null("CameraRig/PitchPivot/SpringArm3D") as SpringArm3D
	if camera_rig == null or camera == null or spring_arm == null:
		_add("8 camera structure", false, "CameraRig/SpringArm/Camera3D missing on player")
		return
	var active := get_viewport().get_camera_3d() == camera
	var distance := camera.global_position.distance_to(player.global_position)
	var to_player := (player.global_position + Vector3.UP - camera.global_position).normalized()
	var forward_alignment := (-camera.global_transform.basis.z).dot(to_player)
	var player_forward := -player.global_transform.basis.z
	var camera_behind := player_forward.dot((camera.global_position - player.global_position).normalized()) <= -0.8
	var visible_framing := active and distance >= 1.5 and forward_alignment >= 0.8 and camera_behind
	_add("8 camera structure", visible_framing,
		"active=%s player_distance=%.2f m forward_alignment=%.2f behind_alignment=%.2f camera_position=%s spring_length=%.2f m hit_length=%.2f m" % [
			active, distance, forward_alignment, player_forward.dot((camera.global_position - player.global_position).normalized()), camera.global_position, spring_arm.spring_length, spring_arm.get_hit_length()])

func _check_character_presentation_contract() -> void:
	var player := get_tree().get_first_node_in_group("player") as Node3D
	var proxy := player.get_node_or_null("CorleyProxy") if player else null
	var contract := player.get_node_or_null("CharacterPresentation") if player else null
	var animation := player.get_node_or_null("AnimationState") if player else null
	if proxy == null or contract == null or animation == null:
		_add("9 character presentation contract", false, "player proxy, contract, or animation state missing")
		return
	var production_status := proxy.has_method("representation_status") \
		and str(proxy.call("representation_status")) == "PRODUCTION_CORLEY" \
		and proxy.is_in_group("production_corley") \
		and not proxy.is_in_group("engineering_proxy")
	var humanoid := proxy.call("humanoid_skeleton") as Skeleton3D if proxy.has_method("humanoid_skeleton") else null
	var animation_names: PackedStringArray = proxy.call("production_animation_names") if proxy.has_method("production_animation_names") else PackedStringArray()
	var required_animations := ["idle", "walk", "jog", "sprint", "air", "crouch", "crouch_walk", "turn", "interaction", "hurt", "recoil", "combat_stance"]
	var clips_present := true
	for animation_name in required_animations:
		clips_present = clips_present and animation_names.has(animation_name)
	var model := proxy.get_node_or_null("ProductionCorleyModel") as Node3D
	var model_meshes := model.find_children("*", "MeshInstance3D", true, false) if model else []
	var skinned_meshes := 0
	for mesh_node in model_meshes:
		var mesh_instance := mesh_node as MeshInstance3D
		if mesh_instance and mesh_instance.skin != null:
			skinned_meshes += 1
	var rigged_model := humanoid != null and humanoid.get_bone_count() >= 18 and clips_present and skinned_meshes >= 1
	var attachment := contract.call("attachment_point", "RIGHT_HAND") as Node3D
	var turn_hook: bool = contract.call("request_turn", Vector3.RIGHT) and str(animation.get("action_state")) == "TURN"
	contract.call("request_interaction")
	var interaction_hook := str(animation.get("action_state")) == "INTERACTION"
	contract.call("request_recoil")
	var recoil_hook := str(animation.get("action_state")) == "RECOIL"
	contract.call("request_hurt", 0.5)
	var hurt_priority := str(animation.get("action_state")) == "HURT"
	contract.call("set_combat_stance", true)
	var combat_hook := bool(contract.get("combat_stance"))
	var clothing_hook: bool = contract.call("set_clothing_state", "OUTER_LAYER", "OPENING_WET_LAYER")
	var injury_hook: bool = contract.call("set_injury_presentation", "LEFT_LEG", 0.4, "WRAPPED")
	var camera := contract.call("camera_anchor") as Node3D
	var collision_authority := contract.call("collision_authority") as CharacterBody3D
	var contract_ok := attachment != null and turn_hook and interaction_hook and recoil_hook and hurt_priority and combat_hook \
		and clothing_hook and injury_hook and camera != null \
		and collision_authority == player and bool(contract.call("has_production_character")) and rigged_model
	_add("9 character presentation contract", production_status and contract_ok,
		"production_status=%s skeleton_bones=%d animation_clips=%d skinned_meshes=%d attachment=%s turn=%s interaction=%s recoil=%s hurt=%s combat=%s clothing=%s injury=%s camera=%s collision_authority=%s production_character=%s" % [
			production_status, humanoid.get_bone_count() if humanoid else 0, animation_names.size(), skinned_meshes, attachment != null, turn_hook, interaction_hook, recoil_hook, hurt_priority, combat_hook, clothing_hook, injury_hook, camera != null, collision_authority == player, contract.call("has_production_character")])
	contract.call("set_combat_stance", false)
	contract.call("set_clothing_state", "OUTER_LAYER", "")
	contract.call("set_injury_presentation", "LEFT_LEG", 0.0, "")
	animation.call("clear_action_if", "HURT")

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
	var before_human: HumanPresence = get_tree().get_first_node_in_group("human_presence") as HumanPresence
	var before_human_position := before_human.global_position if before_human else Vector3.ZERO
	save_state.save_slot(CHECK_SLOT)
	var path := DataPaths.save_path(CHECK_SLOT)
	if not FileAccess.file_exists(path) or not save_state.verify_slot(path):
		_add("9/10 save round trip + persistence", false, "save file missing or failed manifest/state verification")
		return
	var parse_v: Variant = JSON.parse_string(FileAccess.get_file_as_string(path))
	if not (parse_v is Dictionary) or (parse_v as Dictionary).get("manifest", "") != MANIFEST_KEY:
		_add("9/10 save round trip + persistence", false, "save file manifest invalid")
		return
	if before_human:
		before_human.global_position += Vector3(4.0, 0.0, 0.0)
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
	var human_relocated := before_human == null or before_human.global_position.distance_to(before_human_position) < 0.01
	var no_orphan_temp := not FileAccess.file_exists(path + ".tmp")
	if values_match and body_match and seed_match and pos_restored and relocated and human_relocated and no_orphan_temp:
		_add("9/10 save round trip + persistence", true, "readiness is_on_floor in %d physics frames; atomic write->verify->load; world+body+seed+player+human position restored; no temp remains" % ready_frames)
	else:
		_add("9/10 save round trip + persistence", false,
			"values=%s body=%s[%s] seed=%s pos=%s player=%s human=%s[before=%s after=%s] no_temp=%s" % [values_match, body_match, _body_diff(before_body, after_body), seed_match, pos_restored, relocated, human_relocated, before_human_position, before_human.global_position if before_human else Vector3.ZERO, no_orphan_temp])

func _check_save_failure_recovery() -> void:
	var gw := get_tree().get_first_node_in_group("game_world")
	if gw == null:
		_add("10 save rejects incomplete state atomically", false, "no GameWorld")
		return
	var save_state := gw.get_node_or_null("SaveState") as SaveStateManager
	var ws := gw.get_node_or_null("WorldState") as WorldStateManager
	var ps := gw.get_node_or_null("PlayerState") as PlayerStateManager
	if save_state == null or ws == null or ps == null:
		_add("10 save rejects incomplete state atomically", false, "save/world/player manager missing")
		return
	var path := DataPaths.save_path(CHECK_SLOT)
	if not FileAccess.file_exists(path):
		_add("10 save rejects incomplete state atomically", false, "round-trip fixture did not leave a primary save")
		return
	var valid_text := FileAccess.get_file_as_string(path)
	var parsed: Variant = JSON.parse_string(valid_text)
	if not parsed is Dictionary:
		_add("10 save rejects incomplete state atomically", false, "round-trip save did not parse")
		return
	var bad_manifest: Dictionary = (parsed as Dictionary).duplicate(true)
	var bad_player: Dictionary = (bad_manifest.get("player", {}) as Dictionary).duplicate(true)
	bad_player.erase("position")
	bad_manifest["world"]["facility"] = "CORRUPT_SENTINEL"
	bad_manifest["player"] = bad_player
	var invalid_path := ProjectSettings.globalize_path(path)
	var writer := FileAccess.open(invalid_path, FileAccess.WRITE)
	if writer == null:
		_add("10 save rejects incomplete state atomically", false, "cannot create controlled malformed fixture")
		return
	writer.store_string(JSON.stringify(bad_manifest))
	writer.close()
	var malformed_error := str(save_state.call("_slot_error", path))
	var before_world: Dictionary = ws.snapshot().duplicate(true)
	var before_player: Dictionary = ps.snapshot().duplicate(true)
	var failure := {"reason": ""}
	save_state.load_failed.connect(func(reason: String): failure["reason"] = reason)
	var bad_nested: Dictionary = (parsed as Dictionary).duplicate(true)
	var awareness_records: Dictionary = bad_nested["world"]["awareness_records"]
	awareness_records["corrupt_fixture"] = {
		"state": "TRACKING",
		"last_known_position": ["not-a-coordinate", 0.0, 0.0],
	}
	writer = FileAccess.open(invalid_path, FileAccess.WRITE)
	if writer == null:
		_add("10 save rejects incomplete state atomically", false, "cannot create nested corruption fixture")
		return
	writer.store_string(JSON.stringify(bad_nested))
	writer.close()
	var nested_error := str(save_state.call("_slot_error", path))
	save_state.load_slot(CHECK_SLOT)
	var nested_mutation_free := ws.snapshot() == before_world and ps.snapshot() == before_player
	var nested_rejected := str(failure["reason"]) != ""
	failure["reason"] = ""
	writer = FileAccess.open(invalid_path, FileAccess.WRITE)
	if writer == null:
		_add("10 save rejects incomplete state atomically", false, "cannot restore malformed player fixture")
		return
	writer.store_string(JSON.stringify(bad_manifest))
	writer.close()
	save_state.load_slot(CHECK_SLOT)
	var mutation_free := ws.snapshot() == before_world and ps.snapshot() == before_player
	var rejected := str(failure["reason"]) != ""
	var temp_path := path + ".tmp"
	var temp_writer := FileAccess.open(temp_path, FileAccess.WRITE)
	if temp_writer:
		temp_writer.store_string("interrupted write")
		temp_writer.close()
	writer = FileAccess.open(invalid_path, FileAccess.WRITE)
	if writer:
		writer.store_string(valid_text)
		writer.close()
	var restored_error := str(save_state.call("_slot_error", path))
	save_state.load_slot(CHECK_SLOT)
	var expected_world: Dictionary = ws.snapshot().duplicate(true)
	var expected_player: Dictionary = ps.snapshot().duplicate(true)
	ws.set_channel(WorldStateManager.CHANNEL_AFTERMATH, "TEMP_SENTINEL")
	ps.set_band("INJURY", 0.91)
	save_state.load_slot(CHECK_SLOT)
	var temp_ignored := temp_writer != null and FileAccess.file_exists(temp_path) \
		and _channel_values(expected_world) == _channel_values(ws.snapshot()) \
		and _body_match(expected_player["body"], ps.snapshot()["body"])
	DirAccess.remove_absolute(ProjectSettings.globalize_path(temp_path))
	var backup_path := path + ".bak"
	var backup_writer := FileAccess.open(backup_path, FileAccess.WRITE)
	if backup_writer:
		backup_writer.store_string(valid_text)
		backup_writer.close()
	writer = FileAccess.open(invalid_path, FileAccess.WRITE)
	if writer:
		writer.store_string("interrupted replacement")
		writer.close()
	ws.set_channel(WorldStateManager.CHANNEL_AFTERMATH, "BACKUP_SENTINEL")
	ps.set_band("INJURY", 0.84)
	save_state.load_slot(CHECK_SLOT)
	var backup_recovered := backup_writer != null \
		and _channel_values(expected_world) == _channel_values(ws.snapshot()) \
		and _body_match(expected_player["body"], ps.snapshot()["body"])
	var human := get_tree().get_first_node_in_group("human_presence") as HumanPresence
	var legacy_human_start := human.global_position if human else Vector3.ZERO
	var legacy_data: Variant = JSON.parse_string(valid_text)
	var legacy_writer: FileAccess
	var legacy_accepted := false
	var legacy_spawn_restored := false
	if legacy_data is Dictionary and human != null:
		(legacy_data as Dictionary)["schema"] = 1
		((legacy_data as Dictionary)["world"] as Dictionary).erase("presence_records")
		legacy_writer = FileAccess.open(invalid_path, FileAccess.WRITE)
		if legacy_writer:
			legacy_writer.store_string(JSON.stringify(legacy_data))
			legacy_writer.close()
			legacy_accepted = save_state.verify_slot(path)
			human.global_position += Vector3(2.0, 0.0, 0.0)
			save_state.load_slot(CHECK_SLOT)
			legacy_spawn_restored = human.global_position.distance_to(legacy_human_start) < 0.01
	writer = FileAccess.open(invalid_path, FileAccess.WRITE)
	if writer:
		writer.store_string(valid_text)
		writer.close()
	DirAccess.remove_absolute(ProjectSettings.globalize_path(backup_path))
	_add("10 save rejects incomplete state atomically", nested_rejected and nested_mutation_free and rejected and mutation_free and temp_ignored and backup_recovered and legacy_accepted and legacy_spawn_restored,
		"nested_rejected=%s nested_error=%s nested_mutation_free=%s rejected=%s reason=%s malformed=%s restored=%s mutation_free=%s interrupted_temp_ignored=%s backup_recovered=%s schema_v1=%s schema_v1_spawn=%s" % [nested_rejected, nested_error, nested_mutation_free, rejected, failure["reason"], malformed_error, restored_error, mutation_free, temp_ignored, backup_recovered, legacy_accepted, legacy_spawn_restored])

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

func _check_f1_routine_contract() -> void:
	var presence: HumanPresence
	for node in get_tree().get_nodes_in_group("human_presence"):
		var candidate := node as HumanPresence
		if candidate != null and candidate.presence_id == "presence_f1":
			presence = candidate
			break
	if presence == null:
		_add("14b F1 authored routine", false, "presence_f1 missing")
		return
	var work_and_inspect := presence.routine_stops.size() == 2
	var schedule_ok := false
	if work_and_inspect:
		var work := presence.routine_stops[0]
		var inspect := presence.routine_stops[1]
		work_and_inspect = work != null and inspect != null \
			and work.activity == "WORK" and inspect.activity == "INSPECT" \
			and work.active_at(9.0) and inspect.active_at(15.0) \
			and not work.active_at(15.0) and not inspect.active_at(20.0)
		schedule_ok = presence.active_routine_index(9.0) == 0 \
			and presence.active_routine_index(15.0) == 1 and presence.active_routine_index(20.0) == -1
	var ok := presence.routine_enabled and work_and_inspect and schedule_ok \
		and presence.presence_id == "presence_f1" and presence.threat_level == "UNKNOWN"
	_add("14b F1 authored routine", ok,
		"enabled=%s work_inspect=%s schedule=%s identity=%s threat=%s" % [
			presence.routine_enabled, work_and_inspect, schedule_ok, presence.presence_id, presence.threat_level])

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

func _check_f1_route_choices() -> void:
	var game_world := get_tree().get_first_node_in_group("game_world") as GameWorld
	var player := get_tree().get_first_node_in_group("player") as CharacterBody3D
	var cover := game_world.get_node_or_null("GyleCannery/ApproachCoverF1") as Node3D if game_world else null
	var fuel := game_world.get_node_or_null("GyleCannery/ApproachCrate") as Node3D if game_world else null
	var human: HumanPresence
	for candidate in get_tree().get_nodes_in_group("human_presence"):
		if candidate is HumanPresence and candidate.presence_id == "presence_f1":
			human = candidate
			break
	var awareness := human.get_node_or_null("Awareness") as HumanAwareness if human else null
	var vision := human.get_node_or_null("VisionSensor") as VisionSensor if human else null
	var door := game_world.get_node_or_null("GyleCannery/EntryDoor") as StaticBody3D if game_world else null
	if game_world == null or player == null or cover == null or fuel == null or human == null \
			or awareness == null or vision == null or door == null:
		_add("17b F1 route consequences", false, "F1 cover, fuel, presence, vision, door, player, or GameWorld missing")
		return
	var cover_floor := Vector3(cover.global_position.x, 0.0, cover.global_position.z)
	var fuel_floor := Vector3(fuel.global_position.x, 0.0, fuel.global_position.z)
	var concealed_start := cover_floor
	var concealed_end := fuel_floor
	var open_start := cover_floor + Vector3(10.0, 0.0, -8.0)
	var open_end := fuel_floor + Vector3(0.0, 0.0, 3.0)
	var concealed_route: Dictionary = game_world.tactical.assess_route(player, concealed_start, concealed_end)
	var open_route: Dictionary = game_world.tactical.assess_route(player, open_start, open_end)
	var records := WorldStateManager.new()
	add_child(records)
	var concealed_record: Dictionary = records.record_route(concealed_start, concealed_end,
		str(concealed_route.get("classification", "")), float(concealed_route.get("disturbance_risk", 1.0)))
	var open_record: Dictionary = records.record_route(open_start, open_end,
		str(open_route.get("classification", "")), float(open_route.get("disturbance_risk", 1.0)))
	var world_snapshot: Dictionary = game_world.world_state.snapshot()
	var player_snapshot: Dictionary = game_world.player_state.snapshot()
	var human_snapshot: Dictionary = human.snapshot()
	var awareness_snapshot: Dictionary = awareness.snapshot()
	var awareness_runtime := {
		"sight_time": awareness.get("_sight_time"),
		"contact_clock": awareness.get("_contact_clock"),
		"lose_time": awareness.get("_lose_time"),
		"discovery_clock": awareness.get("_discovery_clock"),
		"mirror_clock": awareness.get("_mirror_clock"),
		"inspect_time": awareness.get("_inspect_time"),
		"samples": awareness.get("_samples").duplicate(),
	}
	var player_transform := player.global_transform
	var player_velocity := player.velocity
	var player_routine_was_enabled := human.routine_enabled
	var clock_hour := game_world.time_weather.hour
	var previous_weather := game_world.world_state.channel_value(WorldStateManager.CHANNEL_WEATHER)
	var route_anchor: Vector3 = game_world.get("_route_anchor")
	var route_anchor_valid := bool(game_world.get("_route_anchor_valid"))
	human.routine_enabled = false
	var door_mesh := door.get_node_or_null("MeshInstance3D") as MeshInstance3D
	door.collision_layer = 0
	if door_mesh:
		door_mesh.visible = false
	var covered_point := Vector3(cover.global_position.x - 1.0, 0.0, cover.global_position.z)
	var exposed_point := door.global_position + Vector3(0.6, -door.global_position.y, 0.0)
	var covered_score := 0.0
	var exposed_score := 0.0
	var covered_detected := false
	var exposed_detected := false
	var covered_state := "UNKNOWN"
	var exposed_state := "UNKNOWN"
	for route_name in ["covered", "exposed"]:
		var point := covered_point if route_name == "covered" else exposed_point
		player.global_position = point
		player.velocity = Vector3.ZERO
		human.look_at(Vector3(point.x, human.global_position.y, point.z), Vector3.UP)
		for _frame in range(2):
			await get_tree().process_frame
			await get_tree().physics_frame
		player.velocity = Vector3(5.0, 0.0, 0.0)
		vision.set("_lit_valid", false)
		vision.set("_throttle", 0.0)
		var route_sight: Dictionary = awareness.call("_sense_player", player)
		var score := float(route_sight.get("score", 0.0))
		var detected := bool(route_sight.get("visible", false)) and score >= HumanAwareness.SIGHT_THRESHOLD
		awareness.restore_from({"state": "UNAWARE", "suspicion": 0.0})
		awareness.set("_sight_time", 0.0)
		awareness.set("_contact_clock", 999.0)
		game_world.world_state.traces.clear()
		awareness.update(1.5, player)
		if route_name == "exposed" and awareness.state == HumanAwareness.State.SUSPICIOUS:
			awareness.update(0.05, player)
		if route_name == "covered":
			covered_detected = detected
			covered_score = score
			covered_state = awareness.state_name()
		else:
			exposed_detected = detected
			exposed_score = score
			exposed_state = awareness.state_name()
	game_world.world_state.restore(world_snapshot)
	game_world.time_weather.restore_clock(clock_hour, previous_weather)
	game_world.world_state.clock_hour = clock_hour
	game_world.player_state.restore(player_snapshot)
	game_world.cannery.apply_all()
	player.global_transform = player_transform
	player.velocity = player_velocity
	human.restore_from(human_snapshot)
	human.routine_enabled = player_routine_was_enabled
	awareness.restore_from(awareness_snapshot)
	awareness.set("_sight_time", awareness_runtime["sight_time"])
	awareness.set("_contact_clock", awareness_runtime["contact_clock"])
	awareness.set("_lose_time", awareness_runtime["lose_time"])
	awareness.set("_discovery_clock", awareness_runtime["discovery_clock"])
	awareness.set("_mirror_clock", awareness_runtime["mirror_clock"])
	awareness.set("_inspect_time", awareness_runtime["inspect_time"])
	awareness.set("_samples", awareness_runtime["samples"])
	game_world.set("_route_anchor", route_anchor)
	game_world.set("_route_anchor_valid", route_anchor_valid)
	await get_tree().physics_frame
	var routes_differ := str(concealed_record.get("classification", "")) == "CONCEALED_APPROACH" \
		and str(open_record.get("classification", "")) != str(concealed_record.get("classification", "")) \
		and float(concealed_record.get("disturbance_risk", 1.0)) < float(open_record.get("disturbance_risk", 0.0)) \
		and records.routes.size() == 2 and cover.is_in_group("context_conceal") \
		and not covered_detected and exposed_detected \
		and covered_state == "UNAWARE" and exposed_state != "UNAWARE"
	var fuel_gate_preserved := not game_world.world_state.object_state(CanneryState.FUEL_ID).has("collect") \
		and not game_world.cannery.is_powered()
	_add("17b F1 route consequences", routes_differ and fuel_gate_preserved,
		"concealed=%s/%.2f open=%s/%.2f route_records=%d cover_affordance=%s npc_detection=covered:%s/open:%s scores=%.2f/%.2f awareness=%s/%s fuel_gate=%s" % [
			concealed_record.get("classification", ""), concealed_record.get("disturbance_risk", 1.0),
			open_record.get("classification", ""), open_record.get("disturbance_risk", 1.0),
			records.routes.size(), cover.is_in_group("context_conceal"), covered_detected,
			exposed_detected, covered_score, exposed_score, covered_state, exposed_state, fuel_gate_preserved])
	records.free()

func _check_d032_heat_off() -> void:
	var cannery := _d032_cannery_root()
	var mach: Node = cannery.get_node_or_null("Machinery01") if cannery else null
	var light: OmniLight3D = cannery.get_node_or_null("InteriorLight") as OmniLight3D if cannery else null
	if mach == null or light == null:
		_add("18 D032 S-3 unpowered projection", false, "Machinery01/InteriorLight missing")
		return
	var ok: bool = not mach.is_in_group("shelter_zone") and float(mach.get("shelter_radius")) == 0.0 \
		and not light.visible and is_zero_approx(light.light_energy)
	_add("18 D032 S-3 unpowered projection", ok,
		"heat_zone=%s shelter_radius=%.1f light_visible=%s light_energy=%.2f" % [
			mach.is_in_group("shelter_zone"), float(mach.get("shelter_radius")), light.visible, light.light_energy])

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
		and int(gate.get("collision_layer")) == 1 and not deep.visible and is_zero_approx(deep.light_energy)
	_add("19 D032 S-3 deep gate sealed", ok,
		"inspect=%s open=%s layer=%d deep_light=%s energy=%.2f" % [
			gate.is_in_group("context_inspect"), gate.is_in_group("context_open"), int(gate.get("collision_layer")), deep.visible, deep.light_energy])

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

func _check_d032_light_energy_projection() -> void:
	var gw := get_tree().get_first_node_in_group("game_world")
	var ws: WorldStateManager = gw.get_node_or_null("WorldState") as WorldStateManager if gw else null
	var cannery := _d032_cannery_root()
	var light: OmniLight3D = cannery.get_node_or_null("InteriorLight") as OmniLight3D if cannery else null
	if ws == null or light == null:
		_add("21 D032 light energy projection", false, "WorldState/InteriorLight missing")
		return
	var starts_off := not light.visible and is_zero_approx(light.light_energy)
	ws.set_object_flag("f1_gyle_cannery_light", "on", true)
	var turns_on := light.visible and is_equal_approx(light.light_energy, 1.8)
	ws.set_object_flag("f1_gyle_cannery_light", "on", false)
	var turns_off := not light.visible and is_zero_approx(light.light_energy)
	_add("21 D032 light energy projection", starts_off and turns_on and turns_off,
		"starts_off=%s turns_on=%s turns_off=%s final_energy=%.2f" % [starts_off, turns_on, turns_off, light.light_energy])

func _check_visual_ambient_contract() -> void:
	var region := get_tree().get_first_node_in_group("visual_wilderness_region") as VisualWildernessProof1
	var world_environment: WorldEnvironment = region.get_node_or_null("WorldEnvironment") as WorldEnvironment if region else null
	var environment: Environment = world_environment.environment if world_environment else null
	if environment == null:
		_add("22 GL Compatibility ambient contract", false, "visual region Environment missing")
		return
	var ok := environment.ambient_light_source == Environment.AMBIENT_SOURCE_COLOR \
		and environment.ambient_light_energy <= 0.22
	_add("22 GL Compatibility ambient contract", ok,
		"source=%d energy=%.2f" % [environment.ambient_light_source, environment.ambient_light_energy])

func _check_visual_instanced_material_contract() -> void:
	var region := get_tree().get_first_node_in_group("visual_wilderness_region") as VisualWildernessProof1
	var vegetation := region.get_node_or_null("Region/Cell_0_0/Dressing/Vegetation") if region else null
	if vegetation == null:
		_add("23 wilderness instanced materials", false, "vegetation owner missing")
		return
	var expected := {
		"ConiferCanopies_MultiMesh": Color("#354a3a"),
		"ConiferTrunks_MultiMesh": Color("#58483a"),
		"Shrubs_MultiMesh": Color("#536044"),
		"GroundCover_MultiMesh": Color("#7b8051"),
		"Deadfall_MultiMesh": Color("#746653"),
	}
	var failures: Array[String] = []
	for node_name in expected:
		var instance := vegetation.get_node_or_null(node_name) as MultiMeshInstance3D
		var mesh: Mesh = instance.multimesh.mesh if instance and instance.multimesh else null
		var material: Material = instance.material_override if instance and instance.material_override else mesh.surface_get_material(0) if mesh and mesh.get_surface_count() > 0 else null
		if material is StandardMaterial3D:
			var standard := material as StandardMaterial3D
			if not standard.albedo_color.is_equal_approx(expected[node_name]) or standard.roughness < 0.7:
				failures.append("%s material does not match its muted matte palette" % node_name)
		elif material is ShaderMaterial:
			var shader_material := material as ShaderMaterial
			var fallback: Color = shader_material.get_shader_parameter("fallback_color")
			var roughness: float = shader_material.get_shader_parameter("foliage_roughness")
			if not fallback.is_equal_approx(expected[node_name]) or roughness < 0.7 or shader_material.shader == null:
				failures.append("%s shader material does not match its authored matte palette" % node_name)
		else:
			failures.append("%s has no authored surface or override material" % node_name)
	_add("23 wilderness instanced materials", failures.is_empty(),
		"five vegetation/deadfall batches use distinct, matte authored colors; failures=%s" % [failures])

func _check_terrain_surface_normals() -> void:
	var region := get_tree().get_first_node_in_group("visual_wilderness_region") as VisualWildernessProof1
	var terrain_mesh := region.get_node_or_null("Region/Cell_0_0/Terrain/TerrainBase/TerrainMesh") as MeshInstance3D if region else null
	var array_mesh := terrain_mesh.mesh as ArrayMesh if terrain_mesh else null
	var arrays: Array = array_mesh.surface_get_arrays(0) if array_mesh and array_mesh.get_surface_count() > 0 else []
	var normals: PackedVector3Array = arrays[Mesh.ARRAY_NORMAL] if arrays.size() > Mesh.ARRAY_NORMAL and arrays[Mesh.ARRAY_NORMAL] is PackedVector3Array else PackedVector3Array()
	var vertex_index := 28 * VisualWildernessProof1.TERRAIN_X_COUNT + 44
	var vertex_normal := normals[vertex_index] if normals.size() > vertex_index else Vector3.UP
	var analytic_normal := Vector3.UP
	var contract_available := region != null and region.has_method("terrain_normal")
	if contract_available:
		analytic_normal = region.call("terrain_normal", 40.0, 15.0)
	var ok := contract_available and normals.size() == VisualWildernessProof1.TERRAIN_X_COUNT * VisualWildernessProof1.TERRAIN_Z_COUNT \
		and vertex_normal.y < 0.99 and vertex_normal.distance_to(analytic_normal) < 0.02 \
		and is_equal_approx(analytic_normal.length(), 1.0)
	_add("23b terrain slope normals", ok,
		"normal_count=%d vertex=%s analytic=%s" % [normals.size(), vertex_normal, analytic_normal])

func _check_mobile_world_quality_profiles() -> void:
	var region := get_tree().get_first_node_in_group("visual_wilderness_region") as VisualWildernessProof1
	if region == null or not region.has_method("_profile_settings"):
		_add("23c mobile world quality tiers", false, "visual world profile contract missing")
		return
	var original_profile := region.presentation_profile
	region.presentation_profile = "PERFORMANCE"
	var performance: Dictionary = region.call("_profile_settings")
	region.presentation_profile = "BALANCED"
	var balanced: Dictionary = region.call("_profile_settings")
	region.presentation_profile = "QUALITY"
	var quality: Dictionary = region.call("_profile_settings")
	region.presentation_profile = original_profile
	var ordered := true
	for key in ["trees", "shrubs", "grass", "deadfall", "distance"]:
		ordered = ordered and int(performance[key]) < int(balanced[key]) and int(balanced[key]) < int(quality[key])
	_add("23c mobile world quality tiers", ordered,
		"vegetation/cull budgets performance=%d/%d balanced=%d/%d quality=%d/%d" % [
			performance["trees"] + performance["shrubs"] + performance["grass"], performance["distance"],
			balanced["trees"] + balanced["shrubs"] + balanced["grass"], balanced["distance"],
			quality["trees"] + quality["shrubs"] + quality["grass"], quality["distance"]])

func _check_perception_integration_contract() -> void:
	var awareness: HumanAwareness
	var human: HumanPresence
	for node in get_tree().get_nodes_in_group("human_presence"):
		var candidate := node as HumanPresence
		if candidate != null and candidate.presence_id == "presence_f1":
			human = candidate
			awareness = candidate.get_node_or_null("Awareness") as HumanAwareness
			break
	var vision: Node = human.get_node_or_null("VisionSensor") if human else null
	var sight_range_ok := vision != null and _has_property(vision, "sensing_range") \
		and is_equal_approx(float(vision.get("sensing_range")), HumanAwareness.SIGHT_RANGE)
	var target_blocker := get_tree().get_first_node_in_group("player") as CharacterBody3D
	var los_semantics := false
	if vision != null and target_blocker != null and vision.has_method("line_of_sight_clear"):
		los_semantics = bool(vision.call("line_of_sight_clear", {"collider": null}, target_blocker)) \
			and bool(vision.call("line_of_sight_clear", {"collider": target_blocker}, target_blocker)) \
			and not bool(vision.call("line_of_sight_clear", {"collider": human}, target_blocker))
	var world_region := get_tree().get_first_node_in_group("visual_wilderness_region") as Node3D
	var sun := world_region.get_node_or_null("Sun") as DirectionalLight3D if world_region else null
	var foliage_occlusion := false
	var brush_transmission := 1.0
	var clear_transmission := 1.0
	var clear_by_instance := {}
	if vision != null and vision.has_method("vegetation_line_transmission") and world_region != null:
		var shrubs := world_region.get_node_or_null("Region/Cell_0_0/Dressing/Vegetation/Shrubs_MultiMesh") as MultiMeshInstance3D
		if shrubs != null and shrubs.multimesh != null and shrubs.multimesh.instance_count > 0:
			var shrub_transform: Transform3D = world_region.call("vegetation_instance_transform", "Shrubs_MultiMesh", 0)
			var shrub_center: Vector3 = shrubs.global_transform * shrub_transform.origin
			var shrub_scale := shrub_transform.basis.get_scale().y
			var brush_line := Vector3(shrub_center.x, shrub_center.y + 0.08, shrub_center.z - 2.0 * shrub_scale)
			var brush_end := Vector3(shrub_center.x, shrub_center.y + 0.08, shrub_center.z + 2.0 * shrub_scale)
			var clear_start := Vector3(-20.0, 1.5, 0.0)
			var clear_end := Vector3(37.0, 1.5, 0.0)
			brush_transmission = float(vision.call("vegetation_line_transmission", brush_line, brush_end))
			clear_transmission = float(vision.call("vegetation_line_transmission", clear_start, clear_end))
			var clear_segment := clear_end - clear_start
			for instance_name in ["ConiferTrunks_MultiMesh", "ConiferTrunks_Hemlock_MultiMesh", "ConiferTrunks_Snag_MultiMesh"]:
				clear_by_instance[instance_name] = world_region.call("_multimesh_line_transmission", instance_name, clear_start, clear_segment, clear_segment.length_squared(), 0.28, 0.24)
			clear_by_instance["Shrubs_MultiMesh"] = world_region.call("_multimesh_line_transmission", "Shrubs_MultiMesh", clear_start, clear_segment, clear_segment.length_squared(), 0.62, 1.0)
			foliage_occlusion = brush_transmission < 0.8 and is_equal_approx(clear_transmission, 1.0)
	var identity_present := awareness != null and _has_property(awareness, "identity_confidence")
	var identity_unknown := identity_present and is_zero_approx(float(awareness.get("identity_confidence")))
	var sound_masking := awareness != null and awareness.has_method("sound_mask_factor")
	var wilderness_audio := get_tree().get_first_node_in_group("wilderness_audio")
	var surface_and_water := wilderness_audio != null and wilderness_audio.has_method("surface_at") \
		and wilderness_audio.has_method("water_masks_noise_at")
	if surface_and_water:
		var wet_surface := str(wilderness_audio.call("surface_at", Vector3(45.0, 0.0, -19.0))) == "WET"
		var gravel_surface := str(wilderness_audio.call("surface_at", Vector3.ZERO)) == "GRAVEL"
		var creek_masks := bool(wilderness_audio.call("water_masks_noise_at", Vector3(45.0, 0.0, -19.0)))
		surface_and_water = wet_surface and gravel_surface and creek_masks
	var game_world := get_tree().get_first_node_in_group("game_world") as GameWorld
	var noise_metadata := false
	if game_world != null and not game_world.world_state.traces.is_empty():
		game_world.call("_on_noise_event", Vector3(45.0, 0.0, -19.0), 0.5, "FOOTSTEP")
		var trace: Dictionary = game_world.world_state.traces.back()
		var detail := str(trace.get("detail", ""))
		noise_metadata = detail.contains("surface=WET") and detail.contains("water=true")
	if sound_masking:
		var clear_mask: Variant = awareness.call("sound_mask_factor", "CLEAR", "SOIL", false)
		var rain_mask: Variant = awareness.call("sound_mask_factor", "RAIN", "SOIL", false)
		var water_mask: Variant = awareness.call("sound_mask_factor", "CLEAR", "WET", true)
		sound_masking = clear_mask is float and rain_mask is float and water_mask is float \
			and is_equal_approx(float(clear_mask), 1.0) \
			and float(rain_mask) < float(clear_mask) and float(water_mask) < float(clear_mask)
	var ok := vision != null and sight_range_ok and los_semantics and foliage_occlusion and sun != null and sun.is_in_group("sun") \
		and identity_unknown and sound_masking and surface_and_water and noise_metadata
	_add("24 NPC perception integration", ok,
		"vision_sensor=%s range=%s los=%s foliage_occlusion=%s(brush=%.2f clear=%.2f parts=%s) sun_group=%s identity_unknown=%s sound_masking=%s surface_water=%s noise_metadata=%s" % [
			vision != null, sight_range_ok, los_semantics, foliage_occlusion, brush_transmission, clear_transmission, clear_by_instance, sun != null and sun.is_in_group("sun"), identity_unknown, sound_masking, surface_and_water, noise_metadata])

func _check_evidence_identity_persistence() -> void:
	var source := WorldStateManager.new()
	add_child(source)
	var first := source.record_trace("SOUND", Vector3(1.0, 0.0, 1.0), 0.4, "kind=FOOTSTEP;surface=SOIL")
	var trace_b := source.record_trace("SOUND", Vector3(1.0, 0.0, 1.0), 0.4, "kind=FOOTSTEP;surface=SOIL")
	var first_id := str(first.get("id", ""))
	var trace_b_id := str(trace_b.get("id", ""))
	var source_snapshot: Dictionary = source.snapshot()
	var restored_world := WorldStateManager.new()
	add_child(restored_world)
	restored_world.restore(source_snapshot)
	var third := restored_world.record_trace("SOUND", Vector3(1.0, 0.0, 1.0), 0.4, "kind=FOOTSTEP;surface=SOIL")
	var third_id := str(third.get("id", ""))
	var trace_ids_ok := first_id != "" and trace_b_id != "" and third_id != "" \
		and first_id != trace_b_id and first_id != third_id and trace_b_id != third_id
	var memory := HumanAwareness.new()
	var memory_record := {
		"state": "TRACKING",
		"identity_confidence": 0.0,
		"believed_identity": "UNKNOWN",
		"perceived_subject": "UNKNOWN",
		"suspected_actor": "UNKNOWN",
		"evidence_count": 2,
		"processed_traces": [first_id, trace_b_id],
	}
	memory.restore_from(memory_record)
	var restored_memory: Dictionary = memory.snapshot()
	var processed: Array = restored_memory.get("processed_traces", [])
	var memory_ok := is_zero_approx(float(restored_memory.get("identity_confidence", -1.0))) \
		and str(restored_memory.get("believed_identity", "")) == "UNKNOWN" \
		and str(restored_memory.get("perceived_subject", "")) == "UNKNOWN" \
		and str(restored_memory.get("suspected_actor", "")) == "UNKNOWN" \
		and int(restored_memory.get("evidence_count", -1)) == 2 \
		and processed.size() == 2 and processed.has(first_id) and processed.has(trace_b_id)
	var sighting := HumanAwareness.new()
	sighting.record_visual_observation(0.72, Vector3(2.0, 0.0, 2.0), 0.5)
	var possible_person := str(sighting.snapshot().get("perceived_subject", "")) == "POSSIBLE_PERSON" \
		and str(sighting.snapshot().get("suspected_actor", "")) == "UNIDENTIFIED_PERSON" \
		and str(sighting.snapshot().get("believed_identity", "")) == "UNKNOWN" \
		and is_zero_approx(float(sighting.snapshot().get("identity_confidence", -1.0)))
	sighting.record_visual_observation(0.72, Vector3(2.0, 0.0, 2.0), 1.0)
	var confirmed_person := str(sighting.snapshot().get("perceived_subject", "")) == "CONFIRMED_PERSON" \
		and int(sighting.snapshot().get("evidence_count", 0)) == 1
	var validator := SaveStateManager.new()
	var valid_record := bool(validator.call("_valid_awareness_records", {"presence_f1": memory_record}))
	var malformed := memory_record.duplicate(true)
	malformed["identity_confidence"] = "certain"
	var malformed_rejected := not bool(validator.call("_valid_awareness_records", {"presence_f1": malformed}))
	var malformed_subject := memory_record.duplicate(true)
	malformed_subject["perceived_subject"] = "CORLEY"
	var malformed_subject_rejected := not bool(validator.call("_valid_awareness_records", {"presence_f1": malformed_subject}))
	var valid_traces := bool(validator.call("_valid_trace_records", source_snapshot.get("traces", [])))
	var malformed_trace := first.duplicate(true)
	malformed_trace["id"] = 7
	var malformed_trace_rejected := not bool(validator.call("_valid_trace_records", [malformed_trace]))
	var malformed_world := source_snapshot.duplicate(true)
	malformed_world["trace_sequence"] = "bad"
	var malformed_sequence_rejected := not bool(validator.call("_valid_world_snapshot", malformed_world))
	_add("25 evidence identity persistence", trace_ids_ok and memory_ok and possible_person and confirmed_person \
		and valid_record and malformed_rejected and malformed_subject_rejected \
		and valid_traces and malformed_trace_rejected and malformed_sequence_rejected,
		"unique_trace_ids=%s memory=%s possible_person=%s confirmed_person=%s awareness_shape=%s malformed_awareness=%s malformed_subject=%s trace_shape=%s malformed_trace=%s malformed_sequence=%s" % [
			trace_ids_ok, memory_ok, possible_person, confirmed_person, valid_record, malformed_rejected,
			malformed_subject_rejected, valid_traces, malformed_trace_rejected, malformed_sequence_rejected])
	source.queue_free()
	restored_world.queue_free()
	memory.free()
	sighting.free()
	validator.free()

func _check_combat_physiology_contract() -> void:
	var game_world := get_tree().get_first_node_in_group("game_world") as GameWorld
	var player := get_tree().get_first_node_in_group("player") as CharacterBody3D
	var combat := player.get_node_or_null("CombatController") if player else null
	var player_state := game_world.player_state if game_world else null
	var body_state := player.get_node_or_null("BodyState") as BodyState if player else null
	var pressure: PressureManager = game_world.pressure if game_world else null
	if combat == null or player_state == null or body_state == null or pressure == null:
		_add("26 combat physiology persistence", false, "combat or PlayerStateManager missing")
		return
	var baseline: Dictionary = player_state.snapshot()
	var control_before := float(combat.get("control"))
	var condition_before := body_state.condition
	var pressure_condition_before := pressure.condition
	var injury_before := player_state.band("INJURY")
	var exertion_before := player_state.band("EXERTION")
	combat.set("control", 1.0)
	for _hit in range(4):
		combat.call("host_event", "hit_taken", 0.1)
	var injury_after := player_state.band("INJURY")
	var exertion_after := player_state.band("EXERTION")
	var hit_snapshot: Dictionary = player_state.snapshot()
	var restored := PlayerStateManager.new()
	restored.restore(hit_snapshot)
	var consequence_recorded := injury_after > injury_before and exertion_after > exertion_before
	var consequence_persisted := is_equal_approx(restored.band("INJURY"), injury_after) \
		and is_equal_approx(restored.band("EXERTION"), exertion_after)
	pressure.update(0.0, player)
	body_state.set_condition(pressure.condition)
	var movement_consequence := pressure.condition == PressureManager.CONDITION_INJURED \
		and body_state.condition_speed_scale() < 1.0 and body_state.condition_accel_scale() < 1.0
	_add("26 combat physiology persistence", consequence_recorded and consequence_persisted and movement_consequence,
		"injury=%.2f->%.2f exertion=%.2f->%.2f restored=%.2f/%.2f movement=%s speed=%.2f accel=%.2f" % [
			injury_before, injury_after, exertion_before, exertion_after,
			restored.band("INJURY"), restored.band("EXERTION"), body_state.condition,
			body_state.condition_speed_scale(), body_state.condition_accel_scale()])
	player_state.restore(baseline)
	combat.set("control", control_before)
	pressure.condition = pressure_condition_before
	body_state.set_condition(condition_before)
	restored.free()

func _check_motion_grounding() -> void:
	var player := get_tree().get_first_node_in_group("player") as CharacterBody3D
	var stance := player.get_node_or_null("StanceController") as StanceController if player else null
	if player == null or stance == null or not player.is_on_floor():
		_add("23 locomotion grounding", false, "player, stance, or grounded start missing")
		return
	var start := player.global_position
	Input.action_press("move_forward", 1.0)
	for _frame in range(45):
		await get_tree().physics_frame
	Input.action_release("move_forward")
	var walk_distance := player.global_position.distance_to(start)
	var grounded_after_walk := player.is_on_floor()
	Input.action_press("crouch")
	await get_tree().physics_frame
	await get_tree().physics_frame
	Input.action_release("crouch")
	var crouch_entered := stance.current == StanceController.Stance.CROUCH
	Input.action_press("crouch")
	await get_tree().physics_frame
	await get_tree().physics_frame
	Input.action_release("crouch")
	var stand_restored := stance.current == StanceController.Stance.STAND
	var query := PhysicsRayQueryParameters3D.create(
		player.global_position + Vector3.UP * 0.1,
		player.global_position - Vector3.UP * 0.2)
	query.collision_mask = 1
	query.exclude = [player.get_rid()]
	var floor_hit := player.get_world_3d().direct_space_state.intersect_ray(query)
	var contact_error := INF
	if not floor_hit.is_empty():
		contact_error = absf(player.global_position.y - (floor_hit["position"] as Vector3).y)
	var visual_region := get_tree().get_first_node_in_group("visual_wilderness_region") as VisualWildernessProof1
	var terrain_base := visual_region.get_node_or_null("Region/Cell_0_0/Terrain/TerrainBase") as StaticBody3D if visual_region else null
	var strand_floor := get_tree().get_first_node_in_group("player").get_parent().get_node_or_null("StrandFloor") as StaticBody3D
	var terrain_walkable := terrain_base != null and terrain_base.collision_layer == 1 \
		and strand_floor != null and strand_floor.collision_layer == 0
	var ok := walk_distance > 0.5 and grounded_after_walk and crouch_entered and stand_restored \
		and not floor_hit.is_empty() and contact_error <= 0.01 and terrain_walkable
	_add("23 locomotion grounding", ok,
		"walk=%.2f m grounded=%s crouch=%s stand=%s foot_gap=%.3f m terrain_collision_surface=%s flat_sector_helper_disabled=%s" % [
			walk_distance, grounded_after_walk, crouch_entered, stand_restored, contact_error, terrain_walkable, strand_floor != null and strand_floor.collision_layer == 0])

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
		await _orderly_shutdown(0 if failed == 0 else 1)
