class_name ControllerAdapter
extends InputAdapter

const DEVICE_NAME := "controller"
const AXIS_DEADZONE := 0.2
const AXIS_LOOK_GAIN := 2.4

var connected: bool = false
var joypads: Array = []

func refresh_devices() -> void:
	joypads = Input.get_connected_joypads()
	connected = not joypads.is_empty()
	if connected and not active:
		activate()
	elif not connected and active:
		deactivate()

func axis_strength(axis: String) -> float:
	match axis:
		"move_left":
			return Input.get_joy_axis(0, JOY_AXIS_LEFT_X) if connected else 0.0
		_:
			return 0.0

func tick(_delta: float) -> void:
	super.tick(_delta)
	refresh_devices()