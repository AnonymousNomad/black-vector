class_name Observer
extends CharacterBody3D

signal suspicion_changed(state: int)

enum Suspicion { NORMAL, CURIOUS, ALERT, SEARCHING, COMBAT_READY }

@export var gravity := 22.0
@export var walk_speed := 2.2
@export var face_speed := 6.0
@export var arrive_distance := 1.2
@export var dwell_time := 1.6
@export var search_radius := 10.0
@export var vision_gate := 0.25
@export var detect_gate := 0.5
@export var confidence_gain := 0.35
@export var confidence_decay := 0.05
@export var idle_watch_point := Vector3.ZERO
@export var debug_log_enabled := false

var suspicion := Suspicion.NORMAL
var confidence := 0.0
var last_known := Vector3.ZERO
var search_points: Array[Vector3] = []
var search_index := 0
var current_target := Vector3.ZERO
var gist := ""
var spawn_anchor := Vector3.ZERO

var _dwell_timer := 0.0
var _stuck_timer := 0.0
var _last_dist := INF
var _contact_this_frame := false
var _player: Node = null
var _vision: Node = null
var _hearing: Node = null

func _ready() -> void:
	add_to_group("observer")
	spawn_anchor = global_position
	current_target = spawn_anchor
	_vision = $VisionSensor
	_hearing = $HearingSensor
	_hearing.heard.connect(_on_heard)
	_player = get_tree().get_first_node_in_group("player")
	if _player:
		var signature = _player.get_node_or_null("SignatureController")
		if signature:
			signature.noise_event.connect(_hearing.on_noise_event)
	reset_state()
	log_change("observer", "ready")

func reset_state() -> void:
	suspicion = Suspicion.NORMAL
	confidence = 0.0
	last_known = Vector3.ZERO
	search_points.clear()
	search_index = 0
	current_target = spawn_anchor
	gist = ""
	_dwell_timer = 0.0
	_stuck_timer = 0.0
	_last_dist = INF
	_contact_this_frame = false
	global_position = spawn_anchor
	emit_state()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_reset_observer"):
		reset_state()
		return
	_contact_this_frame = false
	_consume_sensors(delta)
	_decide(delta)
	_act(delta)

func _consume_sensors(delta: float) -> void:
	if _player == null:
		_player = get_tree().get_first_node_in_group("player")
		if _player == null:
			return
	var cb := _player as CharacterBody3D
	var horizontal_speed := Vector2(cb.velocity.x, cb.velocity.z).length()
	var visibility := 0.9
	var signature = _player.get_node_or_null("SignatureController")
	if signature:
		visibility = signature.visibility_value()
	var obs: Dictionary = _vision.sense(cb.global_position + Vector3.UP * 1.0, horizontal_speed, visibility)
	if obs.get("visible", false):
		_contact_this_frame = true
		if obs["score"] >= detect_gate:
			_confirm_visual(obs, delta)
		elif obs["score"] >= vision_gate:
			_glimpse_visual(obs, delta)

func _confirm_visual(obs: Dictionary, delta: float) -> void:
	last_known = obs["position"]
	gist = "They're right there. Holding."
	confidence = minf(1.0, confidence + confidence_gain * delta * obs["score"])
	if suspicion < Suspicion.ALERT:
		set_suspicion(Suspicion.ALERT)
	if confidence >= 0.9 and suspicion == Suspicion.ALERT:
		set_suspicion(Suspicion.COMBAT_READY)

func _glimpse_visual(obs: Dictionary, _delta: float) -> void:
	var spread := Vector3(randf_range(-3.0, 3.0), 0.0, randf_range(-3.0, 3.0))
	last_known = obs["position"] + spread
	gist = "Movement in the trees?"
	confidence = maxf(confidence, 0.18)
	if suspicion < Suspicion.CURIOUS:
		set_suspicion(Suspicion.CURIOUS)

func _on_heard(position: Vector3, heard_confidence: float) -> void:
	_contact_this_frame = true
	last_known = position
	gist = "Something near the structure."
	confidence = minf(1.0, confidence + heard_confidence * 0.6)
	if suspicion < Suspicion.CURIOUS:
		set_suspicion(Suspicion.CURIOUS)

func _decide(delta: float) -> void:
	if suspicion == Suspicion.SEARCHING:
		_advance_search(delta)
		return
	if not _contact_this_frame:
		confidence -= confidence_decay * delta
		if suspicion == Suspicion.ALERT:
			set_suspicion(Suspicion.SEARCHING)
			_begin_search()
			return
		elif suspicion == Suspicion.CURIOUS and last_known != Vector3.ZERO:
			current_target = last_known
			var dist := Vector2(current_target.x - global_position.x, current_target.z - global_position.z).length()
			if dist <= arrive_distance:
				set_suspicion(Suspicion.SEARCHING)
				_begin_search()
				return
		elif last_known == Vector3.ZERO:
			set_suspicion(Suspicion.NORMAL)
	if confidence <= 0.02 and suspicion < Suspicion.SEARCHING:
		set_suspicion(Suspicion.NORMAL)
		last_known = Vector3.ZERO
		current_target = spawn_anchor

