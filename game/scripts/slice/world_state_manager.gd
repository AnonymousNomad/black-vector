class_name WorldStateManager
extends Node

signal channel_changed(channel: String)
signal object_changed(id: String)
signal poi_added(id: String)
signal field_record_changed(kind: String)
signal trace_recorded(kind: String)
signal route_recorded(id: String)
signal human_evidence_added(id: String)
signal awareness_changed(id: String)
signal contact_recorded(id: String)

const FIELD_RECORD_CAP := 64
const POI_CAP := 32
const TRACE_CAP := 32
const ROUTE_CAP := 24
const ROUTE_MERGE_RADIUS := 2.5
const HUMAN_EVIDENCE_UNCERTAIN := 1
const HUMAN_EVIDENCE_SUSPICIOUS := 4

const CHANNEL_TIME := "TIME_OF_DAY"
const CHANNEL_WEATHER := "WEATHER"
const CHANNEL_FACILITY := "FACILITY_STATE"
const CHANNEL_AFTERMATH := "LOCAL_AFTERMATH"
const CHANNEL_WILDLIFE := "WILDLIFE_SIGNAL"

const TIME_STATES := ["DAWN", "DAY", "DUSK", "NIGHT"]
const WEATHER_STATES := ["CLEAR", "RAIN", "STORM"]

var seed_value: int = 0

var _channels := {}
var objects := {}
var observations := {}
var pois := {}
var field_record: Array = []
var traces: Array = []
var routes: Array = []
var human_records := {}
var awareness_records := {}
var contact_records := {}
var narrative_seen := {}
var clock_hour := 0.0

func _ready() -> void:
	_channels[CHANNEL_TIME] = ["DAWN", 0]
	_channels[CHANNEL_WEATHER] = ["CLEAR", 0]
	_channels[CHANNEL_FACILITY] = ["DORMANT", 0]
	_channels[CHANNEL_AFTERMATH] = ["NONE", 0]
	_channels[CHANNEL_WILDLIFE] = ["QUIET", 0]

func seed(s: int) -> void:
	seed_value = s

func channel(c: String) -> Array:
	return _channels[c]

func set_channel(c: String, value: String) -> void:
	if _channels.has(c):
		_channels[c] = [value, _channels[c][1] + 1]
		channel_changed.emit(c)

func channel_value(c: String) -> String:
	return _channels[c][0]

func channel_rev(c: String) -> int:
	return _channels[c][1]

func mark_object(id: String, verb: String) -> void:
	if not objects.has(id):
		objects[id] = {}
	objects[id][verb] = true
	object_changed.emit(id)

func object_state(id: String) -> Dictionary:
	return objects.get(id, {})

func mark_observation(id: String, kind: String) -> void:
	observations[id] = kind

func observation_kind(id: String) -> String:
	return str(observations.get(id, ""))

func register_poi(id: String, kind: String, position: Vector3, distance: float, bearing: float) -> Dictionary:
	pois[id] = {
		"kind": kind,
		"position": [position.x, position.y, position.z],
		"distance": distance,
		"bearing": bearing,
		"time": channel_value(CHANNEL_TIME),
	}
	if pois.size() > POI_CAP:
		pois.erase(pois.keys()[0])
	poi_added.emit(id)
	return pois[id]

func poi_near(position: Vector3, radius: float) -> bool:
	for id in pois.keys():
		var p: Array = pois[id].get("position", [])
		if p.size() == 3 and Vector3(float(p[0]), float(p[1]), float(p[2])).distance_to(position) <= radius:
			return true
	return false

func nearest_poi(position: Vector3) -> Dictionary:
	var best := {}
	var best_distance := INF
	for id in pois.keys():
		var p: Array = pois[id].get("position", [])
		if p.size() != 3:
			continue
		var distance := Vector3(float(p[0]), float(p[1]), float(p[2])).distance_to(position)
		if distance < best_distance:
			best_distance = distance
			best = pois[id]
	return best

