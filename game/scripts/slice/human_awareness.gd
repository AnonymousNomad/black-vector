class_name HumanAwareness
extends Node

enum State { UNAWARE, SUSPICIOUS, SEARCHING, TRACKING, LOSING_CONTACT }

const STATE_NAMES := ["UNAWARE", "SUSPICIOUS", "SEARCHING", "TRACKING", "LOSING_CONTACT"]

const SIGHT_RANGE := 18.0
const SIGHT_HALF_ANGLE := 1.2
const SIGHT_THRESHOLD := 0.5
const SIGHT_TRACK_TIME := 1.5
const EVIDENCE_RADIUS := 6.0
const SOUND_RADIUS := 16.0
const SUSPICION_SUSPICIOUS := 0.3
const SUSPICION_SEARCHING := 0.55
const SUSPICION_DECAY := 0.06
const SUSPICION_SOUND := 0.35
const SUSPICION_FOOTPRINT := 0.3
const SUSPICION_MOVE_OBJECT := 0.25
const LOSE_SECONDS := 6.0
const LOSE_HOLD_SECONDS := 4.0
const SEARCH_SAMPLE_RADIUS := 2.2
const SEARCH_SAMPLE_COUNT := 3
const INSPECT_SECONDS := 2.0
const SEARCH_SPEED := 1.4
const TURN_SPEED := 3.5
const ARRIVE_DISTANCE := 1.2
const DISCOVERY_INTERVAL := 0.5
const MIRROR_INTERVAL := 1.0

var presence: HumanPresence
var world: WorldStateManager
var recon: ReconManager

var state: int = State.UNAWARE
var suspicion := 0.0
var last_known_position := Vector3.ZERO
var last_known_time := 0.0
var investigation_target := Vector3.ZERO
var evidence_source := ""
var evidence_confidence := 0.0

var _sight_time := 0.0
var _contact_clock := 999.0
var _lose_time := 0.0
var _discovery_clock := 0.0
var _mirror_clock := 0.0
var _inspect_time := 0.0
var _samples: Array[Vector3] = []
var _seen_traces := {}

func bind(p: HumanPresence, w: WorldStateManager, r: ReconManager) -> void:
	presence = p
	world = w
	recon = r

func update(delta: float, player: CharacterBody3D) -> void:
	if presence == null or world == null:
		return
	if player != null:
		if can_see_player(player):
			_sight_time += delta
			last_known_position = player.global_position
			last_known_time = world.clock_hour
			evidence_source = "SIGHT"
			evidence_confidence = 1.0
			suspicion = minf(1.0, suspicion + delta * 0.6)
			_contact_clock = 0.0
		else:
			_sight_time = maxf(0.0, _sight_time - delta * 0.7)
	if _sight_time <= 0.0:
		suspicion = maxf(0.0, suspicion - SUSPICION_DECAY * delta)
	_scan_traces(delta)
	_contact_clock += delta
	_update_state(delta)
	_behave(delta)
	_mirror_clock -= delta
	if _mirror_clock <= 0.0:
		_mirror_clock = MIRROR_INTERVAL
		mirror()

func state_name() -> String:
	return STATE_NAMES[state]

func can_see_player(player: CharacterBody3D) -> bool:
	if presence == null or player == null:
		return false
	var eye := presence.global_position + Vector3.UP * 1.5
	var target := player.global_position + Vector3.UP * 1.0
	var to_target := target - eye
	var distance := to_target.length()
	if distance > SIGHT_RANGE:
		return false
	var forward := -presence.global_transform.basis.z
	forward.y = 0.0
	var flat := Vector3(to_target.x, 0.0, to_target.z)
	if flat.length() > 0.01 and forward.angle_to(flat.normalized()) > SIGHT_HALF_ANGLE:
		return false
	var space := presence.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(eye, target)
	query.collision_mask = 1
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.exclude = [presence.get_rid()]
	var hit := space.intersect_ray(query)
	if not hit.is_empty():
		var collider: Node = hit.get("collider") as Node
		if collider != player:
			return false
	var signature: Node = player.get_node_or_null("SignatureController")
	if signature == null:
		return false
	return float(signature.get("visibility")) >= SIGHT_THRESHOLD

