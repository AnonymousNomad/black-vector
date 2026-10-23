class_name AnimationState
extends Node

signal state_changed(state: String)
signal transitioned(from_state: String, to_state: String)
signal action_changed(action: String)

const IDLE := "idle"
const WALK := "walk"
const JOG := "jog"
const SPRINT := "sprint"
const AIR := "air"
const CROUCH := "crouch"
const CROUCH_WALK := "crouch_walk"
const PRONE := "prone"
const PRONE_CRAWL := "prone_crawl"
const ACTION_NONE := "NONE"

var current := IDLE
var condition := "NORMAL"
var action_state := ACTION_NONE
var action_priority := 0
var _action_remaining := 0.0
var _tree: AnimationTree

func _process(delta: float) -> void:
	if _action_remaining <= 0.0:
		return
	_action_remaining = maxf(0.0, _action_remaining - delta)
	if _action_remaining <= 0.0:
		clear_action_if(action_state)

func attach_tree(tree: AnimationTree) -> void:
	_tree = tree

func request_action(action: String, duration: float, priority: int) -> bool:
	if action == ACTION_NONE:
		return false
	if priority < action_priority:
		return false
	if action_state != action:
		action_state = action
		action_changed.emit(action_state)
	action_priority = priority
	_action_remaining = maxf(0.0, duration)
	return true

func clear_action_if(expected_action: String) -> bool:
	if action_state != expected_action:
		return false
	if action_state != ACTION_NONE:
		action_state = ACTION_NONE
		action_changed.emit(action_state)
	action_priority = 0
	_action_remaining = 0.0
	return true

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
