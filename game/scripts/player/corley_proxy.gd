class_name CorleyProxy
extends Node3D

## Original procedural presentation proxy. The CharacterBody3D/controller remains
## the movement authority; this node only follows AnimationState.

var _animation_state: Node
var _parts: Dictionary = {}
var _phase := 0.0
var _skeleton: Skeleton3D

func _ready() -> void:
	add_to_group("corley_proxy")
	_animation_state = get_parent().get_node_or_null("AnimationState")
	_build_skeleton()
	_build_future_attachment_points()
	_build_body()

func _process(delta: float) -> void:
	_phase += delta
	_apply_presentation()

func _build_skeleton() -> void:
	_skeleton = Skeleton3D.new()
	_skeleton.name = "HumanoidSkeleton"
	add_child(_skeleton)
	var bones := ["root", "hips", "spine", "chest", "neck", "head", "upper_arm_l", "forearm_l", "upper_arm_r", "forearm_r", "thigh_l", "shin_l", "foot_l", "thigh_r", "shin_r", "foot_r"]
	for bone_name in bones:
		_skeleton.add_bone(bone_name)
	_skeleton.set_bone_parent(_skeleton.find_bone("hips"), _skeleton.find_bone("root"))
	_skeleton.set_bone_parent(_skeleton.find_bone("spine"), _skeleton.find_bone("hips"))
	_skeleton.set_bone_parent(_skeleton.find_bone("chest"), _skeleton.find_bone("spine"))
	_skeleton.set_bone_parent(_skeleton.find_bone("neck"), _skeleton.find_bone("chest"))
	_skeleton.set_bone_parent(_skeleton.find_bone("head"), _skeleton.find_bone("neck"))
	_skeleton.set_bone_parent(_skeleton.find_bone("upper_arm_l"), _skeleton.find_bone("chest"))
	_skeleton.set_bone_parent(_skeleton.find_bone("forearm_l"), _skeleton.find_bone("upper_arm_l"))
	_skeleton.set_bone_parent(_skeleton.find_bone("upper_arm_r"), _skeleton.find_bone("chest"))
	_skeleton.set_bone_parent(_skeleton.find_bone("forearm_r"), _skeleton.find_bone("upper_arm_r"))
	_skeleton.set_bone_parent(_skeleton.find_bone("thigh_l"), _skeleton.find_bone("hips"))
	_skeleton.set_bone_parent(_skeleton.find_bone("shin_l"), _skeleton.find_bone("thigh_l"))
	_skeleton.set_bone_parent(_skeleton.find_bone("foot_l"), _skeleton.find_bone("shin_l"))
	_skeleton.set_bone_parent(_skeleton.find_bone("thigh_r"), _skeleton.find_bone("hips"))
	_skeleton.set_bone_parent(_skeleton.find_bone("shin_r"), _skeleton.find_bone("thigh_r"))
	_skeleton.set_bone_parent(_skeleton.find_bone("foot_r"), _skeleton.find_bone("shin_r"))

func _build_future_attachment_points() -> void:
	for point_name in ["RightHandAttachment", "LeftHandAttachment", "SidearmHipAttachment", "PrimaryBackAttachment", "FightingKnifeAttachment", "BootKnifeAttachment", "ChestVestAttachment"]:
		var marker := Node3D.new()
		marker.name = point_name
		marker.add_to_group("future_attachment_point")
		add_child(marker)
	marker_position("RightHandAttachment", Vector3(0.38, 1.18, -0.05))
	marker_position("LeftHandAttachment", Vector3(-0.38, 1.18, -0.05))
	marker_position("SidearmHipAttachment", Vector3(0.33, 0.78, 0.1))
	marker_position("PrimaryBackAttachment", Vector3(0.0, 1.25, 0.2))
	marker_position("FightingKnifeAttachment", Vector3(-0.28, 0.86, 0.12))
	marker_position("BootKnifeAttachment", Vector3(0.16, 0.18, 0.08))
	marker_position("ChestVestAttachment", Vector3(0.0, 1.25, -0.2))

func marker_position(point_name: String, value: Vector3) -> void:
	var marker := get_node_or_null(point_name) as Node3D
	if marker:
		marker.position = value

func _material(color: Color, roughness := 0.78) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = roughness
	return material

func _box_part(part_name: String, size: Vector3, position: Vector3, material: Material) -> void:
	var mesh := BoxMesh.new()
	mesh.size = size
	var instance := MeshInstance3D.new()
	instance.name = part_name
	instance.mesh = mesh
	instance.material_override = material
	instance.position = position
	add_child(instance)
	_parts[part_name] = instance

func _sphere_part(part_name: String, radius: float, height: float, position: Vector3, material: Material) -> void:
	var mesh := SphereMesh.new()
	mesh.radius = radius
	mesh.height = height
	mesh.radial_segments = 12
	mesh.rings = 6
	var instance := MeshInstance3D.new()
	instance.name = part_name
	instance.mesh = mesh
	instance.material_override = material
	instance.position = position
	add_child(instance)
	_parts[part_name] = instance