func add_field_entry(kind: String, subject: String, detail: String, position: Vector3) -> Dictionary:
	var entry := {
		"kind": kind,
		"subject": subject,
		"detail": detail,
		"position": [position.x, position.y, position.z],
		"time": channel_value(CHANNEL_TIME),
	}
	field_record.append(entry)
	if field_record.size() > FIELD_RECORD_CAP:
		field_record.pop_front()
	field_record_changed.emit(kind)
	return entry

func record_trace(kind: String, position: Vector3, intensity: float, detail := "", source := "") -> Dictionary:
	var trace := {
		"kind": kind,
		"position": [position.x, position.y, position.z],
		"intensity": clampf(intensity, 0.0, 1.0),
		"detail": detail,
		"source": source,
		"hour": clock_hour,
	}
	traces.append(trace)
	if traces.size() > TRACE_CAP:
		traces.pop_front()
	trace_recorded.emit(kind)
	return trace

func record_route(from_position: Vector3, to_position: Vector3, classification: String, disturbance_risk: float) -> Dictionary:
	for route in routes:
		var to_point: Array = route.get("to", [])
		if to_point.size() != 3:
			continue
		var target := Vector3(float(to_point[0]), float(to_point[1]), float(to_point[2]))
		if target.distance_to(to_position) <= ROUTE_MERGE_RADIUS:
			route["classification"] = classification
			route["disturbance_risk"] = clampf(disturbance_risk, 0.0, 1.0)
			route["count"] = int(route.get("count", 0)) + 1
			route["last_hour"] = clock_hour
			route_recorded.emit(str(route.get("id", "")))
			return route
	var entry := {
		"id": "route_%02d" % (routes.size() + 1),
		"from": [from_position.x, from_position.y, from_position.z],
		"to": [to_position.x, to_position.y, to_position.z],
		"classification": classification,
		"disturbance_risk": clampf(disturbance_risk, 0.0, 1.0),
		"count": 1,
		"first_hour": clock_hour,
		"last_hour": clock_hour,
		"disturbance": _disturbances_near(to_position, 2.5),
	}
	routes.append(entry)
	if routes.size() > ROUTE_CAP:
		routes.pop_front()
	route_recorded.emit(str(entry.get("id", "")))
	return entry

func _disturbances_near(position: Vector3, radius: float) -> int:
	var count := 0
	for trace in traces:
		var p: Array = trace.get("position", [])
		if p.size() == 3 and Vector3(float(p[0]), float(p[1]), float(p[2])).distance_to(position) <= radius:
			count += 1
	return count

func add_human_evidence(id: String) -> Dictionary:
	if id == "":
		return {}
	if not human_records.has(id):
		human_records[id] = {"evidence": 0, "level": "UNKNOWN", "first_hour": clock_hour}
	var record: Dictionary = human_records[id]
	record["evidence"] = int(record.get("evidence", 0)) + 1
	record["last_hour"] = clock_hour
	record["level"] = _human_level_for(int(record["evidence"]))
	human_evidence_added.emit(id)
	return record

func human_record(id: String) -> Dictionary:
	return human_records.get(id, {})

func human_level(id: String) -> String:
	return str(human_records.get(id, {}).get("level", "UNKNOWN"))

func set_human_threat(id: String, level: String) -> void:
	if id == "":
		return
	if not human_records.has(id):
		human_records[id] = {"evidence": 0, "level": level, "first_hour": clock_hour}
	else:
		human_records[id]["level"] = level
	human_evidence_added.emit(id)

func _human_level_for(evidence: int) -> String:
	if evidence >= HUMAN_EVIDENCE_SUSPICIOUS:
		return "SUSPICIOUS"
	if evidence >= HUMAN_EVIDENCE_UNCERTAIN:
		return "UNCERTAIN"
	return "UNKNOWN"

func set_awareness(id: String, snapshot: Dictionary) -> void:
	if id == "":
		return
	awareness_records[id] = snapshot.duplicate(true)
	awareness_changed.emit(id)

func awareness_record(id: String) -> Dictionary:
	return awareness_records.get(id, {})

