class_name InteractionManager
extends Node

signal context_changed(action: String)
signal context_cleared
signal action_resolved(action: String, object_id: String)

var current_action := ""
var probe: InteractionProbe
var world: WorldStateManager
var last_resolved := ""
var resolved_count := 0

func setup(w: WorldStateManager) -> void:
	world = w

func accept_probe(p: InteractionProbe) -> void:
	probe = p

func resolve(stowed: bool) -> void:
	if probe == null or probe.target.is_empty():
		if current_action != "":
			current_action = ""
			context_cleared.emit()
		return
	var action := probe.context_action(stowed)
	if action != current_action:
		current_action = action
		if action == "":
			context_cleared.emit()
		else:
			context_changed.emit(action)

func clear() -> void:
	current_action = ""
	context_cleared.emit()
	probe = null

func on_object_activated(action: String, collider: Node) -> void:
	var object_id := ""
	var trace_kind := ""
	if collider != null:
		var oid: Variant = collider.get("object_id")
		if oid != null and str(oid) != "":
			object_id = str(oid)
		else:
			object_id = str(collider.name)
		var tk: Variant = collider.get("trace_kind")
		if tk != null:
			trace_kind = str(tk)
	if object_id == "":
		return
	if world:
		world.mark_object(object_id, action.to_lower())
		if action == "INSPECT" and trace_kind != "":
			world.mark_observation(object_id, trace_kind)
		var entry_kind := "INVESTIGATED"
		if action == "SURVEY":
			entry_kind = "NOTICED"
		elif action == "RECORD":
			entry_kind = "DOCUMENTED"
		elif action == "RESTORE":
			entry_kind = "RESTORED"
		var pos := Vector3.ZERO
		var node3d := collider as Node3D
		if node3d:
			pos = node3d.global_position
		world.add_field_entry(entry_kind, object_id, action.to_lower(), pos)
		if action == "OPEN" or action == "COLLECT":
			world.record_trace("MOVE_OBJECT", pos, 0.6, action.to_lower())
	last_resolved = "%s %s" % [action, object_id]
	resolved_count += 1
	action_resolved.emit(action, object_id)