class_name CorleyProxy
extends Node3D

## Loads the original, rigged opening-state Corley model. Player movement and
## collision remain owned by CharacterBody3D; this node drives presentation.

const PRODUCTION_MODEL: PackedScene = preload("res://assets/characters/corley_opening.glb")
# The imported HumanoidSkeleton keeps its Skeleton3D node name so GLTF animation paths remain valid.
const REQUIRED_ANIMATIONS := [
	"idle", "walk", "jog", "sprint", "air", "crouch", "crouch_walk",
	"prone", "prone_crawl", "turn", "interaction", "hurt", "recoil", "combat_stance",
]
const ATTACHMENT_BONES := {
	"RightHandAttachment": "hand.R",
	"LeftHandAttachment": "hand.L",
	"SidearmHipAttachment": "hips",
	"PrimaryBackAttachment": "spine",
	"FightingKnifeAttachment": "hips",
	"BootKnifeAttachment": "foot.L",
	"ChestVestAttachment": "chest",
}
const INJURY_BONES := {
	"HEAD": "head",
	"TORSO": "chest",
	"LEFT_ARM": "forearm.L",
	"RIGHT_ARM": "forearm.R",
	"LEFT_LEG": "shin.L",
	"RIGHT_LEG": "shin.R",
}

var _animation_state: AnimationState
var _presentation_contract: CharacterPresentationContract
var _model: Node3D
var _skeleton: Skeleton3D
var _animation_player: AnimationPlayer
var _playing_animation := ""
var _injury_nodes: Dictionary = {}

func _ready() -> void:
	add_to_group("corley_proxy")
	_animation_state = get_parent().get_node_or_null("AnimationState") as AnimationState
	_presentation_contract = get_parent().get_node_or_null("CharacterPresentation") as CharacterPresentationContract
	_load_production_model()
	if representation_status() == "PRODUCTION_CORLEY":
		add_to_group("production_corley")
	if _presentation_contract:
		_presentation_contract.clothing_state_changed.connect(_on_clothing_state_changed)
		_presentation_contract.injury_presentation_changed.connect(_on_injury_presentation_changed)
	if _animation_state:
		_animation_state.state_changed.connect(_on_animation_state_changed)
		_animation_state.action_changed.connect(_on_action_changed)
		_play_active_animation()
	_apply_opening_clothing_state()

func _load_production_model() -> void:
	if PRODUCTION_MODEL == null:
		return
	_model = PRODUCTION_MODEL.instantiate() as Node3D
	if _model == null:
		return
	_model.name = "ProductionCorleyModel"
	# Blender's authored front is +Y (exported as +Z); gameplay forward is -Z.
	# Rotate the imported root so the gameplay camera sees her back by default.
	_model.rotation.y = PI
	add_child(_model)
	_skeleton = _model.find_child("Skeleton3D", true, false) as Skeleton3D
	_animation_player = _model.find_child("AnimationPlayer", true, false) as AnimationPlayer
	if _skeleton:
		_build_equipment_attachments()
		_build_injury_presentation()
	if _animation_player:
		for animation_name in ["idle", "walk", "jog", "sprint", "crouch", "crouch_walk", "prone", "prone_crawl", "combat_stance"]:
			var animation := _animation_player.get_animation(animation_name)
			if animation:
				animation.loop_mode = Animation.LOOP_LINEAR

func _build_equipment_attachments() -> void:
	for attachment_name in ["RightHandAttachment", "LeftHandAttachment", "SidearmHipAttachment", "PrimaryBackAttachment", "FightingKnifeAttachment", "BootKnifeAttachment", "ChestVestAttachment"]:
		var attachment := BoneAttachment3D.new()
		attachment.name = attachment_name
		attachment.bone_name = str(ATTACHMENT_BONES[attachment_name])
		_skeleton.add_child(attachment)
		attachment.add_to_group("future_attachment_point")
		match attachment_name:
			"SidearmHipAttachment":
				attachment.position = Vector3(0.21, -0.02, 0.08)
			"PrimaryBackAttachment":
				attachment.position = Vector3(0.0, 0.04, 0.16)
			"FightingKnifeAttachment":
				attachment.position = Vector3(-0.17, -0.02, 0.04)
			"BootKnifeAttachment":
				attachment.position = Vector3(0.06, 0.02, 0.02)
			"ChestVestAttachment":
				attachment.position = Vector3(0.0, 0.02, -0.12)