func _build_body() -> void:
	var suit := _material(Color("#303a3b"), 0.88)
	var vest := _material(Color("#4e5147"), 0.92)
	var skin := _material(Color("#b68168"), 0.76)
	var hair := _material(Color("#22282a"), 0.94)
	var boot := _material(Color("#202528"), 0.9)
	var accent := _material(Color("#8b775b"), 0.82)
	_box_part("Torso", Vector3(0.56, 0.68, 0.32), Vector3(0, 1.14, 0), suit)
	_box_part("Vest", Vector3(0.61, 0.58, 0.36), Vector3(0, 1.16, -0.02), vest)
	_box_part("Hips", Vector3(0.48, 0.24, 0.28), Vector3(0, 0.76, 0), suit)
	_sphere_part("Head", 0.17, 0.34, Vector3(0, 1.72, 0), skin)
	_sphere_part("Hair", 0.18, 0.28, Vector3(0, 1.83, 0.035), hair)
	_box_part("Neck", Vector3(0.16, 0.16, 0.16), Vector3(0, 1.53, 0), skin)
	_box_part("ArmL", Vector3(0.15, 0.58, 0.15), Vector3(-0.39, 1.16, 0), suit)
	_box_part("ArmR", Vector3(0.15, 0.58, 0.15), Vector3(0.39, 1.16, 0), suit)
	_box_part("HandL", Vector3(0.13, 0.18, 0.13), Vector3(-0.39, 0.81, -0.01), skin)
	_box_part("HandR", Vector3(0.13, 0.18, 0.13), Vector3(0.39, 0.81, -0.01), skin)
	_box_part("LegL", Vector3(0.18, 0.64, 0.18), Vector3(-0.16, 0.43, 0), suit)
	_box_part("LegR", Vector3(0.18, 0.64, 0.18), Vector3(0.16, 0.43, 0), suit)
	_box_part("BootL", Vector3(0.2, 0.16, 0.38), Vector3(-0.16, 0.08, -0.06), boot)
	_box_part("BootR", Vector3(0.2, 0.16, 0.38), Vector3(0.16, 0.08, -0.06), boot)
	_box_part("ChestPatch", Vector3(0.2, 0.16, 0.03), Vector3(0, 1.27, -0.19), accent)

func _set_position(part_name: String, value: Vector3) -> void:
	var part := _parts.get(part_name) as Node3D
	if part:
		part.position = value

func _set_rotation(part_name: String, value: Vector3) -> void:
	var part := _parts.get(part_name) as Node3D
	if part:
		part.rotation = value

func _apply_presentation() -> void:
	var state := "idle"
	if _animation_state:
		state = str(_animation_state.get("current"))
	var crouched := state == "crouch" or state == "crouch_walk" or state == "prone" or state == "prone_crawl"
	var moving := state == "walk" or state == "jog" or state == "sprint" or state == "crouch_walk" or state == "prone_crawl"
	var frequency := 1.8
	if state == "jog":
		frequency = 3.2
	elif state == "sprint":
		frequency = 4.4
	elif state == "crouch_walk":
		frequency = 1.45
	var gait := sin(_phase * frequency)
	var bob := absf(sin(_phase * frequency)) * (0.025 if moving else 0.0)
	var height_scale := 0.72 if crouched else 1.0
	var torso_y := 0.88 if crouched else 1.14
	_set_position("Torso", Vector3(0, torso_y + bob, 0))
	_set_position("Vest", Vector3(0, torso_y + 0.02 + bob, -0.02))
	_set_position("Head", Vector3(0, (1.40 if crouched else 1.72) + bob, 0))
	_set_position("Hair", Vector3(0, (1.51 if crouched else 1.83) + bob, 0.035))
	_set_position("Neck", Vector3(0, (1.31 if crouched else 1.53) + bob, 0))
	_set_position("Hips", Vector3(0, 0.60 if crouched else 0.76, 0))
	_set_position("ArmL", Vector3(-0.36, torso_y - 0.02, 0))
	_set_position("ArmR", Vector3(0.36, torso_y - 0.02, 0))
	_set_position("HandL", Vector3(-0.36, torso_y - 0.37, -0.01))
	_set_position("HandR", Vector3(0.36, torso_y - 0.37, -0.01))
	_set_position("LegL", Vector3(-0.16, 0.34 if crouched else 0.43, 0))
	_set_position("LegR", Vector3(0.16, 0.34 if crouched else 0.43, 0))
	_set_position("BootL", Vector3(-0.16, 0.07, -0.06))
	_set_position("BootR", Vector3(0.16, 0.07, -0.06))
	var swing := gait * (0.28 if moving else 0.04)
	_set_rotation("ArmL", Vector3(-swing, 0, 0))
	_set_rotation("ArmR", Vector3(swing, 0, 0))
	_set_rotation("LegL", Vector3(swing, 0, 0))
	_set_rotation("LegR", Vector3(-swing, 0, 0))
	if state == "prone" or state == "prone_crawl":
		rotation.x = -0.12
		_set_position("Torso", Vector3(0, 0.48, 0.12))
	else:
		rotation.x = 0.0
	_skeleton.set_bone_pose_position(_skeleton.find_bone("root"), Vector3.ZERO)
