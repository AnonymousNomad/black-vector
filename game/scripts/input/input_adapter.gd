class_name InputAdapter
extends Node

signal activated
signal deactivated

@export var enabled := true

var active := false

func set_enabled(value: bool) -> void:
	enabled = value
	if not enabled and active:
		active = false
		deactivated.emit()

func activate() -> void:
	if not active:
		active = true
		activated.emit()

func deactivate() -> void:
	if active:
		active = false
		deactivated.emit()

func tick(_delta: float) -> void:
	pass