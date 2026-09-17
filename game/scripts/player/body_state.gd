class_name BodyState
extends Node

signal band_changed(band: String, value: float)
signal expression_changed(expression: int)
signal motion_changed(posture: String, movement_state: String)
signal condition_changed(state: String)

enum ExpressionMode { ISLAND, OPERATOR }

@export var island_accel_scale := 0.8
@export var operator_accel_scale := 1.0
@export var expression: ExpressionMode = ExpressionMode.ISLAND

var manager: PlayerStateManager
var posture := "STAND"
var movement_state := "IDLE"
var condition := "NORMAL"

func _ready() -> void:
	refresh()

func bind(mgr: PlayerStateManager) -> void:
	manager = mgr

func refresh() -> void:
	manager = get_tree().get_first_node_in_group("player_state") as PlayerStateManager

func present(move_name: String, stance_name: String) -> void:
	if movement_state == move_name and posture == stance_name:
		return
	movement_state = move_name
	posture = stance_name
	motion_changed.emit(posture, movement_state)

func locomotion_state() -> String:
	match posture:
		"CROUCH":
			return "CROUCH"
		"PRONE":
			return "PRONE"
	return movement_state

func set_expression(value: ExpressionMode) -> void:
	if value == expression:
		return
	expression = value
	expression_changed.emit(expression)

func expression_accel_scale() -> float:
	return island_accel_scale if expression == ExpressionMode.ISLAND else operator_accel_scale

func expression_name() -> String:
	return "ISLAND" if expression == ExpressionMode.ISLAND else "OPERATOR"

func set_condition(state: String) -> void:
	if state == condition:
		return
	condition = state
	condition_changed.emit(condition)

func condition_speed_scale() -> float:
	match condition:
		"TIRED":
			return 0.9
		"EXHAUSTED":
			return 0.72
		"INJURED":
			return 0.85
		"EXPOSED":
			return 0.9
		"RECOVERING":
			return 0.8
		_:
			return 1.0

func condition_accel_scale() -> float:
	match condition:
		"TIRED":
			return 0.9
		"EXHAUSTED":
			return 0.7
		"INJURED":
			return 0.85
		"EXPOSED":
			return 0.9
		"RECOVERING":
			return 0.85
		_:
			return 1.0

func band(name: String) -> float:
	if manager:
		return manager.band(name)
	return 1.0
