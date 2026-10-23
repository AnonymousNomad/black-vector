class_name HumanPresence
extends CharacterBody3D

signal speech_received(intent: String, text_key: String)
signal routine_activity_changed(activity: String)

@export var presence_id := "presence_01"
@export var posture := "STAND"
@export var activity := "SHELTERING"
@export var threat_level := "UNKNOWN"
@export var routine_enabled := false
@export var routine_stops: Array[HumanRoutineStop] = []
@export_range(0.1, 4.0, 0.1) var routine_move_speed := 1.2
@export_range(0.1, 2.0, 0.1) var routine_arrive_radius := 0.45
@export var routine_turn_speed := 3.0
@export var routine_gravity := 22.0

var world: WorldStateManager
var received_speech: Array = []
var routine_state := "IDLE"
var routine_index := -1

var _routine_origin := Vector3.ZERO
var _routine_target := Vector3.ZERO
var _routine_speech_remaining := 0.0
var _routine_activity := "SHELTERING"
var _routine_dwell_elapsed := 0.0
var _spawn_transform := Transform3D.IDENTITY
var _spawn_posture := "STAND"
var _spawn_activity := "SHELTERING"
var _spawn_threat_level := "UNKNOWN"

func _ready() -> void:
	add_to_group("human_presence")
	_routine_origin = global_position
	_routine_target = global_position
	_spawn_transform = global_transform
	_spawn_posture = posture
	_spawn_activity = activity
	_spawn_threat_level = threat_level

func bind(w: WorldStateManager) -> void:
	world = w

func record_evidence() -> void:
	if world == null:
		return
	world.record_trace("FOOTPRINT", global_position + Vector3(0.6, 0.0, 0.4), 0.45, "presence", presence_id)
	world.record_trace("SOUND", global_position + Vector3(0.2, 0.0, 0.1), 0.35, "activity", presence_id)

func receive_speech(intent: String, text_key: String, context := {}) -> Dictionary:
	var entry := {
		"intent": intent,
		"text_key": text_key,
		"context": context.duplicate(true),
	}
	received_speech.append(entry)
	_routine_speech_remaining = 2.0
	_set_routine_activity("CONVERSING")
	speech_received.emit(intent, text_key)
	return entry

func speech_count() -> int:
	return received_speech.size()

func reset_routine() -> void:
	_routine_origin = global_position
	_routine_target = global_position
	routine_index = -1
	routine_state = "IDLE"
	_routine_speech_remaining = 0.0
	_routine_dwell_elapsed = 0.0
	_set_routine_activity("SHELTERING")
	velocity = Vector3.ZERO

func update_conversation(delta: float) -> void:
	if _routine_speech_remaining <= 0.0:
		return
	_routine_speech_remaining = maxf(0.0, _routine_speech_remaining - delta)
	if _routine_speech_remaining > 0.0:
		_set_routine_activity("CONVERSING")

func update_routine(delta: float, hour: float) -> void:
	if not routine_enabled:
		return
	if _routine_speech_remaining > 0.0:
		routine_state = "CONVERSE"
		velocity.x = 0.0
		velocity.z = 0.0
		_set_routine_activity("CONVERSING")
		_apply_routine_gravity(delta)
		move_and_slide()
		return
	var next_index := active_routine_index(hour)
	if next_index < 0:
		routine_index = -1
		routine_state = "IDLE"
		velocity.x = 0.0
		velocity.z = 0.0
		_set_routine_activity("SHELTERING")
		_apply_routine_gravity(delta)
		move_and_slide()
		return
	if next_index != routine_index:
		routine_index = next_index
		_routine_dwell_elapsed = 0.0
		var stop := routine_stops[routine_index]
		_routine_target = _routine_origin + stop.offset
		routine_state = "TRAVEL"
	var target := _routine_target
	var direction := target - global_position
	direction.y = 0.0
	if direction.length() > routine_arrive_radius:
		direction = direction.normalized()
		velocity.x = direction.x * routine_move_speed
		velocity.z = direction.z * routine_move_speed
		var desired_yaw := atan2(-direction.x, -direction.z)
		rotation.y = lerp_angle(rotation.y, desired_yaw, clampf(routine_turn_speed * delta, 0.0, 1.0))
		routine_state = "TRAVEL"
		_set_routine_activity("MOVING")
	else:
		velocity.x = 0.0
		velocity.z = 0.0
		var stop := routine_stops[routine_index]
		if _routine_dwell_elapsed < stop.dwell_seconds:
			_routine_dwell_elapsed += delta
			routine_state = str(stop.activity)
			_set_routine_activity(_routine_activity_name(stop.activity))
		else:
			routine_state = "IDLE"
			_set_routine_activity("SHELTERING")
	_apply_routine_gravity(delta)
	move_and_slide()

func active_routine_index(hour: float) -> int:
	for index in range(routine_stops.size()):
		var stop := routine_stops[index]
		if stop != null and stop.active_at(hour):
			return index
	return -1

func _routine_activity_name(stop_activity: String) -> String:
	match stop_activity:
		"WORK":
			return "WORKING"
		"INSPECT":
			return "INSPECTING"
		_:
			return "SHELTERING"

func _set_routine_activity(value: String) -> void:
	if value == _routine_activity and value == activity:
		return
	_routine_activity = value
	activity = value
	routine_activity_changed.emit(value)

func _apply_routine_gravity(delta: float) -> void:
	if is_on_floor():
		velocity.y = 0.0
	else:
		velocity.y -= routine_gravity * delta

func snapshot() -> Dictionary:
	return {
		"position": [global_position.x, global_position.y, global_position.z],
		"rotation_y": rotation.y,
		"posture": posture,
		"activity": activity,
		"threat_level": threat_level,
		"routine_state": routine_state,
		"routine_index": routine_index,
		"routine_dwell_elapsed": _routine_dwell_elapsed,
	}

func restore_from(record: Dictionary) -> void:
	if record.is_empty():
		global_transform = _spawn_transform
		posture = _spawn_posture
		activity = _spawn_activity
		threat_level = _spawn_threat_level
		routine_state = "IDLE"
		routine_index = -1
		_routine_target = _routine_origin
		_routine_dwell_elapsed = 0.0
		_routine_speech_remaining = 0.0
		velocity = Vector3.ZERO
		return
	var position_data: Variant = record.get("position", [])
	if position_data is Array and (position_data as Array).size() == 3:
		global_position = Vector3(float(position_data[0]), float(position_data[1]), float(position_data[2]))
	rotation.y = float(record.get("rotation_y", rotation.y))
	posture = str(record.get("posture", posture))
	activity = str(record.get("activity", activity))
	threat_level = str(record.get("threat_level", threat_level))
	routine_state = str(record.get("routine_state", routine_state))
	routine_index = int(record.get("routine_index", -1))
	if routine_index < 0 or routine_index >= routine_stops.size():
		routine_index = -1
	else:
		_routine_target = _routine_origin + routine_stops[routine_index].offset
	_routine_dwell_elapsed = maxf(0.0, float(record.get("routine_dwell_elapsed", 0.0)))
	_routine_speech_remaining = 0.0
	velocity = Vector3.ZERO

func report() -> Dictionary:
	return {
		"id": presence_id,
		"posture": posture,
		"activity": activity,
		"threat": threat_level,
		"position": [global_position.x, global_position.y, global_position.z],
		"speech_count": received_speech.size(),
	}
