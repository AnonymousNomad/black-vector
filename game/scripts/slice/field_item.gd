class_name FieldItem
extends RefCounted

const SLOT_TOOL := "tool"
const SLOT_MEDICAL := "medical"
const SLOT_SUPPLIES := "supplies"
const SLOT_OBSERVATION := "observation"
const SLOT_WEAPON := "weapon"
const SLOT_AMMO := "ammo"
const SLOT_PERSONAL := "personal"

var id := ""
var slot := ""
var display_name := ""
var ownership := ""
var condition := 1.0
var history: Array[String] = []
var hooks: Array[String] = []

static func create(p_id: String, p_slot: String, p_name: String, p_ownership: String, p_condition: float, p_history: Array[String], p_hooks: Array[String]) -> FieldItem:
	var item := FieldItem.new()
	item.id = p_id
	item.slot = p_slot
	item.display_name = p_name
	item.ownership = p_ownership
	item.condition = clampf(p_condition, 0.0, 1.0)
	item.history = p_history.duplicate()
	item.hooks = p_hooks.duplicate()
	return item

static func baseline_kit() -> Array[FieldItem]:
	return [
		create("boot_knife", SLOT_TOOL, "Boot Knife", "UNIT MARKINGS REMOVED", 0.62, ["kept on person through intake"], ["USE", "INSPECT"]),
		create("medical_kit", SLOT_MEDICAL, "Medical Kit", "ISLAND STORES", 0.8, ["partially depleted"], ["USE", "INSPECT", "TREAT"]),
		create("field_supplies", SLOT_SUPPLIES, "Field Supplies", "ISLAND STORES", 0.7, ["rationed"], ["USE", "INSPECT"]),
		create("observation_kit", SLOT_OBSERVATION, "Observation Kit", "OVERWATCH RECON", 0.9, ["carried through intake"], ["SURVEY", "INSPECT", "RECORD"]),
		create("sidearm", SLOT_WEAPON, "Sidearm", "UNIT MARKINGS REMOVED", 0.55, ["worn from use", "few magazines to hand"], ["INSPECT"]),
		create("magazines", SLOT_AMMO, "Magazines (limited)", "UNIT MARKINGS REMOVED", 0.6, ["one loaded, one spare"], ["INSPECT"]),
		create("photograph", SLOT_PERSONAL, "Photograph", "CARRIED THROUGH INTAKE", 0.4, ["worn at the edges", "a woman in the frame - familiar, unable to place her"], ["INSPECT"]),
	]

func to_dict() -> Dictionary:
	return {
		"id": id,
		"slot": slot,
		"name": display_name,
		"ownership": ownership,
		"condition": condition,
		"history": history.duplicate(),
		"hooks": hooks.duplicate(),
	}

static func from_dict(data: Dictionary) -> FieldItem:
	var item := FieldItem.new()
	item.id = str(data.get("id", ""))
	item.slot = str(data.get("slot", ""))
	item.display_name = str(data.get("name", ""))
	item.ownership = str(data.get("ownership", ""))
	item.condition = clampf(float(data.get("condition", 1.0)), 0.0, 1.0)
	var hist: Variant = data.get("history", [])
	if hist is Array:
		for entry in hist:
			item.history.append(str(entry))
	var hook_list: Variant = data.get("hooks", [])
	if hook_list is Array:
		for hook in hook_list:
			item.hooks.append(str(hook))
	return item
