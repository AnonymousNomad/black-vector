class_name ContactManager
extends Node

signal contact_changed(presence_id: String, state_name: String)
signal presentation_event(presence_id: String, event_name: String, data: Dictionary)
signal speech_received(presence_id: String, intent: String, outcome: String)

enum State { NO_CONTACT, MUTUAL_AWARENESS, CAUTIOUS, FEARFUL, COMMUNICATING, DISENGAGING, WITHDRAWN }

const STATE_NAMES := ["NO_CONTACT", "MUTUAL_AWARENESS", "CAUTIOUS", "FEARFUL", "COMMUNICATING", "DISENGAGING", "WITHDRAWN"]

const RECOGNITION_RANGE := 18.0
const RECOGNITION_HALF_ANGLE := 1.2
const CLOSE_RANGE := 3.0
const CAUTIOUS_DISTANCE := 4.5
const FEARFUL_THRESHOLD := 0.55
const DISENGAGE_DISTANCE := 7.0
const WITHDRAWN_DISTANCE := 12.0
const VOICE_RANGE := 20.0
const CALLOUT_WINDOW := 2.0
const FEARFUL_HOLD := 0.8
const MIRROR_INTERVAL := 1.0
const EMERGE_WINDOW := 2.0
const EMERGE_RANGE := 6.0
const STILL_SPEED := 0.4
const MOVING_TOWARD_DOT := 0.3

var world: WorldStateManager
var channels: NarrativeChannels
var recon: ReconManager

var selected_intent := "ACKNOWLEDGE"
var contacts := {}

var _clock := 0.0
var _callout_time := -999.0
var _mirror_clock := 0.0

func setup(w: WorldStateManager, n: NarrativeChannels, r: ReconManager = null) -> void:
	world = w
	channels = n
	recon = r
	if channels and not channels.spoken.is_connected(_on_spoken):
		channels.spoken.connect(_on_spoken)

func update(delta: float, player: CharacterBody3D) -> void:
	if world == null or player == null:
		return
	_clock += delta
	for node in get_tree().get_nodes_in_group("human_presence"):
		var presence := node as HumanPresence
		if presence == null:
			continue
		_evaluate(presence, player, delta)
	_mirror_clock -= delta
	if _mirror_clock <= 0.0:
		_mirror_clock = MIRROR_INTERVAL
		_mirror()

func cycle_intent() -> String:
	var list := NarrativeChannels.INTENTS
	var index := list.find(selected_intent)
	index = (index + 1) % list.size()
	selected_intent = list[index]
	return selected_intent

func speak_selected() -> String:
	var player := get_tree().get_first_node_in_group("player") as Node3D
	var origin := player.global_position if player else Vector3.ZERO
	if channels:
		channels.speak(selected_intent, {"origin": [origin.x, origin.y, origin.z]})
	return selected_intent

func state_index_for(id: String) -> int:
	var rec: Dictionary = contacts.get(id, {})
	return int(rec.get("state", State.NO_CONTACT))

func state_name_for(id: String) -> String:
	return STATE_NAMES[state_index_for(id)]

func reaction_for(id: String) -> HumanReaction:
	var rec: Dictionary = contacts.get(id, {})
	var reaction: Variant = rec.get("reaction")
	if reaction is HumanReaction:
		return reaction
	return HumanReaction.new()

func runtime_record(id: String) -> Dictionary:
	return contacts.get(id, {})

func has_contact(id: String) -> bool:
	var rec: Dictionary = contacts.get(id, {})
	return bool(rec.get("occurred", false))

func snapshot() -> Dictionary:
	var out := {}
	for id in contacts.keys():
		var rec: Dictionary = contacts[id]
		if not bool(rec.get("occurred", false)):
			continue
		out[id] = {
			"outcome": STATE_NAMES[int(rec.get("state", 0))],
			"communicated": bool(rec.get("communicated", false)),
			"withdrew": bool(rec.get("withdrew", false)),
		}
	return out

