class_name PlayerStateManager
extends Node

signal body_changed

const BODY_BANDS := ["CORE_TEMP", "CONDITION", "EXERTION", "WETNESS", "FATIGUE", "INJURY", "HUNGER", "THIRST", "EXPOSURE"]

var seed_value: int = 0

var body := {}
var position := Vector3.ZERO
var last_checkpoint := Vector3.ZERO
var equipment := {}
var equipped_slot := ""

func _ready() -> void:
	reset_body()

func register_player(p: Node3D) -> void:
	if not is_instance_valid(p):
		return
	position = p.global_position
	last_checkpoint = position
	p.tree_exited.connect(_on_player_freed)

func _on_player_freed() -> void:
	position = last_checkpoint

func reset_body() -> void:
	body = {
		"CORE_TEMP": 1.0,
		"CONDITION": 1.0,
		"EXERTION": 0.0,
		"WETNESS": 0.0,
		"FATIGUE": 0.0,
		"INJURY": 0.0,
		"HUNGER": 0.0,
		"THIRST": 0.0,
		"EXPOSURE": 0.0,
	}
	body_changed.emit()

func set_band(name: String, value: float) -> void:
	if body.has(name):
		body[name] = clampf(value, 0.0, 1.0)
		body_changed.emit()

func band(name: String) -> float:
	return body.get(name, 0.0)

func set_band_multiplier(_name: String, _value: float) -> void:
	pass

func seed_equipment(items: Array) -> void:
	for entry in items:
		if entry is FieldItem:
			var item := entry as FieldItem
			equipment[item.slot] = item.to_dict()
	if equipped_slot == "" and equipment.has(FieldItem.SLOT_TOOL):
		equipped_slot = FieldItem.SLOT_TOOL

func equipped_item() -> Dictionary:
	return equipment.get(equipped_slot, {})

func set_equipped(slot: String) -> void:
	if equipment.has(slot):
		equipped_slot = slot

func update_item_condition(slot: String, value: float) -> void:
	if equipment.has(slot):
		equipment[slot]["condition"] = clampf(value, 0.0, 1.0)

func add_item_history(slot: String, entry: String) -> void:
	if equipment.has(slot):
		equipment[slot]["history"].append(entry)

func snapshot() -> Dictionary:
	return {
		"seed": seed_value,
		"position": [position.x, position.y, position.z],
		"checkpoint": [last_checkpoint.x, last_checkpoint.y, last_checkpoint.z],
		"body": body.duplicate(),
		"equipment": equipment.duplicate(true),
		"equipped_slot": equipped_slot,
	}

func _vec3(v: Variant, fallback: Vector3) -> Vector3:
	if v is Array and (v as Array).size() == 3:
		return Vector3(float((v as Array)[0]), float((v as Array)[1]), float((v as Array)[2]))
	return fallback

func restore(snap: Dictionary) -> void:
	seed_value = int(snap.get("seed", 0))
	position = _vec3(snap.get("position", []), position)
	last_checkpoint = _vec3(snap.get("checkpoint", []), position)
	reset_body()
	var b: Dictionary = snap.get("body", body)
	for band in BODY_BANDS:
		if b.has(band):
			body[band] = clampf(float(b[band]), 0.0, 1.0)
	if snap.has("equipment"):
		var gear: Variant = snap["equipment"]
		if gear is Dictionary:
			equipment = (gear as Dictionary).duplicate(true)
	if snap.has("equipped_slot"):
		equipped_slot = str(snap["equipped_slot"])
	body_changed.emit()