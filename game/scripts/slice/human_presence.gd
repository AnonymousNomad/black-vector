class_name HumanPresence
extends CharacterBody3D

signal speech_received(intent: String, text_key: String)

@export var presence_id := "presence_01"
@export var posture := "STAND"
@export var activity := "SHELTERING"
@export var threat_level := "UNKNOWN"

var world: WorldStateManager
var received_speech: Array = []

func _ready() -> void:
	add_to_group("human_presence")

func bind(w: WorldStateManager) -> void:
	world = w

func record_evidence() -> void:
	if world == null:
		return
	world.record_trace("FOOTPRINT", global_position + Vector3(0.6, 0.0, 0.4), 0.45, "presence", presence_id)
	world.record_trace("SOUND", global_position + Vector3(0.2, 0.0, 0.1), 0.35, "activity", presence_id)

func receive_speech(intent: String, text_key: String, context := {}) -> Dictionary:
	var entry := {
		"intent": intent,
		"text_key": text_key,
		"context": context.duplicate(true),
	}
	received_speech.append(entry)
	speech_received.emit(intent, text_key)
	return entry

func speech_count() -> int:
	return received_speech.size()

func behavior_placeholder() -> void:
	pass

func report() -> Dictionary:
	return {
		"id": presence_id,
		"posture": posture,
		"activity": activity,
		"threat": threat_level,
		"position": [global_position.x, global_position.y, global_position.z],
		"speech_count": received_speech.size(),
	}
