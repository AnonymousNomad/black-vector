class_name TouchInputAdapter
extends InputAdapter

const MOVE_DEADZONE := 0.18
const STICK_AXES := {
	"up": "move_forward",
	"down": "move_backward",
	"left": "move_left",
	"right": "move_right",
}

var profile: InputProfile

var _left_finger := -1
var _right_finger := -1
var _context_finger := -1
var _left_anchor := Vector2.ZERO
var _right_last := Vector2.ZERO
var _look_accum := Vector2.ZERO
var _move_vec := Vector2.ZERO
var _move_pressed := false
var _look_pressed := false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED if not enabled else Node.PROCESS_MODE_ALWAYS

func configure(p: InputProfile) -> void:
	profile = p

func consume(event: InputEvent) -> bool:
	if event is InputEventScreenTouch:
		return _on_touch(event)
	if event is InputEventScreenDrag:
		return _on_drag(event)
	return false

func _on_touch(event: InputEventScreenTouch) -> bool:
	var norm := event.position / viewport_size()
	if not event.pressed:
		if event.index == _context_finger:
			_context_finger = -1
			Input.action_release("interact")
			return true
		if event.index == _left_finger:
			_left_finger = -1
			_move_vec = Vector2.ZERO
			release_move()
			return true
		if event.index == _right_finger:
			_right_finger = -1
			return true
		return false
	var zones := profile.mirrored_zones()
	if profile.context_rect().has_point(norm):
		if _context_finger == -1:
			_context_finger = event.index
			Input.action_press("interact", 1.0)
			activate()
		return true
	if zones[0].has_point(norm):
		if _left_finger == -1:
			_left_finger = event.index
			_left_anchor = event.position
			_move_vec = Vector2.ZERO
			activate()
		return true
	if zones[1].has_point(norm):
		if _right_finger == -1:
			_right_finger = event.index
			_right_last = event.position
			activate()
		return true
	return false

func _on_drag(event: InputEventScreenDrag) -> bool:
	if event.index == _left_finger:
		_move_vec = ((event.position - _left_anchor) / profile.move_stick_radius).limit_length(1.0)
		return true
	if event.index == _right_finger:
		var delta := event.position - _right_last
		_right_last = event.position
		var y_sign := -1.0 if profile.invert_look_y else 1.0
		_look_accum += Vector2(delta.x, delta.y * y_sign) / profile.look_stick_radius
		return true
	return false

func tick(_delta: float) -> void:
	super.tick(_delta)
	var axes := vec_to_axes(_move_vec)
	var mag := axes.length()
	if mag > 0.0:
		axes = axes / mag * profile.movement_strength(mag)
	apply_move(axes)
	apply_look(_look_accum)
	_look_accum = Vector2.ZERO
	if _left_finger == -1 and _right_finger == -1 and _context_finger == -1:
		deactivate()

func apply_move(move: Vector2) -> void:
	if move.is_zero_approx():
		release_move()
		return
	release_move()
	var x := clampf(move.x, -1.0, 1.0)
	var y := clampf(move.y, -1.0, 1.0)
	if x > 0.0:
		Input.action_press("move_right", x)
	elif x < 0.0:
		Input.action_press("move_left", -x)
	if y > 0.0:
		Input.action_press("move_backward", y)
	elif y < 0.0:
		Input.action_press("move_forward", -y)
	_move_pressed = true

func release_move() -> void:
	if not _move_pressed:
		return
	Input.action_release("move_left")
	Input.action_release("move_right")
	Input.action_release("move_forward")
	Input.action_release("move_backward")
	_move_pressed = false

func apply_look(look: Vector2) -> void:
	if look.is_zero_approx():
		release_look()
		return
	release_look()
	var dx := clampf(look.x, -1.0, 1.0)
	var dy := clampf(look.y, -1.0, 1.0)
	if dx > 0.0:
		Input.action_press("look_right", dx)
	elif dx < 0.0:
		Input.action_press("look_left", -dx)
	if dy > 0.0:
		Input.action_press("look_down", dy)
	elif dy < 0.0:
		Input.action_press("look_up", -dy)
	_look_pressed = true

func release_look() -> void:
	if not _look_pressed:
		return
	Input.action_release("look_left")
	Input.action_release("look_right")
	Input.action_release("look_up")
	Input.action_release("look_down")
	_look_pressed = false

func vec_to_axes(raw: Vector2) -> Vector2:
	return Vector2(_axis_value(raw.x), _axis_value(raw.y))

func _axis_value(v: float) -> float:
	if absf(v) <= MOVE_DEADZONE:
		return 0.0
	return signf(v) * (absf(v) - MOVE_DEADZONE) / (1.0 - MOVE_DEADZONE)

func viewport_size() -> Vector2:
	var root := get_tree().root
	return Vector2(root.size)

func reset_all() -> void:
	release_move()
	release_look()
	if _context_finger != -1:
		Input.action_release("interact")
	_left_finger = -1
	_right_finger = -1
	_context_finger = -1
	_move_vec = Vector2.ZERO
	_look_accum = Vector2.ZERO