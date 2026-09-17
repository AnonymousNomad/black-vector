class_name ReconManager
extends Node

signal poi_registered(poi: Dictionary)
signal signal_noted(kind: String, position: Vector3)

const SCAN_HEIGHT := 1.5
const SCAN_DISTANCE := 40.0
const SCAN_DOWN_TILT := 0.364
const POI_DEDUPE_RADIUS := 2.0
const TRACE_READ_RADIUS := 6.0
const TRACE_RECENT_HOURS := 0.5
const TRACE_OLD_HOURS := 2.0
const TRACE_ERASED_HOURS := 6.0
const OVERWATCH_QUALITY := 0.55
const HUMAN_READ_RADIUS := 8.0
const HUMAN_PRESENCE_RADIUS := 12.0

var world: WorldStateManager
var tactical: TacticalManager
var contact: ContactManager

func setup(w: WorldStateManager, t: TacticalManager = null, c: ContactManager = null) -> void:
	world = w
	tactical = t
	contact = c

func survey(player: CharacterBody3D) -> Dictionary:
	if world == null or player == null:
		return {}
	var origin := player.global_position + Vector3.UP * SCAN_HEIGHT
	var forward := -player.global_transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()
	var space := player.get_world_3d().direct_space_state
	var exclude: Array[RID] = [player.get_rid()]
	var query := PhysicsRayQueryParameters3D.create(origin, origin + forward * SCAN_DISTANCE)
	query.collision_mask = 1
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.exclude = exclude
	var hit := space.intersect_ray(query)
	if hit.is_empty():
		var tilted := (forward + Vector3.DOWN * SCAN_DOWN_TILT).normalized()
		var terrain_query := PhysicsRayQueryParameters3D.create(origin, origin + tilted * SCAN_DISTANCE)
		terrain_query.collision_mask = 1
		terrain_query.collide_with_areas = false
		terrain_query.collide_with_bodies = true
		terrain_query.exclude = exclude
		hit = space.intersect_ray(terrain_query)
	if hit.is_empty():
		return {}
	var point: Vector3 = hit["position"]
	if world.poi_near(point, POI_DEDUPE_RADIUS):
		var existing := world.nearest_poi(point)
		record_route_memory(player, origin, point, existing)
		return existing
	var collider: Node = hit.get("collider") as Node
	var kind := classify_target(collider)
	var id := "poi_%02d" % (world.pois.size() + 1)
	var distance := player.global_position.distance_to(point)
	var bearing := rad_to_deg(atan2(forward.x, -forward.z))
	var poi := world.register_poi(id, kind, point, distance, bearing)
	world.add_field_entry("NOTICED", id, kind.to_lower(), point)
	var assessment := {}
	if tactical:
		assessment = tactical.classify_position(player, origin)
		for key in assessment.keys():
			poi[key] = assessment[key]
	var trace_note := trace_note_at(point, TRACE_READ_RADIUS)
	if trace_note != "":
		poi["trace_report"] = trace_note
		world.add_field_entry("DOCUMENTED", "traces", trace_note, point)
	var human_note := human_report_at(point)
	if human_note != "":
		poi["human_report"] = human_note
		world.add_field_entry("DOCUMENTED", "human activity", human_note, point)
	if not assessment.is_empty() and float(assessment.get("observation_quality", 0.0)) >= OVERWATCH_QUALITY:
		var overwatch_id := "overwatch_%02d" % (world.pois.size() + 1)
		world.register_poi(overwatch_id, "OVERWATCH", origin, 0.0, bearing)
		world.add_field_entry("NOTICED", overwatch_id, "overwatch position", origin)
	record_route_memory(player, origin, point, poi)
	poi_registered.emit(poi)
	return poi

func record_route_memory(player: CharacterBody3D, origin: Vector3, point: Vector3, poi: Dictionary) -> void:
	if tactical == null or poi.is_empty():
		return
	var route := tactical.assess_route(player, origin, point)
	if route.is_empty():
		return
	poi["route"] = route.get("classification", "")
	poi["route_risk"] = route.get("disturbance_risk", 0.0)
	var entry := world.record_route(origin, point, str(route.get("classification", "")), float(route.get("disturbance_risk", 0.0)))
	world.add_field_entry("ROUTE OBSERVED", str(entry.get("id", "route")), str(route.get("classification", "")).to_lower(), point)

