class_name InteractionProbe
extends Node3D

signal activated(action: String, collider: Node)

const ACTIVATABLE := ["INSPECT", "OPEN", "COLLECT", "REST", "RECOVER", "SURVEY", "RECORD"]

@export var probe_length := 1.25
@export var low_probe_height := 0.45
@export var high_probe_height := 1.1
@export var top_clear_height := 1.9
@export var top_clear_distance := 0.5
@export var wall_top_probe_height := 2.6
@export var wall_top_inset := 0.25
@export var ledge_max := 1.6

var space_state: PhysicsDirectSpaceState3D
var exclude_rid: RID
var target: Dictionary = {}

func update_probe(body: CharacterBody3D) -> void:
	exclude_rid = body.get_rid()
	space_state = body.get_world_3d().direct_space_state
	target = {}
	var origin := body.global_position
	var forward := -body.global_transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()
	var high := cast_ray(origin + Vector3.UP * high_probe_height, forward, probe_length)
	var low := cast_ray(origin + Vector3.UP * low_probe_height, forward, probe_length * 0.8)
	var primary := pick_primary(high, low)
	if primary.is_empty():
		return
	var collider: Node = primary.get("collider") as Node
	if collider == null:
		return
	var wall_top: float = find_wall_top(primary, forward)
	var edge := INF
	if wall_top != INF:
		edge = wall_top - origin.y
	var clear := is_top_clear(primary, forward)
	target = {
		"collider": collider,
		"position": primary["position"],
		"normal": primary["normal"],
		"wall_top": wall_top,
		"edge_height": edge,
		"top_clear": clear,
	}

func pick_primary(high: Dictionary, low: Dictionary) -> Dictionary:
	if not high.is_empty():
		return high
	return low

func cast_ray(from: Vector3, direction: Vector3, max_distance: float) -> Dictionary:
	var query := PhysicsRayQueryParameters3D.create(from, from + direction * max_distance)
	query.collision_mask = 1
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.exclude = [exclude_rid]
	return space_state.intersect_ray(query)

func find_wall_top(hit: Dictionary, forward: Vector3) -> float:
	var sampling: Vector3 = hit["position"] + Vector3.UP * wall_top_probe_height + forward * wall_top_inset
	var probe := cast_ray(sampling, Vector3.DOWN, wall_top_probe_height + 3.0)
	if probe.is_empty():
		return INF
	return probe["position"].y

func is_top_clear(hit: Dictionary, forward: Vector3) -> bool:
	return cast_ray(hit["position"] + Vector3.UP * top_clear_height, forward, top_clear_distance).is_empty()

func context_action(stowed: bool) -> String:
	if target.is_empty():
		return ""
	var collider: Node = target.get("collider") as Node
	if collider.is_in_group("context_climb"):
		return "CLIMB"
	if collider.is_in_group("context_inspect"):
		return "INSPECT"
	if collider.is_in_group("context_open"):
		return "OPEN"
	if collider.is_in_group("context_collect"):
		return "COLLECT"
	if collider.is_in_group("context_rest"):
		return "REST"
	if collider.is_in_group("context_recover"):
		return "RECOVER"
	if collider.is_in_group("context_survey"):
		return "SURVEY"
	if collider.is_in_group("context_record"):
		return "RECORD"
	var edge: float = target.get("edge_height", INF)
	if target.get("top_clear", false):
		if edge <= 0.55 and edge > 0.08:
			return "VAULT"
		if edge <= 1.15 and edge > 0.55:
			return "MANTLE"
	if edge > 1.15 and edge <= ledge_max:
		return "LEDGE"
	if collider.is_in_group("context_conceal") and stowed:
		return "CONCEAL"
	return ""

func activate(stowed: bool) -> String:
	var action := context_action(stowed)
	if action in ACTIVATABLE:
		var collider: Node = target.get("collider") as Node
		activated.emit(action, collider)
		return action
	return ""