func trace_usable(trace: Dictionary) -> bool:
	if world == null or presence == null:
		return false
	if str(trace.get("source", "")) == presence.presence_id:
		return false
	if recon:
		if recon.trace_freshness(trace) == "ERASED":
			return false
	return true

func snapshot() -> Dictionary:
	return {
		"state": state_name(),
		"last_known_position": [last_known_position.x, last_known_position.y, last_known_position.z],
		"last_known_time": last_known_time,
		"investigation_target": [investigation_target.x, investigation_target.y, investigation_target.z],
		"evidence_source": evidence_source,
		"evidence_confidence": evidence_confidence,
		"suspicion": suspicion,
	}

func restore_from(record: Dictionary) -> void:
	if record.is_empty():
		return
	var restored := STATE_NAMES.find(str(record.get("state", "UNAWARE")))
	state = restored if restored >= 0 else State.UNAWARE
	suspicion = float(record.get("suspicion", 0.0))
	last_known_position = _to_vec3(record.get("last_known_position", []), last_known_position)
	last_known_time = float(record.get("last_known_time", 0.0))
	investigation_target = _to_vec3(record.get("investigation_target", []), investigation_target)
	evidence_source = str(record.get("evidence_source", ""))
	evidence_confidence = float(record.get("evidence_confidence", 0.0))

func mirror() -> void:
	if world && presence:
		world.set_awareness(presence.presence_id, snapshot())

func _to_vec3(value: Variant, fallback: Vector3) -> Vector3:
	if value is Array and (value as Array).size() == 3:
		return Vector3(float(value[0]), float(value[1]), float(value[2]))
	return fallback

func _scan_traces(delta: float) -> void:
	_discovery_clock -= delta
	if _discovery_clock > 0.0:
		return
	_discovery_clock = DISCOVERY_INTERVAL
	for trace in world.traces:
		var key := _trace_key(trace)
		if _seen_traces.has(key):
			continue
		var source := str(trace.get("source", ""))
		if source == presence.presence_id:
			_seen_traces[key] = true
			continue
		var p: Array = trace.get("position", [])
		if p.size() != 3:
			continue
		var position := Vector3(float(p[0]), float(p[1]), float(p[2]))
		var distance := presence.global_position.distance_to(position)
		var kind := str(trace.get("kind", ""))
		var intensity := float(trace.get("intensity", 0.0))
		if kind == "SOUND":
			if distance <= SOUND_RADIUS * (0.6 + 0.4 * intensity):
				_seen_traces[key] = true
				_register_stimulus(position, "SOUND", SUSPICION_SOUND * (0.5 + 0.5 * intensity), intensity)
		elif kind == "FOOTPRINT" or kind == "MOVE_OBJECT":
			if distance > EVIDENCE_RADIUS:
				continue
			if not trace_usable(trace):
				_seen_traces[key] = true
				continue
			if _blocked_to(position):
				continue
			_seen_traces[key] = true
			var amount := SUSPICION_FOOTPRINT if kind == "FOOTPRINT" else SUSPICION_MOVE_OBJECT
			var fresh := recon == null or recon.trace_freshness(trace) == "FRESH"
			_register_stimulus(position, kind, amount, intensity)
			if state == State.SEARCHING and fresh:
				_set_state(State.TRACKING)

func _register_stimulus(position: Vector3, source: String, amount: float, intensity: float) -> void:
	var point := _approximate(position, source)
	investigation_target = point
	last_known_position = position
	last_known_time = world.clock_hour
	evidence_source = source
	evidence_confidence = clampf(intensity, 0.0, 1.0)
	suspicion = minf(1.0, suspicion + amount)
	_contact_clock = 0.0
	_inspect_time = 0.0
	_samples = _make_samples(point)
	if state == State.UNAWARE and suspicion >= SUSPICION_SUSPICIOUS:
		_set_state(State.SUSPICIOUS)

func _blocked_to(position: Vector3) -> bool:
	var eye := presence.global_position + Vector3.UP * 1.5
	var target := position + Vector3.UP * 0.2
	var space := presence.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(eye, target)
	query.collision_mask = 1
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.exclude = [presence.get_rid()]
	return not space.intersect_ray(query).is_empty()

