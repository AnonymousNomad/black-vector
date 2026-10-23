class_name CharacterPresentationContract
extends Node

signal equipment_attachment_changed(slot: String, item: Node3D)
signal clothing_state_changed(slot: String, item_id: String)
signal injury_presentation_changed(region: String, severity: float, treatment: String)
signal turn_requested(direction: Vector3)

const ATTACHMENT_POINTS := {
	"RIGHT_HAND": "RightHandAttachment",
	"LEFT_HAND": "LeftHandAttachment",
	"SIDEARM_HIP": "SidearmHipAttachment",
	"PRIMARY_BACK": "PrimaryBackAttachment",
	"FIGHTING_KNIFE": "FightingKnifeAttachment",
	"BOOT_KNIFE": "BootKnifeAttachment",
	"CHEST_VEST": "ChestVestAttachment",
}
const CLOTHING_SLOTS := ["BASE_LAYER", "OUTER_LAYER", "FOOTWEAR", "GLOVES", "HEADWEAR", "HAIR"]
const INJURY_REGIONS := ["HEAD", "TORSO", "LEFT_ARM", "RIGHT_ARM", "LEFT_LEG", "RIGHT_LEG"]

@export var visual_root_path: NodePath = ^"../CorleyProxy"

var combat_stance := false
var turn_direction := Vector3.ZERO
var clothing_states := {}
var injury_states := {}
var _equipment_nodes := {}
var _animation: AnimationState

func _ready() -> void:
	_animation = get_parent().get_node_or_null("AnimationState") as AnimationState

func _process(_delta: float) -> void:
	if combat_stance and _animation != null and _animation.action_state == AnimationState.ACTION_NONE:
		_animation.request_action("COMBAT_STANCE", 0.0, 1)

func representation_status() -> String:
	var root := visual_root()
	if root == null:
		return "MISSING_VISUAL_ROOT"
	if root.has_method("representation_status"):
		return str(root.call("representation_status"))
	return "UNVERIFIED"

func has_production_character() -> bool:
	var root := visual_root()
	if root == null or representation_status() != "PRODUCTION_CORLEY":
		return false
	return root.find_child("Skeleton3D", true, false) != null and _animation != null

func visual_root() -> Node3D:
	return get_node_or_null(visual_root_path) as Node3D

func attachment_point(slot: String) -> Node3D:
	var root := visual_root()
	if root == null or not ATTACHMENT_POINTS.has(slot):
		return null
	return root.find_child(str(ATTACHMENT_POINTS[slot]), true, false) as Node3D

func equip_attachment(slot: String, item_scene: PackedScene) -> bool:
	var point := attachment_point(slot)
	if point == null or item_scene == null:
		return false
	var previous: Node = _equipment_nodes.get(slot)
	if is_instance_valid(previous):
		if previous.get_parent() != null:
			previous.get_parent().remove_child(previous)
		previous.queue_free()
	var instance := item_scene.instantiate()
	if not instance is Node3D:
		instance.queue_free()
		return false
	var item := instance as Node3D
	point.add_child(item)
	item.transform = Transform3D.IDENTITY
	_equipment_nodes[slot] = item
	equipment_attachment_changed.emit(slot, item)
	return true

func set_clothing_state(slot: String, item_id: String) -> bool:
	if not CLOTHING_SLOTS.has(slot):
		return false
	clothing_states[slot] = item_id
	clothing_state_changed.emit(slot, item_id)
	return true

func set_injury_presentation(region: String, severity: float, treatment: String = "") -> bool:
	if not INJURY_REGIONS.has(region):
		return false
	var bounded := clampf(severity, 0.0, 1.0)
	injury_states[region] = {"severity": bounded, "treatment": treatment}
	injury_presentation_changed.emit(region, bounded, treatment)
	return true

func request_turn(direction: Vector3) -> bool:
	if direction.length_squared() < 0.001 or _animation == null:
		return false
	turn_direction = direction.normalized()
	turn_requested.emit(turn_direction)
	return _animation.request_action("TURN", 0.24, 1)

func request_interaction() -> bool:
	return _request_action("INTERACTION", 0.55, 2)

func request_recoil() -> bool:
	return _request_action("RECOIL", 0.38, 3)

func request_hurt(severity: float) -> bool:
	if severity <= 0.0:
		return false
	return _request_action("HURT", 0.35 + clampf(severity, 0.0, 1.0) * 0.8, 4)

func set_combat_stance(raised: bool) -> void:
	if combat_stance == raised:
		return
	combat_stance = raised
	if raised:
		_request_action("COMBAT_STANCE", 0.0, 1)
	elif _animation:
		_animation.clear_action_if("COMBAT_STANCE")

func camera_anchor() -> Node3D:
	return get_parent().get_node_or_null("CameraRig") as Node3D

func collision_authority() -> CharacterBody3D:
	return get_parent() as CharacterBody3D

func _request_action(action: String, duration: float, priority: int) -> bool:
	return _animation != null and _animation.request_action(action, duration, priority)
