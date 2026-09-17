class_name TrainingOpponent
extends CharacterBody3D

enum Intent { IDLE, TELEGRAPH, GUARD, ASSESS, CLOSE, RETREAT, DOWN, RETURNING }

@export var gravity := 22.0
@export var walk_speed := 2.8
@export var retreat_speed := 2.4
@export var turn_speed := 8.0
@export var posture := 1.0
@export var stamina := 1.0
@export var posture_hit_loss := 0.3
@export var posture_regen := 0.25
@export var stamina_regen := 0.12
@export var assess_min := 0.4
@export var assess_max := 0.9
@export var guard_hold := 0.8
@export var retreat_gap := 4.2
@export var engage_trigger := 5.5
@export var debug_log_enabled := false

var intent := Intent.IDLE
var home := Vector3.ZERO
var combat: Node = null
var player: Node = null

var _assess_timer := 0.0
var _hold_timer := 0.0
var _down := false
var _noise_hint := 0.0
var _noise_kind := ""
var _noise_timer := 0.0
var _noise_connected := false

func _ready() -> void:
	add_to_group("training_opponent")
	home = global_position
	reset_opponent()
	log_change("opponent", "ready")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_reset_opponent"):
		reset_opponent()
		return
	_resolve_refs()
	var surface := _ai_read()
	var to_player := (player as Node3D).global_position - global_position
	to_player.y = 0.0
	var dist := to_player.length()
	_decide(delta, surface, dist)
	_act(delta, dist)

func _resolve_refs() -> void:
	if player == null or not is_instance_valid(player):
		player = get_tree().get_first_node_in_group("player")
	if combat == null or not is_instance_valid(combat):
		var p := player
		if p:
			combat = p.get_node_or_null("CombatController")
	if not _noise_connected and is_instance_valid(player):
		var sig := (player as Node).get_node_or_null("SignatureController")
		if sig and sig.has_signal("noise_event"):
			sig.noise_event.connect(_on_noise_event)
			_noise_connected = true

func _on_noise_event(_origin: Vector3, volume: float, kind: String) -> void:
	_noise_hint = volume
	_noise_kind = kind
	_noise_timer = 0.8
	log_change("noise", kind + " (" + ("%.2f" % volume) + ")")

func _ai_read() -> Dictionary:
	if combat and is_instance_valid(combat):
		return combat.call("ai_surface")
	return {}

func _decide(delta: float, surface: Dictionary, dist: float) -> void:
	var contact: int = surface.get("contact", CombatController.ContactState.READ)
	_noise_timer = maxf(0.0, _noise_timer - delta)
	if _noise_timer <= 0.0:
		_noise_hint = 0.0
	regen_resources(delta)
	if contact == CombatController.ContactState.READ and dist > engage_trigger:
		intent = Intent.IDLE
		return
	if contact == CombatController.ContactState.RESET:
		intent = Intent.RETURNING
		return
	if contact == CombatController.ContactState.RESOLUTION:
		intent = Intent.DOWN
		_down = true
		return
	if contact == CombatController.ContactState.CONTROL and surface.get("initiative", 0) == 1:
		intent = Intent.DOWN
		_down = true
		return
	if _down and (contact != CombatController.ContactState.CONTROL and contact != CombatController.ContactState.RESOLUTION):
		_down = false
		intent = Intent.RETURNING
		return
	if contact == CombatController.ContactState.CONTROL and surface.get("initiative", 0) == 2:
		intent = Intent.ASSESS
		return
	match intent:
		Intent.RETURNING:
			if Vector2(home.x - global_position.x, home.z - global_position.z).length() <= 0.5:
				intent = Intent.IDLE
				posture = 1.0
				stamina = 1.0
			return
		Intent.DOWN:
			return
		Intent.RETREAT:
			if dist >= retreat_gap:
				intent = Intent.IDLE
			return
		Intent.TELEGRAPH:
			return
		Intent.GUARD:
			if surface.get("stance", 0) == CombatController.BattleStance.OFFENSIVE:
				_hold_timer = 0.0
			else:
				_hold_timer += delta
				if _hold_timer >= guard_hold:
					_hold_timer = 0.0
					intent = Intent.TELEGRAPH
			return
		Intent.ASSESS:
			_assess_timer -= delta
			if _assess_timer <= 0.0:
				choose_action(surface, dist)
			return
		Intent.CLOSE:
			if dist <= rg("striking"):
				intent = Intent.ASSESS
				_assess_timer = randf_range(assess_min, assess_max)
			return
		_:
			pass
	if contact in [CombatController.ContactState.ENGAGE, CombatController.ContactState.EXCHANGE]:
		if dist <= rg("disengage"):
			intent = Intent.ASSESS
			_assess_timer = randf_range(assess_min, assess_max)
		return
	if contact == CombatController.ContactState.READ:
		if dist <= engage_trigger and (surface.get("stance", 0) != 0 or dist <= 3.2):
			intent = Intent.CLOSE