func _build_injury_presentation() -> void:
	for region in INJURY_BONES:
		var attachment := BoneAttachment3D.new()
		attachment.name = "InjuryAttachment_%s" % region
		attachment.bone_name = str(INJURY_BONES[region])
		_skeleton.add_child(attachment)
		var abrasion := MeshInstance3D.new()
		abrasion.name = "InjuryAbrasion"
		var abrasion_mesh := SphereMesh.new()
		abrasion_mesh.radius = 0.04
		abrasion_mesh.height = 0.025
		abrasion_mesh.radial_segments = 16
		abrasion_mesh.rings = 8
		abrasion.mesh = abrasion_mesh
		abrasion.material_override = _injury_material(Color("#65392e"))
		abrasion.position = Vector3(0.0, 0.0, -0.045)
		abrasion.visible = false
		attachment.add_child(abrasion)
		var bandage := MeshInstance3D.new()
		bandage.name = "InjuryWrap"
		var bandage_mesh := SphereMesh.new()
		bandage_mesh.radius = 0.047
		bandage_mesh.height = 0.028
		bandage_mesh.radial_segments = 16
		bandage_mesh.rings = 8
		bandage.mesh = bandage_mesh
		bandage.material_override = _injury_material(Color("#b8ad8d"))
		bandage.position = Vector3(0.0, 0.0, -0.045)
		bandage.scale = Vector3(1.0, 0.32, 1.0)
		bandage.visible = false
		attachment.add_child(bandage)
		_injury_nodes[region] = {"abrasion": abrasion, "wrap": bandage}

func _injury_material(color: Color) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = 0.88
	return material

func representation_status() -> String:
	if _model == null or _skeleton == null or _animation_player == null:
		return "MISSING_PRODUCTION_ASSET"
	for animation_name in REQUIRED_ANIMATIONS:
		if not _animation_player.has_animation(animation_name):
			return "INCOMPLETE_PRODUCTION_CORLEY"
	return "PRODUCTION_CORLEY"

func production_animation_names() -> PackedStringArray:
	return PackedStringArray(_animation_player.get_animation_list()) if _animation_player else PackedStringArray()

func humanoid_skeleton() -> Skeleton3D:
	return _skeleton

func _on_animation_state_changed(_state: String) -> void:
	_play_active_animation()

func _on_action_changed(_action: String) -> void:
	_play_active_animation()

func _play_active_animation() -> void:
	if _animation_player == null or _animation_state == null:
		return
	var animation_name := str(_animation_state.current)
	match str(_animation_state.action_state):
		"TURN":
			animation_name = "turn"
		"INTERACTION":
			animation_name = "interaction"
		"HURT":
			animation_name = "hurt"
		"RECOIL":
			animation_name = "recoil"
		"COMBAT_STANCE":
			animation_name = "combat_stance"
	if animation_name == "jog" or animation_name == "sprint" or animation_name == "air":
		animation_name = "run" if animation_name != "jog" else "jog"
	if animation_name == _playing_animation and _animation_player.is_playing():
		return
	if _animation_player.has_animation(animation_name):
		_playing_animation = animation_name
		_animation_player.play(animation_name, 0.12)

func _on_clothing_state_changed(slot: String, item_id: String) -> void:
	if slot != "OUTER_LAYER":
		return
	var equipped := item_id == "FIELD_SHELL" or item_id == "WEATHER_SHELL"
	_set_field_layer_visible(equipped)

func _apply_opening_clothing_state() -> void:
	# Corley begins wet and under-equipped in a worn tank, prison medical trousers,
	# and badly worn slip-ons. The optional weather shell stays stowed.
	_set_field_layer_visible(false)

func _set_field_layer_visible(visible_state: bool) -> void:
	if _model == null:
		return
	var nodes: Array[Node] = []
	_collect_nodes(_model, nodes)
	for node in nodes:
		if str(node.name).begins_with("FieldLayer_") and node is GeometryInstance3D:
			(node as GeometryInstance3D).visible = visible_state

func _on_injury_presentation_changed(region: String, severity: float, treatment: String) -> void:
	if not _injury_nodes.has(region):
		return
	var nodes: Dictionary = _injury_nodes[region]
	var active := severity >= 0.12
	var wrapped := active and treatment == "WRAPPED"
	(nodes["abrasion"] as MeshInstance3D).visible = active and not wrapped
	(nodes["wrap"] as MeshInstance3D).visible = wrapped

func _collect_nodes(node: Node, output: Array[Node]) -> void:
	for child in node.get_children():
		output.append(child)
		_collect_nodes(child, output)
