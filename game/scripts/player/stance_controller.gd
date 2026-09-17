class_name StanceController
extends Node

signal stance_changed(new_stance: int)

enum Stance { STAND, CROUCH, PRONE }

@export var stance_table: StanceTable
@export var debug_log_enabled := false

@onready var body := get_parent() as CharacterBody3D
@onready var collision_shape: CollisionShape3D = get_parent().get_node("CollisionShape3D")

var current: int = Stance.STAND

func process_input() -> void:
	var next: int = current
	if Input.is_action_just_pressed("crouch"):
		next = crouch_target()
	if Input.is_action_just_pressed("prone"):
		next = prone_target()
	if next != current:
		change_to(next)

func crouch_target() -> int:
	match current:
		Stance.CROUCH:
			return Stance.STAND
		Stance.PRONE:
			return Stance.CROUCH
		_:
			return Stance.CROUCH

func prone_target() -> int:
	match current:
		Stance.PRONE:
			return Stance.STAND
		_:
			return Stance.PRONE

func change_to(next: int) -> void:
	if next > current and not has_headroom(next):
		log_transition("stance_refused", next)
		return
	current = next
	apply_collision()
	log_transition("stance", current)
	stance_changed.emit(current)

func has_headroom(next: int) -> bool:
	var target_height := height_for(next)
	var from := body.global_position + Vector3.UP * 0.2
	var to := body.global_position + Vector3.UP * (target_height - 0.1)
	var query := PhysicsRayQueryParameters3D.create(from, to)
	query.collision_mask = 1
	query.collide_with_areas = false
	query.exclude = [body.get_rid()]
	return body.get_world_3d().direct_space_state.intersect_ray(query).is_empty()

func apply_collision() -> void:
	var capsule := collision_shape.shape as CapsuleShape3D
	capsule.height = height_for(current)
	collision_shape.position = Vector3(0.0, capsule.height * 0.5, 0.0)

func height_for(stance: int) -> float:
	match stance:
		Stance.CROUCH:
			return stance_table.full_height * stance_table.crouch_height_scale
		Stance.PRONE:
			return stance_table.full_height * stance_table.prone_height_scale
		_:
			return stance_table.full_height

func current_speed(sprint: bool) -> float:
	var speed: float
	match current:
		Stance.CROUCH:
			speed = stance_table.crouch_speed
		Stance.PRONE:
			speed = stance_table.prone_speed
		_:
			speed = stance_table.stand_speed
	if sprint and current == Stance.STAND:
		speed *= stance_table.sprint_multiplier
	return speed

func current_camera_height() -> float:
	match current:
		Stance.CROUCH:
			return stance_table.crouch_camera_height
		Stance.PRONE:
			return stance_table.prone_camera_height
		_:
			return stance_table.stand_camera_height

func is_stowed() -> bool:
	return current != Stance.STAND

func is_prone() -> bool:
	return current == Stance.PRONE

func state_name() -> String:
	match current:
		Stance.CROUCH:
			return "CROUCH"
		Stance.PRONE:
			return "PRONE"
		_:
			return "STAND"

func log_transition(system: String, value: Variant) -> void:
	if debug_log_enabled:
		print("BV.DEBUG." + system + " -> " + str(value))