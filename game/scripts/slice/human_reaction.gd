class_name HumanReaction
extends RefCounted

const FAST_APPROACH := 4.5
const SLOW_APPROACH := 1.5
const CLOSE_DISTANCE := 3.0
const COMFORT_DISTANCE := 6.0
const SMOOTH_RATE := 2.0

var fear := 0.0
var confidence := 0.5
var distance_preference := 0.4
var contact_tolerance := 0.5

func assess(context: Dictionary, delta: float) -> void:
	var distance := float(context.get("distance", 99.0))
	var speed := float(context.get("approach_speed", 0.0))
	var moving_toward := bool(context.get("moving_toward", false))
	var emerged := bool(context.get("emerged", false))
	var suspicion := float(context.get("recent_suspicion", 0.0))
	var stopped := bool(context.get("stopped", true))
	var posture := str(context.get("posture", "STAND"))
	var injured := bool(context.get("injured", false))

	var fear_target := 0.0
	fear_target += clampf((speed - SLOW_APPROACH) / (FAST_APPROACH - SLOW_APPROACH), 0.0, 1.0) * 0.6
	fear_target += clampf(1.0 - distance / COMFORT_DISTANCE, 0.0, 1.0) * 0.35
	if emerged:
		fear_target += 0.55
	if moving_toward:
		fear_target += 0.15
	fear_target += suspicion * 0.25
	if stopped:
		fear_target -= 0.3
	if posture == "CROUCH" or posture == "PRONE":
		fear_target -= 0.1
	if injured:
		fear_target -= 0.08
	fear_target = clampf(fear_target, 0.0, 1.0)

	var confidence_target := clampf(0.45 + clampf(distance / COMFORT_DISTANCE, 0.0, 1.0) * 0.4, 0.0, 1.0)
	if stopped:
		confidence_target += 0.15
	if emerged:
		confidence_target -= 0.3
	if speed > FAST_APPROACH:
		confidence_target -= 0.25
	if suspicion > 0.5:
		confidence_target -= 0.1
	confidence_target = clampf(confidence_target, 0.0, 1.0)

	fear = _approach(fear, fear_target, delta)
	confidence = _approach(confidence, confidence_target, delta)
	distance_preference = clampf(fear * 0.8 + (1.0 - contact_tolerance) * 0.2, 0.0, 1.0)
	contact_tolerance = clampf(1.0 - fear * 0.7 + confidence * 0.2, 0.0, 1.0)

func _approach(current: float, target: float, delta: float) -> float:
	var t := clampf(SMOOTH_RATE * delta, 0.0, 1.0)
	return lerpf(current, target, t)

func fear_band() -> String:
	if fear >= 0.6:
		return "HIGH"
	if fear >= 0.3:
		return "RISING"
	return "CALM"

func confidence_band() -> String:
	if confidence >= 0.6:
		return "STEADY"
	if confidence >= 0.35:
		return "UNCERTAIN"
	return "SHAKEN"

func distance_preference_band() -> String:
	if distance_preference >= 0.6:
		return "STRONG"
	if distance_preference >= 0.3:
		return "SOME"
	return "LOW"

func contact_tolerance_band() -> String:
	if contact_tolerance >= 0.6:
		return "OPEN"
	if contact_tolerance >= 0.35:
		return "GUARDED"
	return "CLOSED"

func snapshot() -> Dictionary:
	return {
		"fear": fear,
		"confidence": confidence,
		"distance_preference": distance_preference,
		"contact_tolerance": contact_tolerance,
	}
