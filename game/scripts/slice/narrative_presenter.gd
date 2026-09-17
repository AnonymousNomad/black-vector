class_name NarrativePresenter
extends Node

const MAX_LINES := 16

var channels: NarrativeChannels

var last_observable := {}
var last_spoken := {}
var last_inner := {}
var last_intrusion := {}
var lines: Array = []

func bind(c: NarrativeChannels) -> void:
	channels = c
	if channels == null:
		return
	channels.observable.connect(_on_observable)
	channels.spoken.connect(_on_spoken)
	channels.inner_thought.connect(_on_inner)
	channels.intrusion.connect(_on_intrusion)

func _on_observable(id: String, text_key: String, context: Dictionary) -> void:
	last_observable = {"id": id, "text_key": text_key, "context": context}
	_push("REALITY", id, text_key)

func _on_spoken(intent: String, text_key: String, context: Dictionary) -> void:
	last_spoken = {"id": intent, "text_key": text_key, "context": context}
	_push("SPOKEN", intent, text_key)

func _on_inner(id: String, text_key: String, context: Dictionary) -> void:
	last_inner = {"id": id, "text_key": text_key, "context": context}
	_push("INNER", id, text_key)

func _on_intrusion(id: String, text_key: String, context: Dictionary) -> void:
	last_intrusion = {"id": id, "text_key": text_key, "context": context}
	_push("UNKNOWN", id, text_key)

func _push(channel_label: String, id: String, text_key: String) -> void:
	lines.append("%s:%s" % [channel_label, text_key])
	if lines.size() > MAX_LINES:
		lines.pop_front()

func line() -> String:
	var inner := ""
	if not last_inner.is_empty():
		inner = str(last_inner.get("text_key", ""))
	var spoken := ""
	if not last_spoken.is_empty():
		spoken = str(last_spoken.get("text_key", ""))
	var unknown := ""
	if not last_intrusion.is_empty():
		unknown = str(last_intrusion.get("text_key", ""))
	return "NARRATIVE: inner=%s spoken=%s unknown=%s" % [inner, spoken, unknown]
