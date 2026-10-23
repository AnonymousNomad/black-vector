extends Node3D

const CHECK_FRAMES := 360

func _ready() -> void:
	call_deferred("_run")

func _run() -> void:
	var presence := get_node("HumanPresence") as HumanPresence
	if presence == null:
		_finish(false, "HumanPresence scene failed to instantiate")
		return
	var missing: Array[String] = []
	for property_name in ["routine_enabled", "routine_stops", "routine_index", "routine_state"]:
		if not _has_property(presence, property_name):
			missing.append(property_name)
	for method_name in ["update_routine", "reset_routine"]:
		if not presence.has_method(method_name):
			missing.append(method_name)
	if not missing.is_empty():
		_finish(false, "routine contract missing: %s" % ", ".join(missing))
		return

	presence.set("routine_enabled", true)
	var work := HumanRoutineStop.new()
	work.offset = Vector3(2.0, 0.0, 0.0)
	work.activity = "WORK"
	work.start_hour = 8.0
	work.end_hour = 12.0
	work.dwell_seconds = 60.0
	var inspect := HumanRoutineStop.new()
	inspect.offset = Vector3(2.0, 0.0, 2.0)
	inspect.activity = "INSPECT"
	inspect.start_hour = 12.0
	inspect.end_hour = 18.0
	inspect.dwell_seconds = 60.0
	var overnight := HumanRoutineStop.new()
	overnight.start_hour = 22.0
	overnight.end_hour = 6.0
	presence.routine_stops = [work, inspect]
	presence.routine_move_speed = 4.0
	presence.reset_routine()
	var saw_work := false
	var saw_inspect := false
	var start := presence.global_position
	for _frame in range(CHECK_FRAMES / 2):
		presence.call("update_routine", 1.0 / 60.0, 9.0)
		var activity := str(presence.get("activity"))
		saw_work = saw_work or activity == "WORKING"
		await get_tree().physics_frame
	for _frame in range(CHECK_FRAMES / 2):
		presence.call("update_routine", 1.0 / 60.0, 15.0)
		var activity := str(presence.get("activity"))
		saw_inspect = saw_inspect or activity == "INSPECTING"
		await get_tree().physics_frame
	var moved := start.distance_to(presence.global_position) > 1.0
	var selected_inspect_stop := int(presence.get("routine_index")) == 1
	presence.call("receive_speech", "QUESTION", "routine_check")
	presence.call("update_routine", 1.0 / 60.0, 15.0)
	var converse_hook := str(presence.get("routine_state")) == "CONVERSE" and str(presence.get("activity")) == "CONVERSING"
	for _frame in range(150):
		presence.call("update_conversation", 1.0 / 60.0)
		presence.call("update_routine", 1.0 / 60.0, 15.0)
		await get_tree().physics_frame
	var resumed := str(presence.get("routine_state")) == "INSPECT"
	presence.call("update_routine", 1.0 / 60.0, 20.0)
	var idle_outside_schedule := str(presence.get("routine_state")) == "IDLE"
	var overnight_schedule := overnight.active_at(23.0) and overnight.active_at(3.0) and not overnight.active_at(12.0)
	var route_seen := saw_work and saw_inspect and selected_inspect_stop
	if moved and route_seen and converse_hook and resumed and idle_outside_schedule and overnight_schedule:
		_finish(true, "moved %.2f m; scheduled WORK/INSPECT, overnight hours, conversation hook, resumption, and off-shift idle verified" % start.distance_to(presence.global_position))
	else:
		_finish(false, "moved=%s work=%s inspect=%s selected=%s conversation=%s resumed=%s off_shift=%s overnight=%s state=%s stops=%d active9=%d position=%s velocity=%s" % [moved, saw_work, saw_inspect, selected_inspect_stop, converse_hook, resumed, idle_outside_schedule, overnight_schedule, presence.routine_state, presence.routine_stops.size(), presence.active_routine_index(9.0), presence.global_position, presence.velocity])

func _has_property(target: Object, property_name: String) -> bool:
	for property in target.get_property_list():
		if str(property.get("name", "")) == property_name:
			return true
	return false

func _finish(ok: bool, detail: String) -> void:
	print("HUMAN ROUTINE CHECK [%s]: %s" % ["PASS" if ok else "FAIL", detail])
	get_tree().quit(0 if ok else 1)
