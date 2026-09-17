class_name SignatureController
extends Node

signal visibility_changed(value: float)
signal noise_changed(value: float)
signal noise_event(origin: Vector3, volume: float, kind: String)

const STANCE_EXPOSURE := {0: 0.92, 1: 0.68, 2: 0.36}
const STANCE_NOISE := {0: 1.0, 1: 0.55, 2: 0.3}
const MOVE_NOISE_SPRINT := 1.45
const MOVE_NOISE_RUN := 1.0
const MOVE_NOISE_WALK := 0.72
const MOVE_NOISE_AIR := 0.85
const MOVE_NOISE_IDLE := 1.0
const SPEED_SPAN := 8.0
const AIRBORNE_PENALTY := 0.18
const LANDING_THRESHOLD := -6.0

@export var cover_probe_height := 4.0
@export var conceal_radius := 1.6
@export var throttle_interval := 0.2
@export var debug_log_enabled := false

var visibility := 0.0
var noise := 0.0

var environment_weather := "CLEAR"
var breathing := 0.0
var condition := "NORMAL"
var last_speed := 0.0
var last_stance := 0

func set_environment(weather: String, breathing_level: float, condition_state: String) -> void:
	environment_weather = weather
	breathing = clampf(breathing_level, 0.0, 1.0)
	condition = condition_state

func environment_noise_factor() -> float:
	var factor := 1.0
	match environment_weather:
		"RAIN":
			factor += 0.15
		"STORM":
			factor += 0.3
	match condition:
		"TIRED":
			factor += 0.1
		"EXHAUSTED":
			factor += 0.25
		"INJURED":
			factor += 0.15
	factor += breathing * 0.15
	return factor

func trace_intensity() -> float:
	return trace_intensity_for(last_speed, last_stance)

func trace_intensity_for(speed: float, stance: int) -> float:
	var base := clampf(speed / 7.0, 0.0, 1.0)
	match stance:
		1:
			base *= 0.5
		2:
			base *= 0.2
	var factor := 1.0
	match environment_weather:
		"RAIN":
			factor = 1.3
		"STORM":
			factor = 1.6
	return clampf(base * factor, 0.0, 1.0)

var prev_fall_speed := 0.0
var landing_spike := 0.0
var cover_found := false
var near_conceal := false

var _last_visibility := 0.0
var _last_noise := 0.0
var _throttle := 0.0
var _conceal_nodes: Array = []

var _step_accum := 0.0
var _prev_traversal_state := 0

func _ready() -> void:
	_conceal_nodes = get_tree().get_nodes_in_group("context_conceal")

func update(body: CharacterBody3D, stance: int, move_state: int, tactical_noise: float, traversal_state: int, delta: float) -> void:
	var fall_speed := body.velocity.y
	if body.is_on_floor() and prev_fall_speed < LANDING_THRESHOLD:
		landing_spike = clamp((-prev_fall_speed - LANDING_THRESHOLD) * 0.5, 0.0, 1.0)
	else:
		landing_spike = max(0.0, landing_spike - delta * 2.5)
	prev_fall_speed = fall_speed
	_throttle -= delta
	if _throttle <= 0.0:
		_throttle = throttle_interval
		update_cover(body)
	var horizontal_speed := Vector2(body.velocity.x, body.velocity.z).length()
	last_speed = horizontal_speed
	last_stance = stance
	visibility = compute_visibility(body, stance)
	noise = compute_noise(body, horizontal_speed, stance, move_state, tactical_noise, traversal_state)
	emit_events(body, horizontal_speed, stance, tactical_noise, traversal_state, delta)
	emit_changed()

