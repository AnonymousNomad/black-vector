class_name CombatController
extends Node

signal contact_changed(from: int, to: int, reason: String)

enum ContactState { READ, ENGAGE, EXCHANGE, ADVANTAGE, CONTROL, RESOLUTION, RESET }
enum RangeState { DISENGAGE_RANGE, STRIKING_RANGE, CLOSE_RANGE, CLINCH_RANGE, GROUND, ENVIRONMENTAL }
enum BattleStance { NEUTRAL, OFFENSIVE, DEFENSIVE }
enum Initiative { NONE, PLAYER, OPPONENT }

const RAGE_ENTER := 0.22
const RAGE_EXIT := 0.35
const RAGE_DEBOUNCE := 1.0
const RAGE_COMMITMENT := 1.4
const RAGE_STAMINA_COST := 1.5
const RAGE_POSTURE_REGEN := 0.5
const RAGE_STAMINA_REGEN := 0.4
const HIT_HOST_DROP := 0.1
const POSTURE_BROKEN_DROP := 0.06
const FAILED_TIMING_DROP := 0.09
const PRESSURE_DRAIN := 0.015
const CORNERED_DRAIN := 0.03

@export var disengage_range := 3.5
@export var striking_range := 1.6
@export var close_range := 0.85
@export var engage_radius := 4.0

@export var telegraph_time := 0.55
@export var initiative_expire := 0.9
@export var pin_time := 1.2
@export var break_resist := 1.4
@export var resolution_hold := 1.0
@export var reset_hold := 0.8

@export var posture := 1.0
@export var posture_hit_loss := 0.26
@export var posture_deflect_cost := 0.06
@export var posture_guard_regen := 0.4
@export var stamina := 1.0
@export var stamina_attack_cost := 0.08
@export var stamina_guard_cost := 0.04
@export var stamina_strain := 0.03
@export var stamina_regen := 0.13
@export var control := 0.62
@export var control_regain := 0.05
@export var debug_log_enabled := false

var contact := ContactState.READ
var range_state := RangeState.DISENGAGE_RANGE
var stance := BattleStance.NEUTRAL
var initiative := Initiative.NONE
var rage := false
var exhausted := false
var commitment_mult := 1.0
var last_transition_reason := ""
var exchange_resolution := ""
var resolution_outcome := ""
var rage_trigger := ""

var opponent: Node = null
var _player: CharacterBody3D = null
var _state_timer := 0.0
var _telegraph_timer := 0.0
var _telegraph_prev_intent := -1
var _telegraph_start_dist := INF
var _guard_before_telegraph := false
var _attack_queued := false
var _recent_event_timer := 0.0
var _clean_seconds := 0.0
var _prev_posture := 1.0
var _pending_lunge := Vector3.ZERO

func process(delta: float, player_body: CharacterBody3D) -> Vector3:
	var lunge_out := _pending_lunge
	_pending_lunge = Vector3.ZERO
	_player = player_body
	if opponent == null or not is_instance_valid(opponent):
		opponent = get_tree().get_first_node_in_group("training_opponent")
		if opponent == null:
			if contact != ContactState.READ:
				set_contact(ContactState.READ, "no_opponent")
			range_state = RangeState.DISENGAGE_RANGE
			return lunge_out
	var dist := horizontal_distance()
	classify_range(dist)
	compute_stance()
	update_resources(delta)
	match contact:
		ContactState.READ:
			process_read(dist)
		ContactState.ENGAGE:
			process_engage(dist)
		ContactState.EXCHANGE:
			process_exchange(delta, dist)
		ContactState.ADVANTAGE:
			process_advantage(delta)
		ContactState.CONTROL:
			process_control(delta)
		ContactState.RESOLUTION:
			_state_timer += delta
			if _state_timer >= resolution_hold:
				set_contact(ContactState.RESET, "resolution_done")
		ContactState.RESET:
			process_reset(delta)
	update_control(delta)
	return lunge_out

func process_read(dist: float) -> void:
	if dist <= engage_radius and (stance != BattleStance.NEUTRAL or opponent_intent() != 0):
		set_contact(ContactState.ENGAGE, "approach_acknowledged")

func process_engage(dist: float) -> void:
	if dist > engage_radius * 1.3 and stance == BattleStance.NEUTRAL and opponent_intent() == 0:
		set_contact(ContactState.READ, "left_range")
		return
	if stance != BattleStance.NEUTRAL or opponent_intent() != 0:
		set_contact(ContactState.EXCHANGE, "first_commit")

