class_name CanneryState
extends Node

const DOOR_ID := "f1_gyle_cannery_door"
const LIGHT_ID := "f1_gyle_cannery_light"

var world: WorldStateManager
var save: SaveStateManager
var root: Node3D
var _door: StaticBody3D
var _light: OmniLight3D
var _applying_light := false
var _door_open_ever := false

func setup(w: WorldStateManager, s: SaveStateManager, cannery_root: Node3D) -> void:
	world = w
	save = s
	root = cannery_root
	if root == null:
		return
	_door = root.get_node_or_null("EntryDoor") as StaticBody3D
	_light = root.get_node_or_null("InteriorLight") as OmniLight3D
	if world:
		world.object_changed.connect(_on_object_changed)
	if save:
		save.load_completed.connect(_on_load_completed)
	apply_all()

func apply_all() -> void:
	_apply_door()
	_apply_light()

func _on_object_changed(id: String) -> void:
	if id == DOOR_ID:
		_apply_door()
	elif id == LIGHT_ID:
		_toggle_light()

func _on_load_completed(_slot: int) -> void:
	apply_all()

func _apply_door() -> void:
	if _door == null or world == null:
		return
	var open := world.object_state(DOOR_ID).has("open")
	_door.collision_layer = 0 if open else 1
	_door.collision_mask = 0
	var mesh: Node = _door.get_node_or_null("MeshInstance3D")
	if mesh:
		mesh.visible = not open
	if open and not _door_open_ever:
		_door_open_ever = true
		_on_door_first_open()

func _on_door_first_open() -> void:
	if world == null:
		return
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
	if _applying_light:
		_apply_light()
		return
	_applying_light = true
	if _light.visible:
		world.mark_object(LIGHT_ID, "closed")
	else:
		world.mark_object(LIGHT_ID, "on")
	_applying_light = false

func _apply_light() -> void:
	if _light == null or world == null:
		return
	_light.visible = world.object_state(LIGHT_ID).has("on")