func restore_from(records: Dictionary) -> void:
	if records == null or records.is_empty():
		return
	for id in records.keys():
		var data: Dictionary = records[id]
		var rec := _record_for_id(str(id))
		var outcome := str(data.get("outcome", "NO_CONTACT"))
		var index := STATE_NAMES.find(outcome)
		rec["state"] = index if index >= 0 else State.NO_CONTACT
		rec["occurred"] = bool(data.get("occurred", true))
		rec["contact_hour"] = float(data.get("first_hour", -1.0))
		rec["communicated"] = bool(data.get("communicated", false))
		rec["withdrew"] = bool(data.get("withdrew", false))
		rec["contact_position"] = _to_vec(data.get("position", []), Vector3.ZERO)
		rec["last_position"] = _to_vec(data.get("last_position", []), Vector3.ZERO)
		rec["reaction"] = HumanReaction.new()
		rec["fearful_time"] = 0.0
		_apply_activity(str(id), int(rec["state"]), false)

func _evaluate(presence: HumanPresence, player: CharacterBody3D, delta: float) -> void:
	var id := presence.presence_id
	var rec := _record_for(presence)
	var reaction: HumanReaction = rec["reaction"]

	var offset := presence.global_position - player.global_position
	var distance := offset.length()
	var los := _los_clear(player, presence.global_position, presence)

	var awareness := presence.get_node_or_null("Awareness") as HumanAwareness
	var human_sees := awareness != null and awareness.can_see_player(player)
	var close := distance <= CLOSE_RANGE and los
	var player_sees := _player_sees_presence(player, presence, distance, los)
	var called_out := (_clock - _callout_time) <= CALLOUT_WINDOW and distance <= VOICE_RANGE
	var mutual := (human_sees or close) and (player_sees or close or called_out)

	var velocity := player.velocity
	var speed := Vector2(velocity.x, velocity.z).length()
	var flat_offset := Vector3(offset.x, 0.0, offset.z)
	var moving_toward := false
	if speed > 0.5 and flat_offset.length() > 0.01:
		var heading := Vector3(velocity.x, 0.0, velocity.z).normalized()
		moving_toward = heading.dot(flat_offset.normalized()) > MOVING_TOWARD_DOT

	var posture := "STAND"
	var condition := "NORMAL"
	var body := player.get_node_or_null("BodyState") as BodyState
	if body:
		posture = body.posture
		condition = body.condition
	var injured := condition == "INJURED" or condition == "EXHAUSTED"

	var signature := player.get_node_or_null("SignatureController") as SignatureController
	var near_conceal := signature != null and signature.near_conceal

	if (bool(rec["prev_near_conceal"]) or str(rec["prev_posture"]) == "CROUCH" or str(rec["prev_posture"]) == "PRONE") \
			and not near_conceal and posture == "STAND" and distance <= EMERGE_RANGE:
		rec["emerged_until"] = _clock + EMERGE_WINDOW
	rec["prev_near_conceal"] = near_conceal
	rec["prev_posture"] = posture
	var emerged := _clock <= float(rec["emerged_until"])

	var suspicion := awareness.suspicion if awareness != null else 0.0
	reaction.assess({
		"distance": distance,
		"approach_speed": speed,
		"moving_toward": moving_toward,
		"emerged": emerged,
		"recent_suspicion": suspicion,
		"stopped": speed <= STILL_SPEED,
		"posture": posture,
		"injured": injured,
	}, delta)

	rec["last_distance"] = distance
	rec["approach_speed"] = speed
	rec["last_position"] = presence.global_position

	_advance_state(presence, rec, reaction, mutual, distance, speed, moving_toward, delta)

