extends Node

const ADAPTER_GLOBAL := "input_adapter"

var profile := InputProfile.new()

var touch: TouchInputAdapter
var keyboard: KeyboardAdapter
var controller: ControllerAdapter

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	touch = TouchInputAdapter.new()
	touch.name = "TouchInputAdapter"
	touch.configure(profile)
	add_child(touch)
	keyboard = KeyboardAdapter.new()
	keyboard.name = "KeyboardAdapter"
	add_child(keyboard)
	controller = ControllerAdapter.new()
	controller.name = "ControllerAdapter"
	add_child(controller)
	controller.refresh_devices()
	reset_all()

func _process(delta: float) -> void:
	if touch and touch.enabled:
		touch.tick(delta)
	if controller and controller.enabled:
		controller.tick(delta)

func _unhandled_input(event: InputEvent) -> void:
	if touch.consume(event):
		get_viewport().set_input_as_handled()

func configure(new_profile: InputProfile) -> void:
	profile = new_profile
	if touch:
		touch.configure(new_profile)
	apply_config(profile)

func apply_config(p: InputProfile) -> void:
	if p.controller_preferred:
		if controller and controller.connected:
			touch.enabled = false
			controller.enabled = true
		else:
			touch.enabled = true
			controller.enabled = true
	else:
		touch.enabled = true
		controller.enabled = true

func is_action_pressed(action: String) -> bool:
	return Input.is_action_pressed(action)

func is_action_just_pressed(action: String) -> bool:
	return Input.is_action_just_pressed(action)

func action_strength(action: String) -> float:
	return Input.get_action_strength(action)

func vector(neg_x: String, pos_x: String, neg_y: String, pos_y: String) -> Vector2:
	return Input.get_vector(neg_x, pos_x, neg_y, pos_y)

func reset_all() -> void:
	if touch:
		touch.reset_all()