func process_exchange(delta: float, dist: float) -> void:
	if dist > disengage_range and stance == BattleStance.NEUTRAL:
		set_exchange_resolution("DISENGAGE")
		set_contact(ContactState.READ, "spacing_restored")
		return
	if stance == BattleStance.OFFENSIVE:
		if not _attack_queued:
			_attack_queued = true
			spend_stamina(stamina_attack_cost * stamina_cost_mult())
			lunge()
			if exhausted:
				_attack_queued = false
				set_exchange_resolution("FAILED_COMMIT")
		else:
			_attack_queued = false
			var guarded := opponent_intent() == 2
			var result: Dictionary = opponent.call("resolve_player_attack", commitment_mult, guarded)
			apply_player_attack_result(result)
			return
	track_telegraph(delta)
	if opponent_intent() == 1:
		if _telegraph_timer >= telegraph_time:
			resolve_opponent_strike()
			return
	elif opponent_intent() == 0:
		_telegraph_timer = 0.0
		_guard_before_telegraph = false

func track_telegraph(delta: float) -> void:
	var opp_intent := opponent_intent()
	if opp_intent == 1:
		if opp_intent != _telegraph_prev_intent:
			_telegraph_prev_intent = opp_intent
			_telegraph_timer = 0.0
			_telegraph_start_dist = horizontal_distance()
			_guard_before_telegraph = false
		else:
			_telegraph_timer += delta
			if stance == BattleStance.DEFENSIVE and _telegraph_timer <= 0.12:
				_guard_before_telegraph = true
	else:
		_telegraph_prev_intent = opp_intent

func resolve_opponent_strike() -> void:
	opponent.call("finish_telegraph")
	var dist := horizontal_distance()
	if dist >= _telegraph_start_dist + 0.35:
		set_exchange_resolution("EVADE")
		return
	var guarded := stance == BattleStance.DEFENSIVE
	var deflect_ok := guarded and (not rage or _guard_before_telegraph)
	if deflect_ok:
		posture = maxf(0.0, posture - posture_deflect_cost)
		spend_stamina(stamina_guard_cost)
		set_exchange_resolution("DEFLECT")
		set_advantage(Initiative.PLAYER, "player_deflect")
		return
	posture = maxf(0.0, posture - posture_hit_loss)
	if guarded and rage:
		host_event("failed_defensive_timing", FAILED_TIMING_DROP)
		set_exchange_resolution("TIMING_FAILED")
	else:
		host_event("hit_taken", HIT_HOST_DROP)
		set_exchange_resolution("HIT")
	set_advantage(Initiative.OPPONENT, "hit_landed")

func apply_player_attack_result(result: Dictionary) -> void:
	if result.get("guarded", false):
		posture = maxf(0.0, posture - posture_deflect_cost * 0.5)
		set_exchange_resolution("DEFLECTED")
		set_advantage(Initiative.OPPONENT, "opponent_deflect")
	else:
		set_exchange_resolution("HIT_LANDED")
		set_advantage(Initiative.PLAYER, "hit_landed")

func process_advantage(delta: float) -> void:
	_state_timer += delta
	match initiative:
		Initiative.PLAYER:
			if stance == BattleStance.OFFENSIVE and not exhausted:
				var guarded := opponent_intent() == 2
				var opp_posture: float = opponent.call("posture_value")
				if guarded and opp_posture > 0.5:
					set_contact(ContactState.EXCHANGE, "pin_batted_away")
					return
				opponent.call("apply_pin_start", true)
				set_contact(ContactState.CONTROL, "player_pin")
			elif _state_timer >= initiative_expire:
				set_contact(ContactState.EXCHANGE, "initiative_expired")
		Initiative.OPPONENT:
			if stance == BattleStance.DEFENSIVE and not exhausted and posture > 0.25:
				set_contact(ContactState.EXCHANGE, "guard_recovery")
			elif posture <= 0.35 and stance != BattleStance.DEFENSIVE:
				opponent.call("apply_pin_start", false)
				set_contact(ContactState.CONTROL, "opponent_pin")
			elif _state_timer >= 1.2:
				set_contact(ContactState.EXCHANGE, "initiative_lost")
			else:
				host_pressure(delta)

