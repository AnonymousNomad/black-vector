class_name AbstractActionMap
extends Resource

const VERSION := 1

const BUTTON_ACTIONS := [
	"jump", "crouch", "prone", "sprint", "interact",
	"tactical_silent", "tactical_normal", "tactical_aggressive",
	"combat_attack", "combat_guard",
	"contact_speak", "contact_cycle",
	"debug_toggle_overlay", "debug_toggle_mouse",
	"debug_reset_observer", "debug_reset_opponent",
	"debug_save", "debug_load",
]

const AXIS_MOVE_ACTIONS := ["move_left", "move_right", "move_forward", "move_backward"]
const AXIS_LOOK_ACTIONS := ["look_left", "look_right", "look_up", "look_down"]

func move_axes() -> Array[String]:
	return AXIS_MOVE_ACTIONS.duplicate()

func look_axes() -> Array[String]:
	return AXIS_LOOK_ACTIONS.duplicate()

func button_actions() -> Array[String]:
	return BUTTON_ACTIONS.duplicate()

func all_actions() -> Array[String]:
	var out := AXIS_MOVE_ACTIONS.duplicate()
	out.append_array(AXIS_LOOK_ACTIONS)
	out.append_array(BUTTON_ACTIONS)
	return out