func _advance_state(presence: HumanPresence, rec: Dictionary, reaction: HumanReaction, mutual: bool, distance: float, speed: float, moving_toward: bool, delta: float) -> void:
	var state := int(rec["state"])
	var fast_approach := speed > HumanReaction.FAST_APPROACH
	match state:
		State.NO_CONTACT:
			if mutual:
				rec["occurred"] = true
				rec["contact_hour"] = world.clock_hour
				rec["contact_position"] = presence.global_position
				_set_state(presence, rec, State.MUTUAL_AWARENESS)
		State.MUTUAL_AWARENESS:
			if reaction.fear >= FEARFUL_THRESHOLD or (fast_approach and moving_toward):
				_enter_fear(presence, rec)
			elif distance <= CAUTIOUS_DISTANCE and speed <= HumanReaction.SLOW_APPROACH:
				_set_state(presence, rec, State.CAUTIOUS)
			elif not mutual and distance > DISENGAGE_DISTANCE:
				_set_state(presence, rec, State.DISENGAGING)
		State.CAUTIOUS:
			if reaction.fear >= FEARFUL_THRESHOLD or (fast_approach and moving_toward):
				_enter_fear(presence, rec)
			elif distance > DISENGAGE_DISTANCE:
				_set_state(presence, rec, State.DISENGAGING)
		State.FEARFUL:
			rec["fearful_time"] = float(rec.get("fearful_time", 0.0)) + delta
			if reaction.fear >= 0.3:
				rec["withdrew"] = true
			if float(rec.get("fearful_time", 0.0)) >= FEARFUL_HOLD:
				_set_state(presence, rec, State.DISENGAGING)
		State.COMMUNICATING:
			if reaction.fear >= FEARFUL_THRESHOLD:
				_enter_fear(presence, rec)
			elif distance > DISENGAGE_DISTANCE:
				_set_state(presence, rec, State.DISENGAGING)
		State.DISENGAGING:
			if distance >= WITHDRAWN_DISTANCE:
				_set_state(presence, rec, State.WITHDRAWN)
			elif fast_approach and moving_toward:
				_enter_fear(presence, rec)
		State.WITHDRAWN:
			if fast_approach and moving_toward and distance < CAUTIOUS_DISTANCE:
				_enter_fear(presence, rec)

func _enter_fear(presence: HumanPresence, rec: Dictionary) -> void:
	rec["fearful_time"] = 0.0
	_set_state(presence, rec, State.FEARFUL)

func _set_state(presence: HumanPresence, rec: Dictionary, new_state: int) -> void:
	if int(rec["state"]) == new_state:
		return
	rec["state"] = new_state
	rec["fearful_time"] = 0.0
	_apply_activity(presence.presence_id, new_state, true)
	contact_changed.emit(presence.presence_id, STATE_NAMES[new_state])
	_record_world(presence.presence_id, rec)

func _apply_activity(id: String, state: int, emit_presentation: bool) -> void:
	var presence := _presence_by_id(id)
	var activity := _activity_for(state)
	if presence and activity != "":
		presence.activity = activity
	if not emit_presentation:
		return
	match state:
		State.MUTUAL_AWARENESS:
			presentation_event.emit(id, "look_orientation", {})
		State.CAUTIOUS:
			presentation_event.emit(id, "hesitation", {})
		State.FEARFUL:
			presentation_event.emit(id, "fear_posture", {})
		State.COMMUNICATING:
			presentation_event.emit(id, "listening", {})
		State.DISENGAGING:
			presentation_event.emit(id, "backing_away", {})
		State.WITHDRAWN:
			presentation_event.emit(id, "silence", {})

func _activity_for(state: int) -> String:
	match state:
		State.MUTUAL_AWARENESS:
			return "WATCHING"
		State.CAUTIOUS:
			return "LISTENING"
		State.FEARFUL:
			return "ALERT"
		State.COMMUNICATING:
			return "LISTENING"
		State.DISENGAGING:
			return "WITHDRAWING"
		State.WITHDRAWN:
			return "SHELTERING"
		_:
			return ""

func _on_spoken(intent: String, text_key: String, context: Dictionary) -> void:
	_callout_time = _clock
	if world == null:
		return
	var origin := Vector3.ZERO
	if context.has("origin"):
		origin = _to_vec(context.get("origin", []), Vector3.ZERO)
	else:
		var player := get_tree().get_first_node_in_group("player") as Node3D
		if player:
			origin = player.global_position
	for node in get_tree().get_nodes_in_group("human_presence"):
		var presence := node as HumanPresence
		if presence == null:
			continue
		if origin.distance_to(presence.global_position) > VOICE_RANGE:
			continue
		var rec := _record_for(presence)
		presence.receive_speech(intent, text_key, context)
		rec["spoken_count"] = int(rec.get("spoken_count", 0)) + 1
		rec["communicated"] = true
		var outcome := _apply_speech(presence, rec, intent)
		speech_received.emit(presence.presence_id, intent, outcome)
		_record_world(presence.presence_id, rec)

