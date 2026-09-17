class_name FieldInterface
extends Node

var player_state: PlayerStateManager
var world: WorldStateManager
var tactical: TacticalManager

func setup(ps: PlayerStateManager, w: WorldStateManager, t: TacticalManager = null) -> void:
	player_state = ps
	world = w
	tactical = t

func position_report(body: CharacterBody3D) -> Dictionary:
	if tactical == null:
		return {}
	return tactical.assess_body(body)

func route_report(body: CharacterBody3D) -> Dictionary:
	if tactical == null or body == null:
		return {}
	var report := tactical.assess_body(body)
	var speed := Vector2(body.velocity.x, body.velocity.z).length()
	var speed_band := "stationary"
	if speed >= 6.0:
		speed_band = "fast"
	elif speed >= 3.0:
		speed_band = "moving"
	elif speed > 0.3:
		speed_band = "slow"
	var weather := "CLEAR"
	if world:
		weather = world.channel_value(world.CHANNEL_WEATHER)
	var weather_factor := 1.0
	if weather == "RAIN":
		weather_factor = 1.2
	elif weather == "STORM":
		weather_factor = 1.4
	var speed_factor := 0.0
	if speed_band == "fast":
		speed_factor = 0.5
	elif speed_band == "moving":
		speed_factor = 0.3
	elif speed_band == "slow":
		speed_factor = 0.1
	var disturbance := clampf(float(report.get("exposure_risk", 1.0)) * (0.5 + speed_factor) * weather_factor, 0.0, 1.0)
	var disturbance_band := "low"
	if disturbance >= 0.6:
		disturbance_band = "high"
	elif disturbance >= 0.3:
		disturbance_band = "moderate"
	var approach := "concealed"
	if str(report.get("classification", "")) == "EXPOSED_GROUND":
		approach = "exposed"
	var observation := "neutral"
	if float(report.get("observation_quality", 0.0)) >= 0.7:
		observation = "advantage"
	return {
		"approach": approach,
		"disturbance": disturbance_band,
		"observation": observation,
		"speed_band": speed_band,
	}

func equipped_item() -> Dictionary:
	if player_state == null:
		return {}
	return player_state.equipped_item()

func equipment_summary() -> Array[Dictionary]:
	var out: Array[Dictionary] = []
	if player_state == null:
		return out
	for slot in player_state.equipment.keys():
		var item: Dictionary = player_state.equipment[slot]
		var cond := float(item.get("condition", 0.0))
		out.append({
			"slot": slot,
			"id": item.get("id", ""),
			"name": item.get("name", ""),
			"condition": cond,
			"condition_label": condition_label(cond),
			"ownership": item.get("ownership", ""),
			"hooks": item.get("hooks", []),
		})
	return out

func cycle_equipped() -> String:
	if player_state == null:
		return ""
	var slots: Array = player_state.equipment.keys()
	if slots.is_empty():
		return ""
	var index := slots.find(player_state.equipped_slot)
	index = (index + 1) % slots.size()
	player_state.set_equipped(str(slots[index]))
	return player_state.equipped_slot

func condition_label(value: float) -> String:
	if value >= 0.8:
		return "FINE"
	if value >= 0.5:
		return "WORN"
	if value >= 0.25:
		return "POOR"
	return "FAILING"

func survival_summary() -> Dictionary:
	if player_state == null:
		return {}
	return {
		"exertion": band_label("EXERTION"),
		"fatigue": band_label("FATIGUE"),
		"injury": band_label("INJURY"),
		"exposure": band_label("EXPOSURE"),
		"hunger": band_label("HUNGER"),
		"thirst": band_label("THIRST"),
	}

func band_label(name: String) -> String:
	if player_state == null:
		return "UNKNOWN"
	var value := player_state.band(name)
	if value >= 0.75:
		return "SEVERE"
	if value >= 0.4:
		return "ELEVATED"
	if value > 0.15:
		return "MILD"
	return "STEADY"

func observations_summary() -> Dictionary:
	if world == null:
		return {"count": 0, "kinds": []}
	var kinds: Array = []
	for id in world.observations.keys():
		kinds.append(world.observations[id])
	return {"count": world.observations.size(), "kinds": kinds}

func recon_summary() -> Dictionary:
	if world == null:
		return {"pois": 0, "record": 0, "last": ""}
	var last := ""
	if not world.field_record.is_empty():
		var entry: Dictionary = world.field_record[world.field_record.size() - 1]
		last = "%s %s" % [str(entry.get("kind", "")), str(entry.get("subject", ""))]
	return {"pois": world.pois.size(), "traces": world.traces.size(), "record": world.field_record.size(), "last": last}

func threat_summary() -> Array[String]:
	var out: Array[String] = []
	if world == null:
		return out
	for id in world.human_records.keys():
		var record: Dictionary = world.human_records[id]
		out.append("%s: %s" % [id, str(record.get("level", "UNKNOWN")).to_lower()])
	return out
