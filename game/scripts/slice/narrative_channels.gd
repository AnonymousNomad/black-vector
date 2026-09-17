class_name NarrativeChannels
extends Node

enum Channel { OBSERVABLE_REALITY, SPOKEN_CORLEY, INNER_CORLEY, INTRUSION_OR_UNKNOWN }

const CHANNEL_NAMES := ["OBSERVABLE_REALITY", "SPOKEN_CORLEY", "INNER_CORLEY", "INTRUSION_OR_UNKNOWN"]

const INTENTS := ["ACKNOWLEDGE", "WAIT", "BACK_OFF", "QUESTION", "WARN"]

const TEXT := {
	"corley_acknowledge": "Easy.",
	"corley_wait": "Hold there.",
	"corley_back_off": "Give me room.",
	"corley_question": "Who's there?",
	"corley_warn": "Don't.",
	"inner_keep_distance": "Keep your distance.",
	"unknown_placeholder": "...",
}

const INTENT_TEXT := {
	"ACKNOWLEDGE": "corley_acknowledge",
	"WAIT": "corley_wait",
	"BACK_OFF": "corley_back_off",
	"QUESTION": "corley_question",
	"WARN": "corley_warn",
}

const MAX_LOG := 32

signal observable(id: String, text_key: String, context: Dictionary)
signal spoken(intent: String, text_key: String, context: Dictionary)
signal inner_thought(id: String, text_key: String, context: Dictionary)
signal intrusion(id: String, text_key: String, context: Dictionary)

var world: WorldStateManager
var log: Array = []

func setup(w: WorldStateManager) -> void:
	world = w

func text_for(text_key: String) -> String:
	return str(TEXT.get(text_key, text_key))

func note_observable(id: String, text_key: String, context := {}) -> void:
	_append(Channel.OBSERVABLE_REALITY, id, text_key)
	observable.emit(id, text_key, context)

func speak(intent: String, context := {}) -> String:
	var text_key := str(INTENT_TEXT.get(intent, intent))
	_append(Channel.SPOKEN_CORLEY, intent, text_key)
	spoken.emit(intent, text_key, context)
	return text_key

func emit_inner_thought(id: String, text_key: String, context := {}, once := false) -> bool:
	if once and world and world.has_seen(id):
		return false
	_append(Channel.INNER_CORLEY, id, text_key)
	if world:
		world.mark_seen(id)
	inner_thought.emit(id, text_key, context)
	return true

func emit_intrusion(id: String, text_key: String, context := {}) -> void:
	_append(Channel.INTRUSION_OR_UNKNOWN, id, text_key)
	intrusion.emit(id, text_key, context)

func has_seen(id: String) -> bool:
	return world != null and world.has_seen(id)

func _append(channel: int, id: String, text_key: String) -> void:
	log.append({
		"channel": CHANNEL_NAMES[channel],
		"id": id,
		"text_key": text_key,
	})
	if log.size() > MAX_LOG:
		log.pop_front()

func recent(channel_name: String, count := 1) -> Array:
	var out: Array = []
	for i in range(log.size() - 1, -1, -1):
		if str(log[i].get("channel", "")) == channel_name:
			out.append(log[i])
			if out.size() >= count:
				break
	return out