func _apply_speech(presence: HumanPresence, rec: Dictionary, intent: String) -> String:
	var reaction: HumanReaction = rec["reaction"]
	var state := int(rec["state"])
	var outcome := "SILENT"
	if reaction.fear >= 0.6:
		outcome = "WITHDRAWN"
	elif reaction.fear >= 0.3:
		outcome = "REFUSED"
	elif intent == "ACKNOWLEDGE" or intent == "WAIT" or intent == "QUESTION":
		outcome = "RESPONDED"
	match intent:
		"BACK_OFF":
			if state == State.MUTUAL_AWARENESS or state == State.CAUTIOUS or state == State.COMMUNICATING:
				rec["withdrew"] = true
				_set_state(presence, rec, State.DISENGAGING)
		"WARN":
			reaction.fear = minf(1.0, reaction.fear + 0.2)
			if reaction.fear >= FEARFUL_THRESHOLD and state != State.FEARFUL:
				_enter_fear(presence, rec)
		"ACKNOWLEDGE", "QUESTION":
			if state == State.MUTUAL_AWARENESS or state == State.CAUTIOUS:
				_set_state(presence, rec, State.COMMUNICATING)
		"WAIT":
			presentation_event.emit(presence.presence_id, "hesitation", {})
	return outcome

func _record_for(presence: HumanPresence) -> Dictionary:
	return _record_for_id(presence.presence_id)

func _record_for_id(id: String) -> Dictionary:
	if not contacts.has(id):
		contacts[id] = {
			"state": State.NO_CONTACT,
			"reaction": HumanReaction.new(),
			"occurred": false,
			"communicated": false,
			"withdrew": false,
			"spoken_count": 0,
			"contact_hour": -1.0,
			"contact_position": Vector3.ZERO,
			"last_position": Vector3.ZERO,
			"last_distance": 99.0,
			"approach_speed": 0.0,
			"fearful_time": 0.0,
			"emerged_until": -999.0,
			"prev_near_conceal": false,
			"prev_posture": "STAND",
		}
	return contacts[id]

func _record_world(id: String, rec: Dictionary) -> void:
	if world == null:
		return
	var data := {
		"occurred": bool(rec.get("occurred", false)),
		"outcome": STATE_NAMES[int(rec.get("state", 0))],
		"position": _vec_arr(rec.get("contact_position", Vector3.ZERO)),
		"last_position": _vec_arr(rec.get("last_position", Vector3.ZERO)),
		"last_hour": world.clock_hour,
		"communicated": bool(rec.get("communicated", false)),
		"withdrew": bool(rec.get("withdrew", false)),
	}
	if float(rec.get("contact_hour", -1.0)) >= 0.0:
		data["first_hour"] = rec["contact_hour"]
	world.record_contact(id, data)

func _mirror() -> void:
	for id in contacts.keys():
		var rec: Dictionary = contacts[id]
		if bool(rec.get("occurred", false)):
			_record_world(str(id), rec)

func _presence_by_id(id: String) -> HumanPresence:
	for node in get_tree().get_nodes_in_group("human_presence"):
		var presence := node as HumanPresence
		if presence and presence.presence_id == id:
			return presence
	return null

func _player_sees_presence(player: CharacterBody3D, presence: HumanPresence, distance: float, los: bool) -> bool:
	if distance > RECOGNITION_RANGE or not los:
		return false
	var eye := player.global_position + Vector3.UP * 1.5
	var target := presence.global_position + Vector3.UP * 1.0
	var to_target := target - eye
	var forward := -player.global_transform.basis.z
	forward.y = 0.0
	var flat := Vector3(to_target.x, 0.0, to_target.z)
	if flat.length() > 0.01 and forward.angle_to(flat.normalized()) > RECOGNITION_HALF_ANGLE:
		return false
	return true

func _los_clear(from_body: Node3D, target_position: Vector3, target_body: Node) -> bool:
	var space := from_body.get_world_3d().direct_space_state
	var from := from_body.global_position + Vector3.UP * 1.3
	var target := target_position + Vector3.UP * 1.0
	var query := PhysicsRayQueryParameters3D.create(from, target)
	query.collision_mask = 1
	query.collide_with_areas = false
	query.collide_with_bodies = true
	query.exclude = [from_body.get_rid()]
	var hit := space.intersect_ray(query)
	if hit.is_empty():
		return true
	var collider: Node = hit.get("collider") as Node
	return collider == target_body

func _vec_arr(value: Variant) -> Array:
	if value is Vector3:
		var v := value as Vector3
		return [v.x, v.y, v.z]
	return []

func _to_vec(value: Variant, fallback: Vector3) -> Vector3:
	if value is Array and (value as Array).size() == 3:
		return Vector3(float(value[0]), float(value[1]), float(value[2]))
	return fallback