func trace_note_at(position: Vector3, radius: float) -> String:
	var best := {}
	var best_distance := INF
	for trace in world.traces:
		var p: Array = trace.get("position", [])
		if p.size() != 3:
			continue
		var distance := Vector3(float(p[0]), float(p[1]), float(p[2])).distance_to(position)
		if distance <= radius and distance < best_distance:
			best_distance = distance
			best = trace
	if best.is_empty():
		return ""
	var kind := str(best.get("kind", "TRACE")).to_lower()
	if kind == "sound":
		kind = "unknown movement"
	return "%s %s trace" % [trace_freshness(best).to_lower(), kind]

func trace_freshness(trace: Dictionary) -> String:
	if world == null:
		return "UNKNOWN"
	var age := world.clock_hour - float(trace.get("hour", 0.0))
	var factor := 1.0
	match world.channel_value(world.CHANNEL_WEATHER):
		"RAIN":
			factor = 3.0
		"STORM":
			factor = 5.0
	var effective := age * factor
	if effective >= TRACE_ERASED_HOURS:
		return "ERASED"
	if effective >= TRACE_OLD_HOURS:
		return "OLD"
	if effective >= TRACE_RECENT_HOURS:
		return "RECENT"
	return "FRESH"

func note_signal(kind: String, position: Vector3) -> void:
	if world:
		var id := "signal_%02d" % (world.pois.size() + 1)
		world.register_poi(id, "UNKNOWN_SIGNAL", position, 0.0, 0.0)
		world.add_field_entry("NOTICED", id, kind.to_lower(), position)
	signal_noted.emit(kind, position)

func classify_target(collider: Node) -> String:
	if collider == null:
		return "TERRAIN"
	if collider.is_in_group("human_presence"):
		return "HUMAN"
	var trace: Variant = collider.get("trace_kind")
	if trace != null and str(trace) != "":
		return "TRACE"
	var affordance: Variant = collider.get("affordance")
	if affordance != null and str(affordance) != "":
		return "STRUCTURE"
	return "TERRAIN"

func human_report_at(position: Vector3, radius := HUMAN_READ_RADIUS) -> String:
	if world == null:
		return ""
	var nearest := {}
	var nearest_distance := INF
	for trace in world.traces:
		var source := str(trace.get("source", ""))
		if source == "":
			continue
		var p: Array = trace.get("position", [])
		if p.size() != 3:
			continue
		var distance := Vector3(float(p[0]), float(p[1]), float(p[2])).distance_to(position)
		if distance <= radius and distance < nearest_distance:
			nearest_distance = distance
			nearest = trace
	var note := ""
	if not nearest.is_empty():
		var freshness := trace_freshness(nearest)
		if freshness == "FRESH":
			note = "unknown person passed here recently"
		elif freshness == "RECENT":
			note = "signs of someone passing"
		else:
			note = "old trace of passage"
		world.add_human_evidence(str(nearest.get("source", "")))
	for node in get_tree().get_nodes_in_group("human_presence"):
		var presence := node as HumanPresence
		if presence == null:
			continue
		if presence.global_position.distance_to(position) <= HUMAN_PRESENCE_RADIUS:
			var phrase := presence_phrase(presence)
			if phrase != "":
				note = phrase if note == "" else note + "; " + phrase
			world.add_human_evidence(presence.presence_id)
	return note

func presence_phrase(presence: HumanPresence) -> String:
	if contact and contact.has_contact(presence.presence_id):
		var phrase := contact_phrase(presence)
		if phrase != "":
			return phrase
	match presence.activity:
		"SHELTERING":
			return "someone is sheltering nearby"
		"LISTENING":
			return "person appears to be listening"
		"MOVING":
			return "movement pattern changed"
		"SEARCHING":
			return "person is searching nearby"
		"STILL":
			return "person stopped moving"
		"WATCHING":
			return "person has noticed you"
		"ALERT":
			return "person appears frightened"
		"WITHDRAWING":
			return "person is withdrawing"
		_:
			return "human activity detected"

func contact_phrase(presence: HumanPresence) -> String:
	if contact == null:
		return ""
	var state := contact.state_name_for(presence.presence_id)
	match state:
		"MUTUAL_AWARENESS":
			return "person has noticed you"
		"CAUTIOUS":
			return "person appears cautious"
		"FEARFUL":
			return "person appears frightened"
		"COMMUNICATING":
			return "person is responding to you"
		"DISENGAGING":
			return "person appears unwilling to approach"
		"WITHDRAWN":
			return "person has withdrawn"
	var reaction := contact.reaction_for(presence.presence_id)
	if reaction.distance_preference_band() == "STRONG":
		return "person is maintaining distance"
	return ""
