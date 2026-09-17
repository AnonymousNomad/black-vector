extends CharacterBody3D

@export var gravity := 22.0
@export var jump_velocity := 7.5

@onready var movement_controller := $MovementController as MovementController
@onready var stance_controller := $StanceController as StanceController
@onready var traversal_controller := $TraversalController as TraversalController
@onready var tactical_controller := $TacticalController as TacticalController
@onready var signature_controller := $SignatureController as SignatureController
@onready var camera_rig := $CameraRig as CameraRig
@onready var interaction_probe := $InteractionProbe as InteractionProbe
@onready var combat_controller := $CombatController as CombatController
@onready var body_state := $BodyState as BodyState
@onready var animation_state := $AnimationState as AnimationState

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	stance_controller.process_input()
	tactical_controller.process_input()
	camera_rig.set_rig_transform(global_position, stance_controller.current_camera_height())
	var input_vector := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := camera_relative_direction(input_vector)
	if traversal_controller.is_active():
		traversal_controller.process_active(delta, gravity)
		move_and_slide()
		_update_anim()
		update_signature(delta)
		return
	interaction_probe.update_probe(self)
	var combat_lunge := combat_controller.process(delta, self)
	if traversal_controller.attempt_start(direction, stance_controller.is_prone(), is_on_floor(), interaction_probe.target):
		move_and_slide()
		_update_anim()
		update_signature(delta)
		return
	if Input.is_action_just_pressed("interact"):
		interaction_probe.activate(stance_controller.is_stowed())
	var sprint := Input.is_action_pressed("sprint") and tactical_controller.sprint_allowed()
	var throttle := clampf(input_vector.length(), 0.0, 1.0)
	var max_speed := stance_controller.current_speed(sprint) * tactical_controller.speed_multiplier() * throttle * body_state.condition_speed_scale()
	movement_controller.apply_movement(direction, delta, max_speed, jump_velocity, gravity, is_on_floor(), tactical_controller.accel_multiplier() * body_state.expression_accel_scale() * body_state.condition_accel_scale())
	if combat_lunge != Vector3.ZERO:
		velocity.x += combat_lunge.x
		velocity.z += combat_lunge.z
	move_and_slide()
	_update_anim()
	update_signature(delta)

func _update_anim() -> void:
	animation_state.present(movement_controller.state_name(), stance_controller.state_name(), velocity.length(), body_state.condition)
	body_state.present(movement_controller.state_name(), stance_controller.state_name())

func update_signature(delta: float) -> void:
	signature_controller.update(self, stance_controller.current, movement_controller.move_state, tactical_controller.noise_multiplier(), traversal_controller.state, delta)

func camera_relative_direction(input_vector: Vector2) -> Vector3:
	var basis := camera_rig.global_transform.basis
	var forward := -basis.z
	forward.y = 0.0
	forward = forward.normalized()
	var right := basis.x
	right.y = 0.0
	right = right.normalized()
	return (forward * -input_vector.y + right * input_vector.x).normalized()

func debug_snapshot() -> String:
	var lines := [
		"MOVEMENT: " + movement_controller.state_name(),
		"STANCE: " + stance_controller.state_name(),
		"TACTICAL: " + tactical_controller.state_name(),
		"SPEED: %.2f m/s" % velocity.length(),
		"GROUNDED: " + str(is_on_floor()),
		"TRAVERSAL: " + traversal_controller.state_name(),
		"VISIBILITY: %.2f" % signature_controller.visibility_value(),
		"NOISE: %.2f" % signature_controller.noise_value(),
		"TRACE: %.2f" % signature_controller.trace_intensity(),
		"CONTEXT: " + interaction_probe.context_action(stance_controller.is_stowed()),
		"COMBAT: " + combat_controller.debug_line(),
		"ANIM: " + animation_state.current,
		"LOCOMOTION: " + body_state.locomotion_state(),
		"EXPRESSION: " + body_state.expression_name(),
		"BODY: " + body_state.condition,
		"CAM_PITCH: %.2f" % camera_rig.pitch_pivot.rotation.x,
	]
	return "\n".join(lines)