func _trace_key(trace: Dictionary) -> String:
	var p: Array = trace.get("position", [])
	return "%s|%s|%s|%s" % [str(trace.get("kind", "")), str(p), str(trace.get("hour", 0.0)), str(trace.get("source", ""))]

func _approximate(position: Vector3, salt: String) -> Vector3:
	var h := absf(float(hash("%s|%s" % [str(position), salt])))
	var angle := fmod(h, 360.0) / 360.0 * TAU
	var radius := 0.4 + fmod(h * 0.37, 1.0) * 0.6
	return position + Vector3(cos(angle) * radius, 0.0, sin(angle) * radius)

func _make_samples(center: Vector3) -> Array[Vector3]:
	var out: Array[Vector3] = [center]
	var h := absf(float(hash(str(center))))
	for i in range(SEARCH_SAMPLE_COUNT):
		var angle := fmod(h * (0.17 + 0.11 * float(i)), 360.0) / 360.0 * TAU
		out.append(center + Vector3(cos(angle), 0.0, sin(angle)) * SEARCH_SAMPLE_RADIUS)
	return out

func _update_state(delta: float) -> void:
	match state:
		State.UNAWARE:
			if suspicion >= SUSPICION_SUSPICIOUS:
				_set_state(State.SUSPICIOUS)
		State.SUSPICIOUS:
			if _sight_time >= SIGHT_TRACK_TIME:
				_set_state(State.TRACKING)
			elif suspicion >= SUSPICION_SEARCHING:
				_set_state(State.SEARCHING)
			elif suspicion < SUSPICION_SUSPICIOUS * 0.5:
				_set_state(State.UNAWARE)
		State.SEARCHING:
			if _sight_time >= SIGHT_TRACK_TIME:
				_set_state(State.TRACKING)
			elif suspicion < SUSPICION_SUSPICIOUS * 0.5:
				_set_state(State.UNAWARE)
		State.TRACKING:
			if _sight_time < SIGHT_TRACK_TIME and _contact_clock > LOSE_SECONDS:
				_set_state(State.LOSING_CONTACT)
				_lose_time = 0.0
		State.LOSING_CONTACT:
			if _sight_time >= SIGHT_TRACK_TIME or _contact_clock <= LOSE_SECONDS * 0.5:
				_set_state(State.TRACKING)
			else:
				_lose_time += delta
				if _lose_time >= LOSE_HOLD_SECONDS:
					if suspicion >= SUSPICION_SEARCHING:
						_set_state(State.SEARCHING)
					else:
						_set_state(State.UNAWARE)

func _set_state(new_state: int) -> void:
	if new_state == state:
		return
	state = new_state
	match state:
		State.SUSPICIOUS:
			presence.activity = "LISTENING"
		State.SEARCHING:
			presence.activity = "SEARCHING"
		State.TRACKING:
			presence.activity = "MOVING"
		State.LOSING_CONTACT:
			presence.activity = "STILL"
		State.UNAWARE:
			presence.activity = "SHELTERING"
	mirror()

func _behave(delta: float) -> void:
	if state == State.UNAWARE:
		presence.velocity = Vector3.ZERO
		presence.move_and_slide()
		return
	if investigation_target == Vector3.ZERO and not _samples.is_empty():
		investigation_target = _samples[0]
	if state == State.TRACKING and _sight_time > 0.0:
		investigation_target = last_known_position
	var to := investigation_target - presence.global_position
	to.y = 0.0
	var distance := to.length()
	if distance > ARRIVE_DISTANCE:
		var direction := to / distance
		presence.velocity = direction * SEARCH_SPEED
		var desired_yaw := atan2(-direction.x, -direction.z)
		presence.rotation.y = lerp_angle(presence.rotation.y, desired_yaw, clampf(TURN_SPEED * delta, 0.0, 1.0))
	else:
		presence.velocity = Vector3.ZERO
		_inspect_time += delta
		presence.rotation.y += delta * 0.6
		if _inspect_time >= INSPECT_SECONDS:
			_inspect_time = 0.0
			_advance_sample()
	presence.move_and_slide()

func _advance_sample() -> void:
	if _samples.size() > 1:
		_samples.pop_front()
		investigation_target = _samples[0]
	elif state != State.UNAWARE:
		_samples = _make_samples(last_known_position)
		investigation_target = _samples[0]
