class_name TimeWeatherManager
extends Node

signal clock_advanced(hour: float)

const SLICE_START_HOUR := 8.0
const SLICE_END_HOUR := 18.0
const TIME_SCALE := 1.0
const WEATHER_RAIN_HOUR := 10.0
const WEATHER_STORM_HOUR := 14.0

@export var auto_weather := true

var world: WorldStateManager

var elapsed := 0.0
var hour := SLICE_START_HOUR
var weather_target := 0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	weather_target = 0

func setup(w: WorldStateManager) -> void:
	world = w

func restore_clock(restored_hour: float, restored_weather: String) -> void:
	hour = clampf(restored_hour, SLICE_START_HOUR, SLICE_END_HOUR)
	elapsed = (hour - SLICE_START_HOUR) * 60.0
	weather_target = world.WEATHER_STATES.find(restored_weather) if world else 0

func tick(delta: float) -> void:
	if world == null:
		return
	var step := delta * TIME_SCALE
	elapsed += step
	hour += step / 60.0
	if hour >= SLICE_END_HOUR:
		hour = SLICE_END_HOUR
	clock_advanced.emit(hour)
	world.set_channel(world.CHANNEL_TIME, _time_label())
	if auto_weather:
		_apply_schedule()

func _apply_schedule() -> void:
	var target := 0
	if hour >= WEATHER_STORM_HOUR:
		target = 2
	elif hour >= WEATHER_RAIN_HOUR:
		target = 1
	if target != weather_target:
		set_weather(target)

func _time_label() -> String:
	if hour < 9.0:
		return "DAWN"
	if hour < 17.0:
		return "DAY"
	if hour < 19.0:
		return "DUSK"
	return "NIGHT"

func set_weather(i: int) -> void:
	weather_target = i
	world.set_channel(world.CHANNEL_WEATHER, world.WEATHER_STATES[weather_target])
