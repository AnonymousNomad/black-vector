extends StaticBody3D

@export_enum("mantle", "vault", "climb", "conceal", "ledge", "inspect", "open", "collect", "rest", "recover", "survey", "record") var affordance: String = ""
@export var object_id := ""
@export var trace_kind := ""
@export var shelter_radius := 0.0
@export var block_size := Vector3.ONE
@export var block_color := Color(0.55, 0.55, 0.55)

@onready var mesh_instance := $MeshInstance3D as MeshInstance3D
@onready var collision_shape := $CollisionShape3D as CollisionShape3D

func _ready() -> void:
	var box_mesh := mesh_instance.mesh.duplicate() as BoxMesh
	box_mesh.size = block_size
	mesh_instance.mesh = box_mesh
	var box_shape := collision_shape.shape.duplicate() as BoxShape3D
	box_shape.size = block_size
	collision_shape.shape = box_shape
	var material := StandardMaterial3D.new()
	material.albedo_color = block_color
	mesh_instance.material_override = material
	if affordance != "":
		add_to_group("context_" + affordance)
	if shelter_radius > 0.0:
		add_to_group("shelter_zone")