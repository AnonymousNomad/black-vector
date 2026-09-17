class_name CameraRig
extends Node3D

@export var mouse_sensitivity := 0.0022
@export var gamepad_sensitivity := 2.4
@export var min_pitch := -1.15
@export var max_pitch := 0.35
@export var follow_smoothing := 14.0

@onready var pitch_pivot: Node3D = $PitchPivot

var owner_body: CharacterBody3D
var _follow_initialized := false

func _ready() -> void:
	owner_body = get_parent() as CharacterBody3D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		apply_look(event.relative.x * mouse_sensitivity, event.relative.y * mouse_sensitivity)
	if event.is_action_pressed("debug_toggle_mouse"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	var axis := Input.get_vector("look_left", "look_right", "look_up", "look_down")
	if not axis.is_zero_approx():
		apply_look(axis.x * gamepad_sensitivity * delta, axis.y * gamepad_sensitivity * delta)

func apply_look(yaw: float, pitch: float) -> void:
	if owner_body:
		owner_body.rotation.y -= yaw
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x - pitch, min_pitch, max_pitch)

func set_rig_transform(origin: Vector3, height: float) -> void:
	var target := origin + Vector3.UP * height
	if not _follow_initialized:
		global_position = target
		_follow_initialized = true
		return
	var weight := clampf(follow_smoothing * get_physics_process_delta_time(), 0.0, 1.0)
	global_position = global_position.lerp(target, weight)