class_name AnimationState
extends Node

signal state_changed(state: String)
signal transitioned(from_state: String, to_state: String)

const IDLE := "idle"
const WALK := "walk"
const JOG := "jog"
const SPRINT := "sprint"
const AIR := "air"
const CROUCH := "crouch"
const CROUCH_WALK := "crouch_walk"
const PRONE := "prone"
const PRONE_CRAWL := "prone_crawl"

var current := IDLE
var condition := "NORMAL"
var _tree: AnimationTree

func attach_tree(tree: AnimationTree) -> void:
	_tree = tree

func present(move_state: String, stance: String, speed: float, new_condition: String = "NORMAL") -> void:
	condition = new_condition
	var next := derive(move_state, stance, speed)
	if next != current:
		var previous := current
		current = next
		state_changed.emit(current)
		transitioned.emit(previous, current)
		apply_animation()

func derive(move_state: String, stance: String, speed: float) -> String:
	if stance == "CROUCH":
		return CROUCH_WALK if speed > 0.5 else CROUCH
	if stance == "PRONE":
		return PRONE_CRAWL if speed > 0.5 else PRONE
	match move_state:
		"SPRINT":
			return SPRINT
		"JOG":
			return JOG
		"WALK":
			return WALK
		"AIR":
			return AIR
		_:
			return IDLE

func apply_animation() -> void:
	if _tree and _tree.has_method("present"):
		_tree.call("present", current, condition)