func record_contact(id: String, data: Dictionary) -> Dictionary:
	if id == "":
		return {}
	var record: Dictionary = contact_records.get(id, {})
	if not record.has("first_hour") and data.has("first_hour"):
		record["first_hour"] = data["first_hour"]
	for key in data.keys():
		if key == "first_hour" and record.has("first_hour"):
			continue
		record[key] = data[key]
	record["id"] = id
	contact_records[id] = record
	contact_recorded.emit(id)
	return record

func contact_record(id: String) -> Dictionary:
	return contact_records.get(id, {})

func mark_seen(id: String) -> void:
	if id != "":
		narrative_seen[id] = true

func has_seen(id: String) -> bool:
	return bool(narrative_seen.get(id, false))

func snapshot() -> Dictionary:
	return {
		"seed": seed_value,
		"time": channel_value(CHANNEL_TIME),
		"time_rev": channel_rev(CHANNEL_TIME),
		"weather": channel_value(CHANNEL_WEATHER),
		"weather_rev": channel_rev(CHANNEL_WEATHER),
		"facility": channel_value(CHANNEL_FACILITY),
		"facility_rev": channel_rev(CHANNEL_FACILITY),
		"aftermath": channel_value(CHANNEL_AFTERMATH),
		"aftermath_rev": channel_rev(CHANNEL_AFTERMATH),
		"wildlife": channel_value(CHANNEL_WILDLIFE),
		"wildlife_rev": channel_rev(CHANNEL_WILDLIFE),
		"objects": objects.duplicate(true),
		"observations": observations.duplicate(true),
		"pois": pois.duplicate(true),
		"field_record": field_record.duplicate(true),
		"traces": traces.duplicate(true),
		"routes": routes.duplicate(true),
		"human_records": human_records.duplicate(true),
		"awareness_records": awareness_records.duplicate(true),
		"contact_records": contact_records.duplicate(true),
		"narrative_seen": narrative_seen.duplicate(true),
	}

func restore(snap: Dictionary) -> void:
	seed_value = int(snap.get("seed", 0))
	set_channel(CHANNEL_TIME, snap.get("time", "DAWN"))
	set_channel(CHANNEL_WEATHER, snap.get("weather", "CLEAR"))
	set_channel(CHANNEL_FACILITY, snap.get("facility", "DORMANT"))
	set_channel(CHANNEL_AFTERMATH, snap.get("aftermath", "NONE"))
	set_channel(CHANNEL_WILDLIFE, snap.get("wildlife", "QUIET"))
	var objs: Variant = snap.get("objects", {})
	if objs is Dictionary:
		objects = (objs as Dictionary).duplicate(true)
	var obs: Variant = snap.get("observations", {})
	if obs is Dictionary:
		observations = (obs as Dictionary).duplicate(true)
	if snap.has("pois"):
		var poi_data: Variant = snap["pois"]
		if poi_data is Dictionary:
			pois = (poi_data as Dictionary).duplicate(true)
	if snap.has("field_record"):
		var record: Variant = snap["field_record"]
		if record is Array:
			field_record = (record as Array).duplicate(true)
	if snap.has("traces"):
		var trace_data: Variant = snap["traces"]
		if trace_data is Array:
			traces = (trace_data as Array).duplicate(true)
	if snap.has("routes"):
		var route_data: Variant = snap["routes"]
		if route_data is Array:
			routes = (route_data as Array).duplicate(true)
	if snap.has("human_records"):
		var human_data: Variant = snap["human_records"]
		if human_data is Dictionary:
			human_records = (human_data as Dictionary).duplicate(true)
	if snap.has("awareness_records"):
		var awareness_data: Variant = snap["awareness_records"]
		if awareness_data is Dictionary:
			awareness_records = (awareness_data as Dictionary).duplicate(true)
	if snap.has("contact_records"):
		var contact_data: Variant = snap["contact_records"]
		if contact_data is Dictionary:
			contact_records = (contact_data as Dictionary).duplicate(true)
	if snap.has("narrative_seen"):
		var seen_data: Variant = snap["narrative_seen"]
		if seen_data is Dictionary:
			narrative_seen = (seen_data as Dictionary).duplicate(true)