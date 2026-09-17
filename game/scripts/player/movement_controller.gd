class_name MovementController
extends Node

enum MoveState { IDLE, WALK, JOG, SPRINT, AIR }

@export var walk_speed := 3.2
@export var jog_speed := 5.0
@export var ground_acceleration := 14.0
@export var air_acceleration := 3.0
@export var brake_multiplier := 1.5
@export var slope_flat_normal := 0.35
@export var slope_speed_penalty := 0.28
@export var debug_log_enabled := false

@onready var body := get_parent() as CharacterBody3D

var move_state: int = MoveState.IDLE

func apply_movement(direction: Vector3, delta: float, max_speed: float, jump_velocity: float, gravity: float, grounded: bool, accel_scale: float) -> void:
	var target := direction * max_speed
	if grounded:
		target *= slope_scale()
		var accel := ground_acceleration * accel_scale
		body.velocity.x = move_toward(body.velocity.x, target.x, accel_space(body.velocity.x, target.x, accel, delta))
		body.velocity.z = move_toward(body.velocity.z, target.z, accel_space(body.velocity.z, target.z, accel, delta))
		if Input.is_action_just_pressed("jump"):
			body.velocity.y = jump_velocity
		else:
			body.velocity.y = 0.0
	else:
		var accel := air_acceleration * accel_scale
		body.velocity.x = move_toward(body.velocity.x, target.x, accel * delta)
		body.velocity.z = move_toward(body.velocity.z, target.z, accel * delta)
		body.velocity.y -= gravity * delta
	update_state(max_speed, grounded)

func accel_space(current: float, target: float, accel: float, delta: float) -> float:
	if absf(target) < absf(current):
		return accel * brake_multiplier * delta
	return accel * delta

func slope_scale() -> float:
	var normal := body.get_floor_normal()
	var ratio := clampf((1.0 - normal.y) / slope_flat_normal, 0.0, 1.0)
	return 1.0 - slope_speed_penalty * ratio

func update_state(max_speed: float, grounded: bool) -> void:
	var next: int
	if grounded and body.velocity.length() < 0.2:
		next = MoveState.IDLE
	elif not grounded:
		next = MoveState.AIR
	elif max_speed >= jog_speed + 0.5:
		next = MoveState.SPRINT
	elif max_speed >= walk_speed:
		next = MoveState.JOG
	else:
		next = MoveState.WALK
	if next != move_state:
		move_state = next
		log_transition("movement", move_state)

func state_name() -> String:
	match move_state:
		MoveState.WALK:
			return "WALK"
		MoveState.JOG:
			return "JOG"
		MoveState.SPRINT:
			return "SPRINT"
		MoveState.AIR:
			return "AIRBORNE"
		_:
			return "IDLE"

func log_transition(system: String, value: Variant) -> void:
	if debug_log_enabled:
		print("BV.DEBUG." + system + " -> " + str(value))