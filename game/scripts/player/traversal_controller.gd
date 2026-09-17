class_name TraversalController
extends Node

enum TraversalState { NONE, MANTLE, VAULT, CLIMB, LEDGE }

@export var vault_max := 0.55
@export var mantle_max := 1.15
@export var ledge_max := 1.6
@export var mantle_forward := 2.4
@export var mantle_up := 7.0
@export var mantle_lock := 0.65
@export var vault_forward := 5.0
@export var vault_up := 2.2
@export var vault_lock := 0.35
@export var climb_speed := 2.6
@export var ledge_grab_depth := 0.5
@export var ledge_traverse_speed := 1.4
@export var ledge_pull_up_velocity := 6.5
@export var ledge_pull_forward := 2.2
@export var debug_log_enabled := false

@onready var body := get_parent() as CharacterBody3D

var state: int = TraversalState.NONE
var state_time := 0.0
var state_forward := Vector3.ZERO
var ledge_normal := Vector3.ZERO
var ledge_tangent := Vector3.ZERO
var ledge_edge := 0.0

func is_active() -> bool:
	return state != TraversalState.NONE

func attempt_start(direction: Vector3, prone: bool, grounded: bool, probe: Dictionary) -> bool:
	if is_active() or not grounded:
		return false
	var collider: Node = probe.get("collider") as Node
	if collider == null:
		return false
	if collider.is_in_group("context_climb"):
		if Input.is_action_pressed("interact"):
			start_climb()
			return true
	if direction.is_zero_approx():
		return false
	var facing := -body.global_transform.basis.z
	facing.y = 0.0
	facing = facing.normalized()
	if prone:
		return false
	var edge: float = probe.get("edge_height", INF)
	var clear: bool = probe.get("top_clear", false)
	if edge <= vault_max and edge > 0.08 and clear:
		if Input.is_action_just_pressed("jump") and direction.dot(facing) >= 0.4:
			start_vault(facing)
			return true
	if edge <= mantle_max and edge > vault_max and clear:
		if Input.is_action_just_pressed("jump") and direction.dot(facing) >= 0.4:
			start_mantle(facing)
			return true
	if edge > mantle_max and edge <= ledge_max:
		if Input.is_action_just_pressed("jump") and direction.dot(facing) >= 0.4:
			var normal := Vector3(probe.get("normal", Vector3.ZERO))
			normal.y = 0.0
			normal = normal.normalized()
			start_ledge(facing, edge, normal)
			return true
	return false

func process_active(delta: float, gravity: float) -> void:
	state_time += delta
	match state:
		TraversalState.CLIMB:
			process_climb()
		TraversalState.LEDGE:
			process_ledge()
		_:
			body.velocity.y -= gravity * delta
			if state_time >= lock_time(state):
				end_traversal()

func process_climb() -> void:
	var up := Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")
	body.velocity.x = 0.0
	body.velocity.z = 0.0
	body.velocity.y = up * climb_speed
	if Input.is_action_just_released("interact"):
		end_traversal()
	else:
		if body.is_on_floor() and up <= 0.0:
			end_traversal()

func process_ledge() -> void:
	var axis := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	body.velocity = ledge_tangent * axis * ledge_traverse_speed
	body.global_position.y = ledge_edge + 0.4
	if Input.is_action_just_pressed("jump"):
		pull_up_ledge()
	elif Input.is_action_just_pressed("crouch") or Input.is_action_just_pressed("prone"):
		drop_ledge()

func start_climb() -> void:
	state = TraversalState.CLIMB
	state_time = 0.0
	log_transition("traversal", "CLIMB")

func start_vault(forward: Vector3) -> void:
	state = TraversalState.VAULT
	state_time = 0.0
	state_forward = forward
	body.velocity = forward * vault_forward + Vector3.UP * vault_up
	log_transition("traversal", "VAULT")

func start_mantle(forward: Vector3) -> void:
	state = TraversalState.MANTLE
	state_time = 0.0
	state_forward = forward
	body.velocity = forward * mantle_forward + Vector3.UP * mantle_up
	log_transition("traversal", "MANTLE")

func start_ledge(forward: Vector3, edge: float, normal: Vector3) -> void:
	state = TraversalState.LEDGE
	state_time = 0.0
	state_forward = forward
	ledge_edge = edge
	ledge_normal = normal
	ledge_tangent = normal.cross(Vector3.UP).normalized()
	body.velocity = Vector3.ZERO
	body.global_position.y = edge - ledge_grab_depth + 0.9
	log_transition("traversal", "LEDGE")

func pull_up_ledge() -> void:
	state = TraversalState.NONE
	state_time = 0.0
	var up := Vector3.UP * ledge_pull_up_velocity
	var out := state_forward * ledge_pull_forward
	body.velocity = Vector3(out.x, up.y, out.z)
	log_transition("traversal", "PULL_UP")

func drop_ledge() -> void:
	state = TraversalState.NONE
	state_time = 0.0
	body.velocity = Vector3.ZERO
	log_transition("traversal", "DROP")

func lock_time(traversal_state: int) -> float:
	match traversal_state:
		TraversalState.MANTLE:
			return mantle_lock
		TraversalState.VAULT:
			return vault_lock
		_:
			return 0.0

func end_traversal() -> void:
	state = TraversalState.NONE
	state_time = 0.0
	log_transition("traversal", "NONE")

func state_name() -> String:
	match state:
		TraversalState.MANTLE:
			return "MANTLE"
		TraversalState.VAULT:
			return "VAULT"
		TraversalState.CLIMB:
			return "CLIMB"
		TraversalState.LEDGE:
			return "LEDGE"
		_:
			return "NONE"

func log_transition(system: String, value: Variant) -> void:
	if debug_log_enabled:
		print("BV.DEBUG." + system + " -> " + str(value))