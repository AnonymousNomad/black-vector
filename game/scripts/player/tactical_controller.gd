class_name TacticalController
extends Node

enum Profile { NORMAL, SILENT, AGGRESSIVE }

@export var silent_speed_multiplier := 0.72
@export var aggressive_speed_multiplier := 1.12
@export var silent_noise_multiplier := 0.3
@export var aggressive_noise_multiplier := 1.65
@export var silent_accel_multiplier := 1.15
@export var aggressive_accel_multiplier := 1.25
@export var debug_log_enabled := false

var current: int = Profile.NORMAL

func process_input() -> void:
	if Input.is_action_just_pressed("tactical_silent"):
		set_profile(Profile.SILENT)
	elif Input.is_action_just_pressed("tactical_aggressive"):
		set_profile(Profile.AGGRESSIVE)
	elif Input.is_action_just_pressed("tactical_normal"):
		set_profile(Profile.NORMAL)

func set_profile(profile: int) -> void:
	if profile == current:
		return
	current = profile
	log_change("tactical", current)

func speed_multiplier() -> float:
	match current:
		Profile.SILENT:
			return silent_speed_multiplier
		Profile.AGGRESSIVE:
			return aggressive_speed_multiplier
		_:
			return 1.0

func sprint_allowed() -> bool:
	return current != Profile.SILENT

func noise_multiplier() -> float:
	match current:
		Profile.SILENT:
			return silent_noise_multiplier
		Profile.AGGRESSIVE:
			return aggressive_noise_multiplier
		_:
			return 1.0

func accel_multiplier() -> float:
	match current:
		Profile.SILENT:
			return silent_accel_multiplier
		Profile.AGGRESSIVE:
			return aggressive_accel_multiplier
		_:
			return 1.0

func state_name() -> String:
	match current:
		Profile.SILENT:
			return "SILENT"
		Profile.AGGRESSIVE:
			return "AGGRESSIVE"
		_:
			return "NORMAL"

func log_change(system: String, value: Variant) -> void:
	if debug_log_enabled:
		print("BV.DEBUG." + system + " -> " + str(value))