func process_control(delta: float) -> void:
	_state_timer += delta
	match initiative:
		Initiative.PLAYER:
			var opp_stamina: float = opponent.call("stamina_value")
			if opp_stamina <= 0.02:
				begin_resolution("OPPONENT_PIN", "opponent_exhausted")
			elif _state_timer >= pin_time:
				begin_resolution("OPPONENT_PIN", "pin_complete")
		Initiative.OPPONENT:
			if stance == BattleStance.DEFENSIVE and stamina > 0.02 and not exhausted:
				stamina = maxf(0.0, stamina - stamina_strain * delta)
				if _state_timer >= break_resist:
					opponent.call("on_player_break")
					set_exchange_resolution("BREAK")
					set_contact(ContactState.READ, "player_break")
				host_pressure(delta)
			else:
				if _state_timer >= 0.6:
					begin_resolution("PLAYER_PIN", "pin_held")

func host_pressure(delta: float) -> void:
	if control <= 0.0:
		return
	control = maxf(0.0, control - PRESSURE_DRAIN * delta)

func begin_resolution(outcome: String, reason: String) -> void:
	resolution_outcome = outcome
	_state_timer = 0.0
	set_contact(ContactState.RESOLUTION, reason)

func process_reset(delta: float) -> void:
	_state_timer += delta
	posture = minf(1.0, posture + 0.6 * delta)
	stamina = minf(1.0, stamina + 0.35 * delta)
	if _state_timer >= reset_hold:
		initiative = Initiative.NONE
		resolution_outcome = ""
		exchange_resolution = ""
		set_contact(ContactState.READ, "ready")

func update_resources(delta: float) -> void:
	spend_stamina(stamina_guard_cost * delta)
	if exhausted:
		if stamina >= 0.2:
			exhausted = false
	else:
		stamina = minf(1.0, stamina + stamina_regen * stamina_regen_mult() * delta)
	if contact == ContactState.CONTROL and initiative == Initiative.OPPONENT:
		return
	if not exhausted:
		var rate := 0.0
		if stance == BattleStance.DEFENSIVE:
			rate = posture_guard_regen
		elif contact != ContactState.EXCHANGE:
			rate = posture_guard_regen * 0.4
		posture = minf(1.0, posture + rate * posture_regen_mult() * delta)
	if posture <= 0.25 and _prev_posture > 0.25:
		host_event("posture_broken", POSTURE_BROKEN_DROP)
	_prev_posture = posture

func update_control(delta: float) -> void:
	if _recent_event_timer > 0.0:
		_recent_event_timer -= delta
	var pressure := contact == ContactState.EXCHANGE and initiative == Initiative.OPPONENT
	var cornered := range_state == RangeState.CLINCH_RANGE and pressure and posture <= 0.5
	if pressure:
		control = maxf(0.0, control - PRESSURE_DRAIN * delta)
	if cornered:
		control = maxf(0.0, control - CORNERED_DRAIN * delta)
	if rage:
		_clean_seconds = 0.0 if _recent_event_timer > 0.0 else _clean_seconds + delta
		if control >= RAGE_EXIT and _clean_seconds >= RAGE_DEBOUNCE:
			exit_rage()
	else:
		control = minf(1.0, control + control_regain * delta)

func host_event(kind: String, drop: float) -> void:
	_recent_event_timer = 0.5
	control = maxf(0.0, control - drop)
	log_change("host_event", kind)
	if not rage and control <= RAGE_ENTER:
		enter_rage(kind)

func enter_rage(kind: String) -> void:
	rage = true
	rage_trigger = kind
	commitment_mult = RAGE_COMMITMENT
	log_change("rage", kind)

func exit_rage() -> void:
	rage = false
	rage_trigger = ""
	commitment_mult = 1.0
	_clean_seconds = 0.0
	log_change("rage", "calm")

func spend_stamina(amount: float) -> void:
	stamina = clampf(stamina - amount, 0.0, 1.0)
	if stamina <= 0.05 and not exhausted:
		exhausted = true

func lunge() -> void:
	if _player == null or not _player.is_on_floor():
		return
	var to_opp := (opponent as Node3D).global_position - _player.global_position
	to_opp.y = 0.0
	if to_opp.length_squared() < 0.01:
		return
	var dir := to_opp.normalized()
	var force := 3.5 * commitment_mult
	_pending_lunge = Vector3(dir.x * force, 0.0, dir.z * force)

func compute_stance() -> void:
	var attack := Input.is_action_pressed("combat_attack")
	var guard := Input.is_action_pressed("combat_guard")
	if guard:
		stance = BattleStance.DEFENSIVE
	elif attack:
		stance = BattleStance.OFFENSIVE
	else:
		stance = BattleStance.NEUTRAL

