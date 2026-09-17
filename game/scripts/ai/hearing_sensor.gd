class_name HearingSensor
extends Node

signal heard(position: Vector3, confidence: float)

@export var hearing_radius := 14.0
@export var hearing_threshold := 0.15
@export var position_scatter := 7.0

func on_noise_event(origin: Vector3, volume: float, _kind: String) -> void:
	var listener := get_parent() as Node3D
	var distance := origin.distance_to(listener.global_position)
	if distance > hearing_radius:
		return
	var loudness := volume * (1.0 - distance / hearing_radius)
	if loudness <= hearing_threshold:
		return
	var confidence := clampf(loudness * 0.9, 0.1, 0.9)
	var scatter := Vector3(randf_range(-position_scatter, position_scatter), 0.0, randf_range(-position_scatter, position_scatter))
	heard.emit(origin + scatter, confidence)