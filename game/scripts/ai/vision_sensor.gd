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
@export var sensing_range := MAX_RANGE

var sun: Node = null
var _throttle := 0.0
var _lit_clear := true
var _lit_valid := false

func _ready() -> void:
	sun = get_tree().get_first_node_in_group("sun")

func sense(target_point: Vector3, target_speed: float, target_visibility: float,
		target_body: CharacterBody3D = null) -> Dictionary:
	var body := get_parent() as CharacterBody3D
	if target_body == null:
		target_body = get_tree().get_first_node_in_group("player") as CharacterBody3D
	var eye := global_position
	var to_target := target_point - eye
	var distance := to_target.length()
	if distance <= 0.001 or distance > effective_range(body, target_point):
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
	if not line_of_sight_clear(obst, target_body):
		return miss()
	var dist_falloff := clampf(1.0 - distance / effective_range(body, target_point), 0.0, 1.0)
	var movement_mul := 1.0 + clampf(target_speed / 5.0, 0.0, 1.0) * 0.6
	var vegetation_transmission := vegetation_line_transmission(eye, target_point)
	var score := clampf(target_visibility * cone * vertical * dist_falloff * lit_at(target_point) * movement_mul * vegetation_transmission, 0.0, 1.0)
	return {
		"visible": true,
		"score": score,
		"position": Vector3(target_point.x, 0.0, target_point.z),
		"distance": distance,
		"bearing": horizontal,
	}

func line_of_sight_clear(hit: Dictionary, target_body: CharacterBody3D) -> bool:
	var collider: Object = hit.get("collider")
	return collider == null or collider == target_body

func effective_range(body: CharacterBody3D, target_point: Vector3) -> float:
	if global_position.y - target_point.y > 1.0:
		return sensing_range * ELEVATION_RANGE_BONUS
	return sensing_range

func vegetation_line_transmission(from: Vector3, to: Vector3) -> float:
	var region := get_tree().get_first_node_in_group("visual_wilderness_region") as VisualWildernessProof1
	if region == null:
		return 1.0
	return region.vegetation_line_transmission(from, to)

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
	var body := get_parent() as CharacterBody3D
	if body == null:
		_lit_clear = false
		return
	if _lit_by_local_fixture(point, body):
		_lit_clear = true
		return
	var light := sun as DirectionalLight3D
	if light == null or light.light_energy <= 0.01:
		_lit_clear = false
		return
	var toward_light: Vector3 = light.global_transform.basis.z.normalized()
	if toward_light.dot(Vector3.UP) <= 0.01:
		_lit_clear = false
		return
	var query := PhysicsRayQueryParameters3D.create(point + Vector3.UP * 0.2, point + toward_light * SUN_SAMPLE_DIST)
	query.collision_mask = 1
	query.collide_with_areas = false
	query.exclude = _perception_exclusions(body)
	var hit := body.get_world_3d().direct_space_state.intersect_ray(query)
	_lit_clear = hit.is_empty()

func _lit_by_local_fixture(point: Vector3, body: CharacterBody3D) -> bool:
	for node in get_tree().get_nodes_in_group("perception_light"):
		var fixture := node as OmniLight3D
		if fixture == null or not fixture.visible or fixture.light_energy <= 0.01:
			continue
		if fixture.global_position.distance_to(point) > fixture.omni_range:
			continue
		var query := PhysicsRayQueryParameters3D.create(fixture.global_position, point)
		query.collision_mask = 1
		query.collide_with_areas = false
		query.exclude = _perception_exclusions(body)
		if body.get_world_3d().direct_space_state.intersect_ray(query).is_empty():
			return true
	return false

func _perception_exclusions(body: CharacterBody3D) -> Array[RID]:
	var excluded: Array[RID] = [body.get_rid()]
	var target := get_tree().get_first_node_in_group("player") as CharacterBody3D
	if target != null:
		excluded.append(target.get_rid())
	return excluded