func rg(gate: String) -> float:
	if combat and is_instance_valid(combat):
		return combat.call("range_gate", gate)
	return 3.0

func choose_action(surface: Dictionary, dist: float) -> void:
	if _noise_hint > 0.55:
		intent = Intent.GUARD
		_hold_timer = 0.0
		return
	if surface.get("stance", 0) == CombatController.BattleStance.OFFENSIVE:
		intent = Intent.GUARD
		_hold_timer = 0.0
		return
	if surface.get("commitment", 1.0) >= 1.2 and dist < rg("striking") + 1.0:
		intent = Intent.RETREAT
		return
	if surface.get("posture", 1.0) <= 0.35 and dist <= rg("close"):
		if surface.get("initiative", 0) == CombatController.Initiative.OPPONENT:
			intent = Intent.TELEGRAPH
			return
	if randf() < 0.6:
		intent = Intent.TELEGRAPH
	else:
		intent = Intent.GUARD
		_hold_timer = 0.0

func _act(delta: float, dist: float) -> void:
	var desired := Vector3.ZERO
	match intent:
		Intent.CLOSE:
			desired = toward_player() * walk_speed
		Intent.RETREAT:
			desired = toward_player() * -retreat_speed
		Intent.RETURNING:
			var to_home := home - global_position
			if to_home.length() > 0.3:
				desired = to_home.normalized() * walk_speed
		Intent.IDLE:
			desired = toward_player() * 0.0
		_:
			desired = Vector3.ZERO
	velocity.x = desired.x
	velocity.z = desired.z
	velocity.y -= gravity * delta
	face_move_or_player(delta, desired, dist)
	move_and_slide()

func face_move_or_player(delta: float, desired: Vector3, dist: float) -> void:
	var dir := desired
	if dir.length_squared() < 0.01:
		dir = toward_player()
	if intent == Intent.DOWN:
		dir = toward_player()
	if dir.length_squared() < 0.01:
		return
	var target_yaw := atan2(-dir.normalized().x, -dir.normalized().z)
	rotation.y = lerp_angle(rotation.y, target_yaw, clampf(turn_speed * delta, 0.0, 1.0))

func toward_player() -> Vector3:
	var v := (player as Node3D).global_position - global_position
	v.y = 0.0
	if v.length_squared() < 0.01:
		return Vector3.ZERO
	return v.normalized()

func regen_resources(delta: float) -> void:
	if intent == Intent.DOWN:
		return
	posture = minf(1.0, posture + posture_regen * delta)
	stamina = minf(1.0, stamina + stamina_regen * delta)

func resolve_player_attack(commitment: float, guarded: bool) -> Dictionary:
	if guarded:
		posture = maxf(0.0, posture - 0.03)
		stamina = maxf(0.0, stamina - 0.02)
		intent = Intent.ASSESS
		_assess_timer = randf_range(assess_min, assess_max)
		return {"guarded": true}
	posture = maxf(0.0, posture - posture_hit_loss * clampf(commitment, 1.0, 1.5))
	stamina = maxf(0.0, stamina - 0.05)
	intent = Intent.ASSESS
	_assess_timer = randf_range(assess_min, assess_max)
	return {"guarded": false}

func finish_telegraph() -> void:
	if intent == Intent.TELEGRAPH:
		intent = Intent.ASSESS
		_assess_timer = randf_range(assess_min, assess_max)

func apply_pin_start(pinned_by_player: bool) -> void:
	if pinned_by_player:
		intent = Intent.DOWN
		_down = true
		posture = 0.0
	else:
		intent = Intent.ASSESS
		_assess_timer = randf_range(assess_min, assess_max)

func on_player_break() -> void:
	intent = Intent.RETURNING

func intent_value() -> int:
	return intent

func posture_value() -> float:
	return posture

func stamina_value() -> float:
	return stamina

func reset_opponent() -> void:
	global_position = home
	intent = Intent.IDLE
	posture = 1.0
	stamina = 1.0
	_assess_timer = 0.0
	_hold_timer = 0.0
	_down = false
	log_change("opponent", "reset")

func intent_name() -> String:
	match intent:
		Intent.TELEGRAPH:
			return "TELEGRAPH"
		Intent.GUARD:
			return "GUARD"
		Intent.ASSESS:
			return "ASSESS"
		Intent.CLOSE:
			return "CLOSE"
		Intent.RETREAT:
			return "RETREAT"
		Intent.DOWN:
			return "DOWN"
		Intent.RETURNING:
			return "RETURNING"
		_:
			return "IDLE"

func debug_line() -> String:
	var hint := " NOISE[" + _noise_kind + "]" if _noise_hint > 0.0 else ""
	return "OPP: %s%s | POST %.2f | STM %.2f" % [intent_name(), hint, posture, stamina]

func log_change(system: String, value: Variant) -> void:
	if debug_log_enabled:
		print("BV.DEBUG." + system + " -> " + str(value))