class_name InputProfile
extends Resource

const PROFILE_VERSION := 1

@export var left_thumb_zone := Rect2(0.0, 0.45, 0.4, 0.5)
@export var right_thumb_zone := Rect2(0.6, 0.45, 0.4, 0.5)
@export var context_zone := Rect2(0.72, 0.26, 0.26, 0.16)
@export_range(20.0, 200.0) var move_stick_radius := 160.0
@export_range(20.0, 200.0) var look_stick_radius := 90.0
@export_range(0.0, 0.6) var analog_speed_floor := 0.30
@export_range(0.001, 0.02) var look_sensitivity := 0.006
@export var invert_look_y := false
@export var mirror_layout := false
@export var controller_preferred := false

func mirrored_zones() -> Array[Rect2]:
	var left := left_thumb_zone
	var right := right_thumb_zone
	if mirror_layout:
		left = Rect2(1.0 - left_thumb_zone.position.x - left_thumb_zone.size.x, left_thumb_zone.position.y, left_thumb_zone.size.x, left_thumb_zone.size.y)
		right = Rect2(1.0 - right_thumb_zone.position.x - right_thumb_zone.size.x, right_thumb_zone.position.y, right_thumb_zone.size.x, right_thumb_zone.size.y)
	return [left, right]

func context_rect() -> Rect2:
	if not mirror_layout:
		return context_zone
	return Rect2(1.0 - context_zone.position.x - context_zone.size.x, context_zone.position.y, context_zone.size.x, context_zone.size.y)

func movement_strength(magnitude: float) -> float:
	var m := clampf(magnitude, 0.0, 1.0)
	return analog_speed_floor + (1.0 - analog_speed_floor) * m