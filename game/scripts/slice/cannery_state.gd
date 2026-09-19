class_name CanneryState
extends Node

const DOOR_ID := "f1_gyle_cannery_door"
const LIGHT_ID := "f1_gyle_cannery_light"
const SWITCH_ID := "f1_gyle_cannery_light_switch"
const DOOR_FIRST_OPEN_SEEN := "f1_gyle_cannery_door_first_open"
const POWER_ID := "f1_gyle_cannery_power"
const FUEL_ID := "f1_cannery_fuel"
const MACHINERY_ID := "f1_cannery_machinery_01"
const SIGNATURE_ID := "f1_cannery_signature"
const FIRST_RESTORE_SEEN := "f1_gyle_cannery_first_restore"
const SEIZED_SEEN := "f1_cannery_machinery_seized_seen"
const HEAT_RADIUS := 6.0

var world: WorldStateManager
var save: SaveStateManager
var root: Node3D
var _door: StaticBody3D
var _light: OmniLight3D
var _machinery: Node3D

func setup(w: WorldStateManager, s: SaveStateManager, cannery_root: Node3D) -> void:
	world = w
	save = s
	root = cannery_root
	if root == null:
		return
	_door = root.get_node_or_null("EntryDoor") as StaticBody3D
	_light = root.get_node_or_null("InteriorLight") as OmniLight3D
	_machinery = root.get_node_or_null("Machinery01") as Node3D
	if world:
		world.object_changed.connect(_on_object_changed)
	if save:
		save.load_completed.connect(_on_load_completed)
	apply_all()

func apply_all() -> void:
	_project_door()
	_apply_light()
	_project_power()
	_project_machinery()

func _on_object_changed(id: String) -> void:
	if id == DOOR_ID:
		_project_door()
		_register_door_first_open()
	elif id == SWITCH_ID:
		_toggle_light()
	elif id == LIGHT_ID:
		_apply_light()
	elif id == POWER_ID:
		_project_power()
	elif id == FUEL_ID:
		_project_machinery()
	elif id == MACHINERY_ID:
		_on_machinery_changed()

func _on_load_completed(_slot: int) -> void:
	apply_all()

func is_powered() -> bool:
	return world != null and world.object_state(POWER_ID).has("powered")

func _project_door() -> void:
	if _door == null or world == null:
		return
	var open := world.object_state(DOOR_ID).has("open")
	_door.collision_layer = 0 if open else 1
	_door.collision_mask = 0
	var mesh: Node = _door.get_node_or_null("MeshInstance3D")
	if mesh:
		mesh.visible = not open

func _register_door_first_open() -> void:
	if world == null or not world.object_state(DOOR_ID).has("open"):
		return
	if world.has_seen(DOOR_FIRST_OPEN_SEEN):
		return
	world.mark_seen(DOOR_FIRST_OPEN_SEEN)
	var pos := Vector3.ZERO
	if _door:
		pos = _door.global_position
	world.add_field_entry("FACILITY", DOOR_ID, "entry opened", pos)
	world.register_poi("f1_gyle_cannery", "FACILITY", pos, 3.0, 0.0)
	if world.channel_value(world.CHANNEL_FACILITY) != "ENTRY_OPEN":
		world.set_channel(world.CHANNEL_FACILITY, "ENTRY_OPEN")

func _toggle_light() -> void:
	if _light == null or world == null:
		return
	var is_on := bool(world.object_state(LIGHT_ID).get("on", false))
	world.set_object_flag(LIGHT_ID, "on", not is_on)

func _apply_light() -> void:
	if _light == null or world == null:
		return
	_light.visible = bool(world.object_state(LIGHT_ID).get("on", false))

func _project_power() -> void:
	if _machinery == null or world == null:
		return
	if is_powered():
		if not _machinery.is_in_group("shelter_zone"):
			_machinery.add_to_group("shelter_zone")
		_machinery.set("shelter_radius", HEAT_RADIUS)
	else:
		if _machinery.is_in_group("shelter_zone"):
			_machinery.remove_from_group("shelter_zone")
		_machinery.set("shelter_radius", 0.0)
	_project_machinery()

func _project_machinery() -> void:
	if _machinery == null or world == null:
		return
	var fuel_ready := world.object_state(FUEL_ID).has("collect")
	var restore_ready := fuel_ready and not is_powered()
	if restore_ready:
		if _machinery.is_in_group("context_inspect"):
			_machinery.remove_from_group("context_inspect")
		if not _machinery.is_in_group("context_restore"):
			_machinery.add_to_group("context_restore")
	else:
		if _machinery.is_in_group("context_restore"):
			_machinery.remove_from_group("context_restore")
		if not _machinery.is_in_group("context_inspect"):
			_machinery.add_to_group("context_inspect")

func _on_machinery_changed() -> void:
	if world == null:
		return
	var state := world.object_state(MACHINERY_ID)
	if state.has("restore"):
		_restore_power()
	elif state.has("inspect") and not is_powered() and not world.object_state(FUEL_ID).has("collect"):
		if not world.has_seen(SEIZED_SEEN):
			world.mark_seen(SEIZED_SEEN)
			world.add_field_entry("SEIZED", MACHINERY_ID, "needs_fuel", _node_pos(_machinery))

func _restore_power() -> void:
	if world == null or is_powered() or world.has_seen(FIRST_RESTORE_SEEN):
		return
	if not world.object_state(FUEL_ID).has("collect"):
		return
	world.mark_seen(FIRST_RESTORE_SEEN)
	world.set_object_flag(FUEL_ID, "collect", false)
	world.set_object_flag(FUEL_ID, "consumed", true)
	if world.channel_value(world.CHANNEL_FACILITY) != "POWERED":
		world.set_channel(world.CHANNEL_FACILITY, "POWERED")
	world.set_object_flag(LIGHT_ID, "on", true)
	world.set_object_flag(SIGNATURE_ID, "heat_light", true)
	world.add_field_entry("SIGNATURE", "f1_gyle_cannery", "heat_light", _node_pos(_machinery))
	world.set_object_flag(POWER_ID, "powered", true)

func _node_pos(node: Node3D) -> Vector3:
	return node.global_position if node else Vector3.ZERO