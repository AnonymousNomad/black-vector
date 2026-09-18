class_name BeatStaging
extends Node

const DOOR_ID := "f1_gyle_cannery_door"

var world: WorldStateManager
var narrative: NarrativeChannels
var _door_narrated := false

func setup(w: WorldStateManager, n: NarrativeChannels) -> void:
	world = w
	narrative = n
	if world:
		world.object_changed.connect(_on_object_changed)

func stage_awakening() -> void:
	if narrative == null:
		return
	narrative.emit_inner_thought("beat_strand_awakening", "inner_strand_awakening", {}, true)
	narrative.emit_inner_thought("beat_photograph", "inner_photograph", {}, true)

func _on_object_changed(id: String) -> void:
	if id != DOOR_ID or _door_narrated:
		return
	if world == null or not world.object_state(DOOR_ID).has("open"):
		return
	_door_narrated = true
	if narrative == null:
		return
	narrative.emit_inner_thought("beat_cannery_unsealed", "inner_cannery_unsealed", {})
	if world and not world.has_seen("beat_cannery_seen"):
		world.mark_seen("beat_cannery_seen")
		narrative.note_observable("f1_gyle_cannery", "reality_gyle_cannery")