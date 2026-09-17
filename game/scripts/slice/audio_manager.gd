class_name AudioManager
extends Node

const BUS_MASTER := "Master"
const BUS_ENV := "Env"
const BUS_COMBAT := "Combat"
const BUS_ANOMALY := "Anomaly"

var created_buses: Array[String] = []
var env_volume := 0.0
var enabled := true
var breathing := 0.0
var weather_layer := "CLEAR"

func set_breathing(level: float) -> void:
	breathing = clampf(level, 0.0, 1.0)

func set_weather_audio(state: String) -> void:
	weather_layer = state

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS if enabled else Node.PROCESS_MODE_DISABLED
	create_buses()
	reset_volumes()

func create_buses() -> void:
	for bus_name in [BUS_ENV, BUS_COMBAT, BUS_ANOMALY]:
		if AudioServer.get_bus_index(bus_name) == -1:
			AudioServer.add_bus()
			var idx := AudioServer.bus_count - 1
			AudioServer.set_bus_name(idx, bus_name)
			created_buses.append(bus_name)

func reset_volumes() -> void:
	env_volume = 1.0
	for bus_name in created_buses:
		var idx := AudioServer.get_bus_index(bus_name)
		if idx >= 0:
			AudioServer.set_bus_volume_db(idx, linear_to_db(1.0))

func set_env_volume(value: float) -> void:
	env_volume = clampf(value, 0.0, 1.0)
	var idx := AudioServer.get_bus_index(BUS_ENV)
	if idx >= 0:
		AudioServer.set_bus_volume_db(idx, linear_to_db(env_volume))

func enable(value: bool) -> void:
	enabled = value
	set_process_mode(Node.PROCESS_MODE_ALWAYS if value else Node.PROCESS_MODE_DISABLED)