func classify_range(dist: float) -> void:
	if dist >= disengage_range:
		range_state = RangeState.DISENGAGE_RANGE
	elif dist >= striking_range:
		range_state = RangeState.STRIKING_RANGE
	elif dist >= close_range:
		range_state = RangeState.CLOSE_RANGE
	else:
		range_state = RangeState.CLINCH_RANGE

func horizontal_distance() -> float:
	return Vector2((opponent as Node3D).global_position.x - (_player as Node3D).global_position.x, (opponent as Node3D).global_position.z - (_player as Node3D).global_position.z).length()

func opponent_intent() -> int:
	return opponent.call("intent_value")

func range_gate(gate: String) -> float:
	match gate:
		"disengage":
			return disengage_range
		"striking":
			return striking_range
		"close":
			return close_range
		_:
			return engage_radius

func set_advantage(owner: int, reason: String) -> void:
	initiative = owner
	_state_timer = 0.0
	set_contact(ContactState.ADVANTAGE, reason)

func set_contact(next: int, reason: String) -> void:
	if next == contact:
		return
	var from := contact
	contact = next
	last_transition_reason = reason
	if next == ContactState.EXCHANGE:
		_telegraph_timer = 0.0
		_telegraph_prev_intent = -1
		_guard_before_telegraph = false
	elif next == ContactState.ADVANTAGE:
		_state_timer = 0.0
	elif next in [ContactState.RESOLUTION, ContactState.RESET, ContactState.READ]:
		_state_timer = 0.0
	contact_changed.emit(from, next, reason)
	log_change("contact", str(from) + " -> " + str(next) + " (" + reason + ")")

func set_exchange_resolution(value: String) -> void:
	exchange_resolution = value

func ai_surface() -> Dictionary:
	return {
		"contact": contact,
		"range": range_state,
		"stance": stance,
		"posture": posture,
		"stamina": stamina,
		"initiative": initiative,
		"control_reserved": contact == ContactState.CONTROL,
		"commitment": commitment_mult,
	}

func stamina_cost_mult() -> float:
	return RAGE_STAMINA_COST if rage else 1.0

func posture_regen_mult() -> float:
	return RAGE_POSTURE_REGEN if rage else 1.0

func stamina_regen_mult() -> float:
	return RAGE_STAMINA_REGEN if rage else 1.0

func contact_name() -> String:
	match contact:
		ContactState.ENGAGE:
			return "ENGAGE"
		ContactState.EXCHANGE:
			return "EXCHANGE"
		ContactState.ADVANTAGE:
			return "ADVANTAGE"
		ContactState.CONTROL:
			return "CONTROL"
		ContactState.RESOLUTION:
			return "RESOLUTION"
		ContactState.RESET:
			return "RESET"
		_:
			return "READ"

func range_name() -> String:
	match range_state:
		RangeState.STRIKING_RANGE:
			return "STRIKING"
		RangeState.CLOSE_RANGE:
			return "CLOSE"
		RangeState.CLINCH_RANGE:
			return "CLINCH"
		RangeState.GROUND:
			return "GROUND"
		RangeState.ENVIRONMENTAL:
			return "ENVIRONMENTAL"
		_:
			return "DISENGAGE"

func stance_name() -> String:
	match stance:
		BattleStance.OFFENSIVE:
			return "OFFENSIVE"
		BattleStance.DEFENSIVE:
			return "GUARD"
		_:
			return "NEUTRAL"

func control_band_name() -> String:
	if control > 0.66:
		return "COMPOSED"
	if control > 0.33:
		return "FRAGILE"
	return "BLEEDING"

func debug_line() -> String:
	var rage_txt := " RAGE[" + rage_trigger + "]" if rage else ""
	var exh_txt := " EXH" if exhausted else ""
	var res_txt := (" RES=" + resolution_outcome) if resolution_outcome != "" else ""
	return "COMBAT: %s%s%s | CTRL %.2f (%s) | STM %.2f%s | POST %.2f | INTENT %s | RNG %s | %s" % [
		contact_name(), rage_txt, res_txt, control, control_band_name(), stamina, exh_txt, posture, stance_name(), range_name(), last_transition_reason,
	]

func log_change(system: String, value: Variant) -> void:
	if debug_log_enabled:
		print("BV.DEBUG." + system + " -> " + str(value))