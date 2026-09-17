class_name KeyboardAdapter
extends InputAdapter

const DEVICE_NAME := "keyboard"
const ACTION_NAME_TO_KEY := {
	"move_left": KEY_A,
	"move_right": KEY_D,
	"move_forward": KEY_W,
	"move_backward": KEY_S,
	"jump": KEY_SPACE,
	"crouch": KEY_C,
	"prone": KEY_Z,
	"sprint": KEY_SHIFT,
	"interact": KEY_E,
	"tactical_silent": KEY_1,
	"tactical_normal": KEY_2,
	"tactical_aggressive": KEY_3,
	"combat_attack": KEY_J,
	"combat_guard": KEY_K,
	"contact_speak": KEY_Q,
	"contact_cycle": KEY_T,
	"debug_toggle_overlay": KEY_F2,
	"debug_toggle_mouse": KEY_F1,
	"debug_reset_observer": KEY_R,
	"debug_reset_opponent": KEY_BACKSPACE,
	"debug_save": KEY_F5,
	"debug_load": KEY_F9,
}

var pressed_keys := {}

func is_action_active(action: String) -> bool:
	if not ACTION_NAME_TO_KEY.has(action):
		return false
	return Input.is_physical_key_pressed(ACTION_NAME_TO_KEY[action])

func axis_strength(action: String) -> float:
	return 1.0 if is_action_active(action) else 0.0