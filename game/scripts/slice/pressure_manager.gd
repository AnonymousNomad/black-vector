class_name PressureManager
extends Node

signal condition_changed(state: String)

const CONDITION_NORMAL := "NORMAL"
const CONDITION_TIRED := "TIRED"
const CONDITION_EXHAUSTED := "EXHAUSTED"
const CONDITION_INJURED := "INJURED"
const CONDITION_EXPOSED := "EXPOSED"
const CONDITION_RECOVERING := "RECOVERING"

const RAIN_EXPOSURE_RATE := 0.05
const STORM_EXPOSURE_RATE := 0.09
const EXPOSURE_DECAY := 0.05
const HUNGER_RATE := 0.0008
const THIRST_RATE := 0.0012
const EXERTION_GAIN := 0.06
const EXERTION_DECAY := 0.04
const REST_EXERTION_DECAY := 0.12
const FATIGUE_GAIN := 0.02
const FATIGUE_DECAY := 0.01
const REST_FATIGUE_DECAY := 0.03
const REST_SPEED_EPS := 0.3
const MOVEMENT_SPEED_EPS := 2.0
const ZONE_SCAN_INTERVAL := 0.25

var world: WorldStateManager
var time_weather: TimeWeatherManager
var player_state: PlayerStateManager
var audio: AudioManager

var resting := false
var sheltered := false
var breathing := 0.0
var condition := CONDITION_NORMAL

var _zone_scan := 0.0

func setup(w: WorldStateManager, tw: TimeWeatherManager, ps: PlayerStateManager, au: AudioManager) -> void:
	world = w
	time_weather = tw
	player_state = ps
	audio = au

func start_rest() -> void:
	resting = true

func stop_rest() -> void:
	resting = false

func update(delta: float, player: CharacterBody3D) -> void:
	if player_state == null or player == null:
		return
	var speed := Vector2(player.velocity.x, player.velocity.z).length()
	if resting and speed > REST_SPEED_EPS:
		resting = false
	_zone_scan -= delta
	if _zone_scan <= 0.0:
		_zone_scan = ZONE_SCAN_INTERVAL
		sheltered = _compute_sheltered(player)
	var weather := "CLEAR"
	if world:
		weather = world.channel_value(world.CHANNEL_WEATHER)
	_accumulate_exertion(delta, speed)
	_accumulate_fatigue(delta)
	_accumulate_exposure(delta, weather)
	_accumulate_needs(delta)
	_update_breathing()
	_update_condition()

func _accumulate_exertion(delta: float, speed: float) -> void:
	var exertion := player_state.band("EXERTION")
	if resting:
		exertion -= REST_EXERTION_DECAY * delta
	elif speed > MOVEMENT_SPEED_EPS:
		exertion += clampf((speed - MOVEMENT_SPEED_EPS) / 5.0, 0.0, 1.0) * EXERTION_GAIN * delta
	else:
		exertion -= EXERTION_DECAY * delta
	player_state.set_band("EXERTION", exertion)

func _accumulate_fatigue(delta: float) -> void:
	var fatigue := player_state.band("FATIGUE")
	if resting:
		fatigue -= REST_FATIGUE_DECAY * delta
	elif player_state.band("EXERTION") > 0.6:
		fatigue += FATIGUE_GAIN * delta
	else:
		fatigue -= FATIGUE_DECAY * delta
	player_state.set_band("FATIGUE", fatigue)

func _accumulate_exposure(delta: float, weather: String) -> void:
	var rate := 0.0
	if weather == "RAIN":
		rate = RAIN_EXPOSURE_RATE
	elif weather == "STORM":
		rate = STORM_EXPOSURE_RATE
	var exposure := player_state.band("EXPOSURE")
	if rate > 0.0 and not sheltered:
		exposure += rate * delta
	else:
		exposure -= EXPOSURE_DECAY * delta
	player_state.set_band("EXPOSURE", exposure)

func _accumulate_needs(delta: float) -> void:
	var slow := 0.5 if resting else 1.0
	player_state.set_band("HUNGER", player_state.band("HUNGER") + HUNGER_RATE * slow * delta)
	player_state.set_band("THIRST", player_state.band("THIRST") + THIRST_RATE * slow * delta)

func _update_breathing() -> void:
	breathing = clampf(player_state.band("EXERTION") * 0.7 + player_state.band("EXPOSURE") * 0.3, 0.0, 1.0)
	if audio:
		audio.set_breathing(breathing)

func _compute_sheltered(player: CharacterBody3D) -> bool:
	for node in get_tree().get_nodes_in_group("shelter_zone"):
		var zone := node as Node3D
		if zone == null:
			continue
		var radius_v: Variant = zone.get("shelter_radius")
		if radius_v == null:
			continue
		var radius := float(radius_v)
		if radius > 0.0 and player.global_position.distance_to(zone.global_position) <= radius:
			return true
	return false

func _update_condition() -> void:
	var next := compute_condition()
	if next != condition:
		condition = next
		condition_changed.emit(condition)

func compute_condition() -> String:
	if resting:
		return CONDITION_RECOVERING
	if player_state.band("INJURY") > 0.5:
		return CONDITION_INJURED
	if player_state.band("EXERTION") > 0.75 or player_state.band("FATIGUE") > 0.75:
		return CONDITION_EXHAUSTED
	if player_state.band("EXPOSURE") > 0.4:
		return CONDITION_EXPOSED
	if player_state.band("EXERTION") > 0.4 or player_state.band("FATIGUE") > 0.4 or player_state.band("HUNGER") > 0.6 or player_state.band("THIRST") > 0.6:
		return CONDITION_TIRED
	return CONDITION_NORMAL