func _begin_search() -> void:
	build_search_points()
	search_index = 0
	current_target = search_points[0] if search_points.size() > 0 else last_known
	_last_dist = INF
	_stuck_timer = 0.0
	_dwell_timer = 0.0
	gist = "Searching the area."

func build_search_points() -> void:
	search_points.clear()
	var center := last_known
	var tagged := get_tree().get_nodes_in_group("observer_search")
	for search_node in tagged:
		if not is_instance_valid(search_node):
			continue
		var point := (search_node as Node3D).global_position
		if point.distance_to(center) <= search_radius * 1.4:
			search_points.append(point)
	for i in range(4):
		var radius := search_radius * 0.6
		var offset := Vector3.ZERO
		match i:
			0:
				offset = Vector3(radius, 0.0, 0.0)
			1:
				offset = Vector3(-radius, 0.0, 0.0)
			2:
				offset = Vector3(0.0, 0.0, radius)
			3:
				offset = Vector3(0.0, 0.0, -radius)
		search_points.append(center + offset)
	search_points.append(center)

func _advance_search(delta: float) -> void:
	if _contact_this_frame:
		set_suspicion(Suspicion.ALERT)
		return
	if search_points.size() == 0:
		end_search()
		return
	var dist := Vector2(current_target.x - global_position.x, current_target.z - global_position.z).length()
	if dist <= arrive_distance:
		_dwell_timer += delta
		gist = "Checking cover."
		if _dwell_timer >= dwell_time:
			_dwell_timer = 0.0
			advance_search_point()
	else:
		if dist >= _last_dist:
			_stuck_timer += delta
		else:
			_stuck_timer = 0.0
		_last_dist = dist
		if _stuck_timer >= 3.0:
			_stuck_timer = 0.0
			advance_search_point()
	confidence -= confidence_decay * delta * 0.5

func advance_search_point() -> void:
	search_index += 1
	if search_index >= search_points.size():
		end_search()
		return
	current_target = search_points[search_index]
	_last_dist = INF

func end_search() -> void:
	confidence = 0.0
	last_known = Vector3.ZERO
	search_points.clear()
	set_suspicion(Suspicion.NORMAL)
	current_target = spawn_anchor
	gist = ""

func _act(delta: float) -> void:
	var moving := false
	var speed := walk_speed
	var face_dir := Vector3.ZERO
	match suspicion:
		Suspicion.NORMAL:
			face_dir = idle_watch_point - global_position
		Suspicion.CURIOUS:
			if last_known != Vector3.ZERO:
				current_target = last_known
			moving = true
			face_dir = current_target - global_position
		Suspicion.ALERT:
			moving = true
			speed = 0.6
			face_dir = last_known - global_position
		Suspicion.SEARCHING:
			moving = true
			face_dir = current_target - global_position
		Suspicion.COMBAT_READY:
			face_dir = last_known - global_position
	face_dir.y = 0.0
	if face_dir.length_squared() > 0.01:
		face_dir = face_dir.normalized()
		_face(face_dir, delta)
	var desired := Vector3.ZERO
	if moving:
		var to_target := current_target - global_position
		to_target.y = 0.0
		if to_target.length() > arrive_distance:
			desired = to_target.normalized() * speed
		else:
			desired = Vector3.ZERO
	velocity.x = desired.x
	velocity.z = desired.z
	velocity.y -= gravity * delta
	move_and_slide()

func _face(direction: Vector3, delta: float) -> void:
	var target_yaw := atan2(-direction.x, -direction.z)
	rotation.y = lerp_angle(rotation.y, target_yaw, clampf(face_speed * delta, 0.0, 1.0))

func set_suspicion(new_state: int) -> void:
	if new_state == suspicion:
		return
	suspicion = new_state
	emit_state()
	log_change("suspicion", suspicion)

func emit_state() -> void:
	suspicion_changed.emit(suspicion)

func state_name() -> String:
	match suspicion:
		Suspicion.CURIOUS:
			return "CURIOUS"
		Suspicion.ALERT:
			return "ALERT"
		Suspicion.SEARCHING:
			return "SEARCHING"
		Suspicion.COMBAT_READY:
			return "COMBAT_READY"
		_:
			return "NORMAL"

func posture_name() -> String:
	match suspicion:
		Suspicion.CURIOUS:
			return "wary"
		Suspicion.ALERT:
			return "focused"
		Suspicion.SEARCHING:
			return "investigating"
		Suspicion.COMBAT_READY:
			return "hunting"
		_:
			return "calm"

func debug_line() -> String:
	var base := "AI: %s (%s) | SUSP: %d | CONF %.2f | LKL %s | %s" % [state_name(), posture_name(), suspicion, confidence, lkl_str(), gist]
	return base

func lkl_str() -> String:
	if confidence <= 0.02:
		return "none"
	return str(Vector3(snappedf(last_known.x, 0.1), 0.0, snappedf(last_known.z, 0.1)))

func log_change(system: String, value: Variant) -> void:
	if debug_log_enabled:
		print("BV.DEBUG." + system + " -> " + str(value))