func emit_events(body: CharacterBody3D, horizontal_speed: float, stance: int, tactical_noise: float, traversal_state: int, delta: float) -> void:
	if traversal_state != _prev_traversal_state:
		if _prev_traversal_state == 0 and traversal_state != 0:
			_emit_noise(body, 0.72, "CLAMBER")
		elif _prev_traversal_state != 0 and traversal_state == 0:
			_emit_noise(body, 0.4, "CLAMBER")
	_prev_traversal_state = traversal_state
	if body.is_on_floor() and prev_fall_speed < LANDING_THRESHOLD:
		var spike := clampf((-prev_fall_speed - LANDING_THRESHOLD) * 0.5, 0.0, 1.0)
		_emit_noise(body, 0.5 + spike * 0.5, "LANDING")
	if body.is_on_floor() and horizontal_speed > 0.2:
		var stance_gain := 1.0
		match stance:
			1:
				stance_gain = 0.5
			2:
				stance_gain = 0.28
		_step_accum += horizontal_speed * delta
		if _step_accum >= 0.9:
			_step_accum -= 0.9
			var speed_ref := clampf(horizontal_speed / 7.0, 0.0, 1.0)
			var volume := clampf((0.35 + 0.65 * speed_ref) * stance_gain * tactical_noise, 0.0, 1.0)
			_emit_noise(body, volume, "FOOTSTEP")

func _emit_noise(body: CharacterBody3D, volume: float, kind: String) -> void:
	noise_event.emit(body.global_position, volume, kind)

func compute_visibility(body: CharacterBody3D, stance: int) -> float:
	var base := float(STANCE_EXPOSURE.get(stance, 0.9))
	var factor := 1.0
	if near_conceal or cover_found:
		factor = 0.55
	var airborne := 0.0
	if not body.is_on_floor():
		airborne = AIRBORNE_PENALTY
	return clampf(base * factor + airborne, 0.0, 1.0)

func compute_noise(body: CharacterBody3D, horizontal_speed: float, stance: int, move_state: int, tactical_noise: float, traversal_state: int) -> float:
	var stance_mod := float(STANCE_NOISE.get(stance, 1.0))
	var speed_noise := clampf(horizontal_speed / SPEED_SPAN, 0.0, 1.0) * 0.75 + 0.05
	var move_mod := MOVE_NOISE_IDLE
	match move_state:
		3:
			move_mod = MOVE_NOISE_SPRINT
		2:
			move_mod = MOVE_NOISE_RUN
		1:
			move_mod = MOVE_NOISE_WALK
		4:
			move_mod = MOVE_NOISE_AIR
	var air_noise := 0.0
	if not body.is_on_floor():
		air_noise = 0.12
	var traversal_mod := 1.0
	if traversal_state != 0:
		traversal_mod = 1.3
	var raw := (speed_noise * move_mod + landing_spike + air_noise) * stance_mod * tactical_noise * traversal_mod
	raw *= environment_noise_factor()
	return clampf(raw, 0.0, 1.0)

func update_cover(body: CharacterBody3D) -> void:
	cover_found = false
	if _conceal_nodes.is_empty():
		_conceal_nodes = get_tree().get_nodes_in_group("context_conceal")
	var space := body.get_world_3d().direct_space_state
	var from := body.global_position + Vector3.UP * 1.2
	var to := from + Vector3.UP * cover_probe_height
	var query := PhysicsRayQueryParameters3D.create(from, to)
	query.collision_mask = 1
	query.collide_with_areas = false
	query.exclude = [body.get_rid()]
	cover_found = not space.intersect_ray(query).is_empty()
	near_conceal = false
	for node in _conceal_nodes:
		if not is_instance_valid(node):
			continue
		var prop := node as Node3D
		if body.global_position.distance_to(prop.global_position) <= conceal_radius:
			near_conceal = true
			break

func visibility_value() -> float:
	return snappedf(visibility, 0.01)

func noise_value() -> float:
	return snappedf(noise, 0.01)

func emit_changed() -> void:
	var vis := visibility_value()
	var nse := noise_value()
	visibility = vis
	noise = nse
	if vis != _last_visibility or nse != _last_noise:
		_last_visibility = vis
		_last_noise = nse
		visibility_changed.emit(vis)
		noise_changed.emit(nse)