class_name HumanRoutineStop
extends Resource

@export var offset := Vector3.ZERO
@export_enum("IDLE", "WORK", "INSPECT") var activity := "IDLE"
@export_range(0.0, 24.0, 0.25) var start_hour := 0.0
@export_range(0.0, 24.0, 0.25) var end_hour := 24.0
@export_range(0.0, 60.0, 0.25) var dwell_seconds := 6.0

func active_at(hour: float) -> bool:
	var normalized_hour := fposmod(hour, 24.0)
	if is_equal_approx(start_hour, end_hour):
		return false
	if start_hour < end_hour:
		return normalized_hour >= start_hour and normalized_hour < end_hour
	return normalized_hour >= start_hour or normalized_hour < end_hour
