class_name TacticalManager
extends Node

const ELEVATION_BASE := 0.0
const ELEVATION_THRESHOLD := 0.5
const OVERHEAD_PROBE := 4.0
const LATERAL_PROBE := 1.2
const LATERAL_HEIGHT := 0.45
const CONCEAL_RADIUS := 1.6
const STANCE_PROTECTION := {0: 0.0, 1: 0.2, 2: 0.3}
const ROUTE_SAMPLE_SPACING := 2.0
const ROUTE_MAX_SAMPLES := 12

var world: WorldStateManager

func setup(w: WorldStateManager) -> void:
	world = w

func classify_position(from_body: CharacterBody3D, position: Vector3) -> Dictionary:
	if from_body == null:
		return {}
	var space := from_body.get_world_3d().direct_space_state
	var exclude: Array[RID] = [from_body.get_rid()]
	var overhead := _blocked(space, position + Vector3.UP * 1.2, Vector3.UP, OVERHEAD_PROBE, exclude)
	var lateral := 0
	for direction in [Vector3.RIGHT, Vector3.LEFT, Vector3.FORWARD, Vector3.BACK]:
		if _blocked(space, position + Vector3.UP * LATERAL_HEIGHT, direction, LATERAL_PROBE, exclude):
			lateral += 1
	var near_conceal := _near_conceal(position)
	var elevated := position.y - ELEVATION_BASE > ELEVATION_THRESHOLD
	var classification := "EXPOSED_GROUND"
	if elevated and not overhead and lateral <= 1:
		classification = "ELEVATED_OBSERVATION"
	elif overhead and lateral >= 1:
		classification = "HARD_COVER"
	elif overhead or lateral >= 1 or near_conceal:
		classification = "SOFT_CONCEALMENT"
	var concealment := clampf((0.4 if overhead else 0.0) + lateral * 0.15 + (0.3 if near_conceal else 0.0), 0.0, 1.0)
	var observation := clampf((0.4 if elevated else 0.0) + (1.0 - lateral * 0.2) * 0.6, 0.0, 1.0)
	return {
		"classification": classification,
		"elevated": elevated,
		"overhead": overhead,
		"lateral_blocked": lateral,
		"near_conceal": near_conceal,
		"concealment_quality": concealment,
		"observation_quality": observation,
		"exposure_risk": clampf(1.0 - concealment, 0.0, 1.0),
	}

func assess_route(from_body: CharacterBody3D, from_position: Vector3, to_position: Vector3) -> Dictionary:
	if from_body == null:
		return {}
	var distance := from_position.distance_to(to_position)
	var sample_count := clampi(int(ceil(distance / ROUTE_SAMPLE_SPACING)) + 1, 2, ROUTE_MAX_SAMPLES)
	var exposed := 0
	var concealed := 0
	var current_run := 0
	var longest_run := 0
	var observation_sum := 0.0
	var best := {}
	var best_concealment := -1.0
	for i in range(sample_count):
		var point := from_position.lerp(to_position, float(i) / float(sample_count - 1))
		var report := classify_position(from_body, point)
		var cls := str(report.get("classification", "EXPOSED_GROUND"))
		if cls == "EXPOSED_GROUND":
			exposed += 1
			current_run = 0
		else:
			if cls == "HARD_COVER" or cls == "SOFT_CONCEALMENT":
				concealed += 1
			current_run += 1
			longest_run = maxi(longest_run, current_run)
		observation_sum += float(report.get("observation_quality", 0.0))
		var concealment := float(report.get("concealment_quality", 0.0))
		if concealment > best_concealment:
			best_concealment = concealment
			best = {"position": point, "classification": cls, "concealment_quality": concealment}
	var exposed_fraction := float(exposed) / float(sample_count)
	var classification := "MIXED_APPROACH"
	if exposed_fraction >= 0.6:
		classification = "EXPOSED_CROSSING"
	elif float(concealed) / float(sample_count) >= 0.6:
		classification = "CONCEALED_APPROACH"
	return {
		"classification": classification,
		"distance": distance,
		"samples": sample_count,
		"exposed_fraction": exposed_fraction,
		"concealment_chain": longest_run,
		"disturbance_risk": clampf(exposed_fraction, 0.0, 1.0),
		"observation_advantage": observation_sum / float(sample_count),
		"fallback": best,
	}

func assess_body(body: CharacterBody3D) -> Dictionary:
	if body == null:
		return {}
	var report := classify_position(body, body.global_position)
	if report.is_empty():
		return report
	var stance := 0
	var stance_node: Node = body.get_node_or_null("StanceController")
	if stance_node:
		stance = int(stance_node.get("current"))
	report["stance"] = stance
	var protection := float(STANCE_PROTECTION.get(stance, 0.0))
	report["stance_protection"] = protection
	report["exposure_risk"] = clampf(float(report.get("exposure_risk", 1.0)) - protection, 0.0, 1.0)
	return report

func _blocked(space: PhysicsDirectSpaceState3D, from: Vector3, direction: Vector3, length: float, exclude: Array[RID]) -> bool:
	var query := PhysicsRayQueryParameters3D.create(from, from + direction * length)
	query.collision_mask = 1
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.exclude = exclude
	return not space.intersect_ray(query).is_empty()

func _near_conceal(position: Vector3) -> bool:
	for node in get_tree().get_nodes_in_group("context_conceal"):
		var prop := node as Node3D
		if prop and position.distance_to(prop.global_position) <= CONCEAL_RADIUS:
			return true
	return false
