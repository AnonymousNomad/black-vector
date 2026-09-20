class_name WildernessAudio
extends Node3D

const SAMPLE_RATE := 22050.0

var _layers: Array[Dictionary] = []
var _wind_phase := 0.0
var _creek_phase := 0.0
var _forest_phase := 0.0
var _footstep_phase := 0.0
var _footstep_energy := 0.0
var _footstep_frequency := 90.0
var _last_surface := "SOIL"
var _footstep_count := 0

func _ready() -> void:
	add_to_group("wilderness_audio")
	call_deferred("_initialize_audio")

func _initialize_audio() -> void:
	_add_layer("WindAmbience", Vector3(0.0, 7.0, 0.0), 0.07, 0.0)
	_add_layer("ForestAmbience", Vector3(68.0, 2.0, 19.0), 0.035, -2.0)
	_add_layer("CreekAmbience", Vector3(58.0, 0.0, -19.0), 0.08, -4.0)
	_add_layer("SurfaceFootsteps", Vector3.ZERO, 0.16, -1.0)
	var player := get_tree().get_first_node_in_group("player")
	if player:
		var signature := player.get_node_or_null("SignatureController")
		if signature and signature.has_signal("noise_event"):
			signature.noise_event.connect(_on_noise_event)

func _add_layer(layer_name: String, position: Vector3, amplitude: float, volume_db: float) -> void:
	var stream := AudioStreamGenerator.new()
	stream.mix_rate = SAMPLE_RATE
	stream.buffer_length = 0.35
	var player := AudioStreamPlayer3D.new()
	player.name = layer_name
	player.stream = stream
	player.bus = "Env" if AudioServer.get_bus_index("Env") >= 0 else "Master"
	player.volume_db = volume_db
	player.position = position
	player.max_distance = 80.0
	player.unit_size = 12.0
	add_child(player)
	player.play()
	_layers.append({"name": layer_name, "player": player, "amplitude": amplitude})

func _process(delta: float) -> void:
	_wind_phase += delta
	_creek_phase += delta
	_forest_phase += delta
	_footstep_phase += delta
	_footstep_energy = maxf(0.0, _footstep_energy - delta * 2.8)
	for layer in _layers:
		_fill_layer(layer)

func _fill_layer(layer: Dictionary) -> void:
	var player := layer["player"] as AudioStreamPlayer3D
	var playback := player.get_stream_playback() as AudioStreamGeneratorPlayback
	if playback == null:
		return
	var frames := mini(playback.get_frames_available(), 512)
	for _i in range(frames):
		var value := 0.0
		match str(layer["name"]):
			"WindAmbience":
				value = (sin(_wind_phase * 0.63) + sin(_wind_phase * 1.71) * 0.45) * 0.38
			"ForestAmbience":
				value = (sin(_forest_phase * 0.37) + sin(_forest_phase * 2.4) * 0.22) * 0.22
			"CreekAmbience":
				value = (sin(_creek_phase * 4.7) + sin(_creek_phase * 7.9) * 0.4) * 0.32
			"SurfaceFootsteps":
				value = sin(_footstep_phase * _footstep_frequency) * _footstep_energy
		var sample := clampf(value * float(layer["amplitude"]), -0.7, 0.7)
		playback.push_frame(Vector2(sample, sample))

func _surface_at(position: Vector3) -> String:
	if position.x > 30.0 and position.x < 90.0 and absf(position.z + 19.0) < 7.0:
		return "WET"
	if position.x < 38.0 and absf(position.z) < 4.0:
		return "GRAVEL"
	if Vector2(position.x, position.z).distance_to(Vector2(52.0, 18.0)) < 24.0:
		return "ROCK"
	if absf(position.z) > 8.0:
		return "GRASS"
	return "SOIL"

func _on_noise_event(origin: Vector3, volume: float, kind: String) -> void:
	if kind != "FOOTSTEP":
		return
	_last_surface = _surface_at(origin)
	_footstep_count += 1
	_footstep_frequency = {"SOIL": 82.0, "GRASS": 68.0, "ROCK": 145.0, "GRAVEL": 116.0, "WET": 54.0}.get(_last_surface, 82.0)
	_footstep_energy = clampf(volume * 0.7, 0.0, 0.7)

func debug_line() -> String:
	return "AUDIO: wind/forest/creek | footsteps=%s count=%d" % [_last_surface, _footstep_count]
