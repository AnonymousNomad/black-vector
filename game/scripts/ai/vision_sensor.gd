class_name VisionSensor
extends Node3D

const COS_H_FOV := cos(deg_to_rad(55.0))
const SIN_V_FOV := sin(deg_to_rad(38.0))
const MAX_RANGE := 25.0
const ELEVATION_RANGE_BONUS := 1.3
const LIT_FULL := 1.0
const LIT_SHADED := 0.6
const SUN_SAMPLE_DIST := 45.0

@export var lit_throttle := 0.2

var sun: Node = null
var _throttle := 0.0
var _lit_clear := true
var _lit_valid := false

func _ready() -> void:
	sun = get_tree().get_first_node_in_group("sun")

func sense(target_point: Vector3, target_speed: float, target_visibility: float) -> Dictionary:
	var body := get_parent() as CharacterBody3D
	var eye := global_position
	var to_target := target_point - eye
	var distance := to_target.length()
	if distance > effective_range(body, target_point):
		return miss()
	var dir := to_target / distance
	var facing := -body.global_transform.basis.z
	facing.y = 0.0
	facing = facing.normalized()
	if facing.length_squared() < 0.5:
		facing = Vector3.FORWARD
	facing = facing.normalized()
	var horizontal := Vector3(dir.x, 0.0, dir.z)
	if horizontal.length_squared() < 0.001:
		horizontal = facing
	horizontal = horizontal.normalized()
	var h_dot := facing.dot(horizontal)
	var cone := clampf((h_dot - COS_H_FOV) / (1.0 - COS_H_FOV), 0.0, 1.0)
	var vertical := clampf(1.0 - absf(dir.y) / SIN_V_FOV, 0.0, 1.0)
	if cone <= 0.0 or vertical <= 0.0:
		return miss()
	var obst := space_query(eye, target_point)
	var collider: Object = obst.get("collider")
	var visible := false
	if collider == null:
		visible = true
	elif collider is CharacterBody3D and collider != body:
		visible = true
	if not visible:
		return miss()
	var dist_falloff := clampf(1.0 - distance / effective_range(body, target_point), 0.0, 1.0)
	var movement_mul := 1.0 + clampf(target_speed / 5.0, 0.0, 1.0) * 0.6
	var score := clampf(target_visibility * cone * vertical * dist_falloff * lit_at(target_point) * movement_mul, 0.0, 1.0)
	return {
		"visible": true,
		"score": score,
		"position": Vector3(target_point.x, 0.0, target_point.z),
		"distance": distance,
		"bearing": horizontal,
	}

func effective_range(body: CharacterBody3D, target_point: Vector3) -> float:
	if global_position.y - target_point.y > 1.0:
		return MAX_RANGE * ELEVATION_RANGE_BONUS
	return MAX_RANGE

func miss() -> Dictionary:
	return {"visible": false, "score": 0.0, "position": Vector3.ZERO, "distance": INF, "bearing": Vector3.ZERO}

func space_query(from: Vector3, to: Vector3) -> Dictionary:
	var body := get_parent() as CharacterBody3D
	var query := PhysicsRayQueryParameters3D.create(from, to)
	query.collision_mask = 1
	query.collide_with_areas = false
	query.exclude = [body.get_rid()]
	return body.get_world_3d().direct_space_state.intersect_ray(query)

func lit_at(point: Vector3) -> float:
	_throttle -= get_process_delta_time()
	if _throttle <= 0.0 or not _lit_valid:
		_throttle = lit_throttle
		_refresh_lit(point)
	return LIT_FULL if _lit_clear else LIT_SHADED

func _refresh_lit(point: Vector3) -> void:
	_lit_valid = true
	if sun == null:
		_lit_clear = true
		return
	var body := get_parent() as CharacterBody3D
	var sun_pos := sun.global_position
	var dir := sun_pos - point
	if dir.length_squared() < 0.001:
		_lit_clear = true
		return
	dir = dir.normalized()
	var start := point + Vector3.UP * 0.4
	var query := PhysicsRayQueryParameters3D.create(start, start + dir * SUN_SAMPLE_DIST)
	query.collision_mask = 1
	query.collide_with_areas = false
	query.exclude = [body.get_rid()]
	var hit := body.get_world_3d().direct_space_state.intersect_ray(query)
	_lit_clear = hit.is_empty()