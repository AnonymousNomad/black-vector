class_name VisualWildernessProof1
extends Node3D

## Bounded, presentation-only wilderness cell. Gameplay state remains owned by
## GameWorld and the accepted Strand/Cannery scenes.

@export_enum("PERFORMANCE", "BALANCED", "QUALITY") var presentation_profile := "BALANCED"
@export var planning_envelope := Vector2(500.0, 250.0)
@export var planning_cell_size := 250.0
@export var deterministic_seed := 1337

var _vegetation_count := 0
var _terrain_area := 0.0
var _water_present := false
var _rng := RandomNumberGenerator.new()

func _ready() -> void:
	add_to_group("visual_wilderness_region")
	_rng.seed = deterministic_seed
	_configure_environment()
	_build_terrain()
	_build_trail()
	_build_coastline()
	_build_water()
	_build_rocks_and_elevation()
	_build_cannery_landmark()
	_build_vegetation()

func _profile_settings() -> Dictionary:
	match presentation_profile:
		"PERFORMANCE":
			return {"trees": 105, "shrubs": 60, "grass": 260, "deadfall": 18, "distance": 78.0}
		"QUALITY":
			return {"trees": 230, "shrubs": 140, "grass": 640, "deadfall": 42, "distance": 125.0}
		_:
			return {"trees": 170, "shrubs": 100, "grass": 440, "deadfall": 30, "distance": 100.0}

func _configure_environment() -> void:
	var environment := Environment.new()
	environment.background_mode = Environment.BG_SKY
	var sky := Sky.new()
	var sky_material := ProceduralSkyMaterial.new()
	sky_material.sky_top_color = Color("#183348")
	sky_material.sky_horizon_color = Color("#9eb7bd")
	sky_material.ground_bottom_color = Color("#172126")
	sky_material.ground_horizon_color = Color("#829497")
	sky_material.sun_angle_max = 18.0
	sky_material.sun_curve = 0.08
	sky.material = sky_material
	environment.sky = sky
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_SKY
	environment.ambient_light_energy = 0.72
	environment.reflected_light_source = Environment.REFLECTION_SOURCE_SKY
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.tonemap_exposure = 1.08
	environment.fog_enabled = true
	environment.fog_light_color = Color("#8ea5a6")
	environment.fog_light_energy = 0.72
	environment.fog_density = 0.006
	environment.fog_aerial_perspective = 0.34
	environment.fog_sky_affect = 0.28
	$WorldEnvironment.environment = environment

	var sun := $Sun as DirectionalLight3D
	sun.light_energy = 1.15
	sun.shadow_enabled = true

func _material(color: Color, roughness := 0.82, metallic := 0.0) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = roughness
	material.metallic = metallic
	return material

func _mesh_instance(parent: Node, name: String, mesh: Mesh, material: Material, position := Vector3.ZERO) -> MeshInstance3D:
	var instance := MeshInstance3D.new()
	instance.name = name
	instance.mesh = mesh
	instance.position = position
	instance.material_override = material
	parent.add_child(instance)
	return instance

func _box_mesh(size: Vector3) -> BoxMesh:
	var mesh := BoxMesh.new()
	mesh.size = size
	return mesh

func _cylinder_mesh(top_radius: float, bottom_radius: float, height: float, radial_segments := 8) -> CylinderMesh:
	var mesh := CylinderMesh.new()
	mesh.top_radius = top_radius
	mesh.bottom_radius = bottom_radius
	mesh.height = height
	mesh.radial_segments = radial_segments
	return mesh

func _terrain_height(x: float, z: float) -> float:
	var route_mask := exp(-pow(z / 8.5, 2.0))
	var lowland := (sin(x * 0.09) * cos(z * 0.13) * 0.12) * (1.0 - route_mask)
	var ridge := exp(-pow((x - 54.0) / 24.0, 2.0) - pow((z - 17.0) / 28.0, 2.0)) * 5.0
	ridge *= 1.0 - 0.82 * exp(-pow(z / 7.0, 2.0))
	var creek_cut := exp(-pow((z + 19.0) / 5.0, 2.0) - pow((x - 58.0) / 42.0, 2.0)) * 0.45
	return lowland + ridge - creek_cut

func _build_terrain() -> void:
	var terrain_mesh := ArrayMesh.new()
	var vertices := PackedVector3Array()
	var normals := PackedVector3Array()
	var uvs := PackedVector2Array()
	var indices := PackedInt32Array()
	var x_count := 37
	var z_count := 23
	var step := 5.0
	for z_index in range(z_count):
		var z := -55.0 + float(z_index) * step
		for x_index in range(x_count):
			var x := -70.0 + float(x_index) * step
			vertices.append(Vector3(x, _terrain_height(x, z), z))
			normals.append(Vector3.UP)
			uvs.append(Vector2(float(x_index) / float(x_count - 1), float(z_index) / float(z_count - 1)))
	for z_index in range(z_count - 1):
		for x_index in range(x_count - 1):
			var a := z_index * x_count + x_index
			var b := a + 1
			var c := a + x_count
			var d := c + 1
			indices.append(a)
			indices.append(c)
			indices.append(b)
			indices.append(b)
			indices.append(c)
			indices.append(d)
	var arrays := []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_INDEX] = indices
	terrain_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	terrain_mesh.surface_set_material(0, _material(Color("#4e5145"), 0.96))
	var terrain_mesh_instance := get_node("Region/Cell_0_0/Terrain/TerrainBase/TerrainMesh") as MeshInstance3D
	terrain_mesh_instance.mesh = terrain_mesh
	_terrain_area = 180.0 * 110.0

	var faces := PackedVector3Array()
	for index in indices:
		faces.append(vertices[index])
	var shape := ConcavePolygonShape3D.new()
	shape.set_faces(faces)
	var terrain_collision := get_node("Region/Cell_0_0/Terrain/TerrainBase/TerrainCollision") as CollisionShape3D
	terrain_collision.shape = shape

func _strip_mesh(points: Array[Vector2], width: float, material: Material, y_offset := 0.025) -> ArrayMesh:
	var mesh := ArrayMesh.new()
	var vertices := PackedVector3Array()
	var normals := PackedVector3Array()
	var uvs := PackedVector2Array()
	var indices := PackedInt32Array()
	for i in range(points.size()):
		var point := points[i]
		var previous := points[max(0, i - 1)]
		var following := points[min(points.size() - 1, i + 1)]
		var direction := (following - previous).normalized()
		var side := Vector2(-direction.y, direction.x) * width * 0.5
		for side_sign in [-1.0, 1.0]:
			var edge := point + side * side_sign
			vertices.append(Vector3(edge.x, _terrain_height(edge.x, edge.y) + y_offset, edge.y))
			normals.append(Vector3.UP)
			uvs.append(Vector2(float(i) / float(points.size() - 1), 0.5 + side_sign * 0.5))
	for i in range(points.size() - 1):
		var base := i * 2
		indices.append(base)
		indices.append(base + 2)
		indices.append(base + 1)
		indices.append(base + 1)
		indices.append(base + 2)
		indices.append(base + 3)
	var arrays := []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_INDEX] = indices
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	mesh.surface_set_material(0, material)
	return mesh

func _build_trail() -> void:
	var points: Array[Vector2] = [Vector2(-18, 0), Vector2(-4, 0), Vector2(13, 0), Vector2(29, 1), Vector2(40, 5), Vector2(49, 12), Vector2(54, 18)]
	var trail := get_node("Region/Cell_0_0/Dressing/Trail") as MeshInstance3D
	trail.mesh = _strip_mesh(points, 3.2, _material(Color("#7b705c"), 0.96), 0.045)
	var clearing := get_node("Region/Cell_0_0/Dressing/Clearing") as MeshInstance3D
	clearing.mesh = _box_mesh(Vector3(24.0, 0.06, 18.0))
	clearing.position = Vector3(48.0, _terrain_height(48.0, 0.0) + 0.02, 0.0)
	clearing.material_override = _material(Color("#6a715c"), 0.92)

func _build_coastline() -> void:
	var dressing := get_node("Region/Cell_0_0/Dressing")
	var points: Array[Vector2] = [Vector2(-68, -37), Vector2(-48, -30), Vector2(-25, -33), Vector2(-2, -29), Vector2(20, -34)]
	var sea_material := _material(Color(0.12, 0.28, 0.35, 0.82), 0.2, 0.1)
	sea_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	sea_material.cull_mode = BaseMaterial3D.CULL_DISABLED
	var sea := _mesh_instance(dressing, "CoastlineWater", _strip_mesh(points, 13.0, sea_material, -0.18), sea_material)
	sea.position.y = -0.01
	var shore_material := _material(Color("#8a816e"), 0.98)
	var shore := _mesh_instance(dressing, "StrandShoreline", _strip_mesh(points, 3.0, shore_material, 0.02), shore_material)
	shore.position.y = 0.02

func _build_water() -> void:
	var points: Array[Vector2] = []
	for i in range(11):
		var x := 32.0 + float(i) * 5.2
		points.append(Vector2(x, -19.0 + sin(x * 0.12) * 2.4))
	var water := get_node("Region/Cell_0_0/Water") as MeshInstance3D
	var water_material := _material(Color(0.16, 0.36, 0.43, 0.78), 0.16, 0.12)
	water_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	water_material.cull_mode = BaseMaterial3D.CULL_DISABLED
	water.mesh = _strip_mesh(points, 4.4, water_material, -0.06)
	_water_present = true
	var wet_material := _material(Color("#46564b"), 1.0)
	var dressing := get_node("Region/Cell_0_0/Dressing")
	for i in range(8):
		var x := 34.0 + float(i) * 6.0
		var z := -19.0 + sin(x * 0.12) * 2.4
		var bank := _box_mesh(Vector3(5.2, 0.08, 1.5))
		var bank_instance := _mesh_instance(dressing, "WetBank%02d" % i, bank, wet_material, Vector3(x, _terrain_height(x, z) + 0.025, z + 2.6))
		bank_instance.rotation.y = sin(x) * 0.08

func _add_rock(parent: Node, index: int, position: Vector3, scale: Vector3) -> void:
	var body := StaticBody3D.new()
	body.name = "RockCollision%02d" % index
	body.collision_layer = 1
	body.collision_mask = 0
	body.position = position
	parent.add_child(body)
	var mesh := SphereMesh.new()
	mesh.radius = 1.0
	mesh.height = 2.0
	mesh.radial_segments = 8
	mesh.rings = 4
	var rock_material := _material(Color("#656761"), 0.94)
	var visual := _mesh_instance(body, "Rock%02d" % index, mesh, rock_material)
	visual.scale = scale
	var collision := CollisionShape3D.new()
	var sphere := SphereShape3D.new()
	sphere.radius = 1.0
	collision.shape = sphere
	body.add_child(collision)

func _build_rocks_and_elevation() -> void:
	var dressing := get_node("Region/Cell_0_0/Dressing")
	var rock_data := [
		[Vector3(36.0, _terrain_height(36.0, 9.0) + 0.65, 9.0), Vector3(2.6, 1.2, 1.8)],
		[Vector3(43.0, _terrain_height(43.0, 15.0) + 0.9, 15.0), Vector3(3.3, 1.8, 2.5)],
		[Vector3(51.0, _terrain_height(51.0, 25.0) + 1.0, 25.0), Vector3(3.8, 2.0, 2.6)],
		[Vector3(61.0, _terrain_height(61.0, 8.0) + 0.7, 8.0), Vector3(2.2, 1.4, 2.6)],
		[Vector3(70.0, _terrain_height(70.0, -4.0) + 0.55, -4.0), Vector3(2.0, 1.1, 1.6)],
		[Vector3(88.0, _terrain_height(88.0, 20.0) + 0.8, 20.0), Vector3(3.0, 1.6, 2.1)],
		[Vector3(20.0, _terrain_height(20.0, -13.0) + 0.6, -13.0), Vector3(2.5, 1.2, 1.8)],
	]
	for i in range(rock_data.size()):
		_add_rock(dressing, i, rock_data[i][0], rock_data[i][1])

func _build_cannery_landmark() -> void:
	var dressing := get_node("Region/Cell_0_0/Dressing")
	var roof_material := _material(Color("#2c3639"), 0.74, 0.12)
	var rust_material := _material(Color("#7c5138"), 0.78, 0.18)
	_mesh_instance(dressing, "CanneryRoofLandmark", _box_mesh(Vector3(18.0, 0.45, 11.0)), roof_material, Vector3(22.0, 5.0, 0.0))
	var stack := _mesh_instance(dressing, "CanneryStackLandmark", _cylinder_mesh(0.48, 0.62, 7.0, 12), rust_material, Vector3(27.5, 7.8, -2.0))
	stack.rotation_degrees = Vector3(0, 0, 2.0)
	var tank := _mesh_instance(dressing, "CanneryTankLandmark", _cylinder_mesh(1.25, 1.25, 3.4, 16), _material(Color("#56666a"), 0.58, 0.34), Vector3(29.2, 1.7, 3.0))
	tank.rotation_degrees = Vector3(0, 0, 90.0)
	var sign := Label3D.new()
	sign.name = "CanneryLandmarkSign"
	sign.text = "G Y L E   C A N N E R Y"
	sign.font_size = 32
	sign.pixel_size = 0.004
	sign.modulate = Color("#e1c18a")
	sign.outline_size = 8
	sign.outline_modulate = Color("#20282a")
	sign.position = Vector3(22.0, 4.2, -5.55)
	sign.rotation_degrees = Vector3(0, 180, 0)
	dressing.add_child(sign)

func _multi_mesh_instance(parent: Node, name: String, mesh: Mesh, transforms: Array[Transform3D], distance: float) -> MultiMeshInstance3D:
	var multimesh := MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.mesh = mesh
	multimesh.instance_count = transforms.size()
	for i in range(transforms.size()):
		multimesh.set_instance_transform(i, transforms[i])
	var instance := MultiMeshInstance3D.new()
	instance.name = name
	instance.multimesh = multimesh
	instance.visibility_range_end = distance
	instance.visibility_range_end_margin = 12.0
	instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	parent.add_child(instance)
	_vegetation_count += transforms.size()
	return instance

func _can_place_foliage(x: float, z: float) -> bool:
	if absf(z) < 7.0 and x < 38.0:
		return false
	if Vector2(x, z).distance_to(Vector2(22.0, 0.0)) < 14.0:
		return false
	if x > 30.0 and absf(z + 19.0) < 6.5:
		return false
	return true

func _build_vegetation() -> void:
	var settings := _profile_settings()
	var parent := get_node("Region/Cell_0_0/Dressing/Vegetation")
	var tree_transforms: Array[Transform3D] = []
	var trunk_transforms: Array[Transform3D] = []
	for _i in range(int(settings["trees"])):
		var x := _rng.randf_range(-60.0, 102.0)
		var z := _rng.randf_range(-48.0, 52.0)
		if not _can_place_foliage(x, z):
			continue
		var scale := _rng.randf_range(0.8, 1.35)
		var height := _terrain_height(x, z)
		var tree_transform := Transform3D(Basis.IDENTITY.scaled(Vector3(scale, scale, scale)), Vector3(x, height + 3.0 * scale, z))
		tree_transforms.append(tree_transform)
		trunk_transforms.append(Transform3D(Basis.IDENTITY.scaled(Vector3(scale, scale, scale)), Vector3(x, height + 1.1 * scale, z)))
	var cone := _cylinder_mesh(0.05, 1.15, 5.8, 8)
	_multi_mesh_instance(parent, "ConiferCanopies_MultiMesh", cone, tree_transforms, float(settings["distance"]))
	var trunk := _cylinder_mesh(0.16, 0.22, 2.2, 7)
	_multi_mesh_instance(parent, "ConiferTrunks_MultiMesh", trunk, trunk_transforms, float(settings["distance"]))

	var shrub_transforms: Array[Transform3D] = []
	for _i in range(int(settings["shrubs"])):
		var x := _rng.randf_range(-58.0, 105.0)
		var z := _rng.randf_range(-50.0, 54.0)
		if not _can_place_foliage(x, z):
			continue
		var scale := _rng.randf_range(0.55, 1.25)
		shrub_transforms.append(Transform3D(Basis.IDENTITY.scaled(Vector3(scale * 1.2, scale, scale)), Vector3(x, _terrain_height(x, z) + 0.55 * scale, z)))
	var shrub_mesh := SphereMesh.new()
	shrub_mesh.radius = 0.8
	shrub_mesh.height = 1.0
	shrub_mesh.radial_segments = 8
	shrub_mesh.rings = 4
	_multi_mesh_instance(parent, "Shrubs_MultiMesh", shrub_mesh, shrub_transforms, float(settings["distance"]) * 0.85)

	var grass_transforms: Array[Transform3D] = []
	for _i in range(int(settings["grass"])):
		var x := _rng.randf_range(-65.0, 106.0)
		var z := _rng.randf_range(-52.0, 56.0)
		if not _can_place_foliage(x, z):
			continue
		var scale := _rng.randf_range(0.5, 1.4)
		grass_transforms.append(Transform3D(Basis.IDENTITY.scaled(Vector3(scale, scale, scale)), Vector3(x, _terrain_height(x, z) + 0.18 * scale, z)))
	var grass_mesh := _cylinder_mesh(0.02, 0.12, 0.36, 5)
	_multi_mesh_instance(parent, "GroundCover_MultiMesh", grass_mesh, grass_transforms, float(settings["distance"]) * 0.72)

	var deadfall_transforms: Array[Transform3D] = []
	for _i in range(int(settings["deadfall"])):
		var x := _rng.randf_range(24.0, 98.0)
		var z := _rng.randf_range(-46.0, 48.0)
		if not _can_place_foliage(x, z):
			continue
		var scale := _rng.randf_range(0.7, 1.5)
		var basis := Basis(Vector3(0, 0, 1), _rng.randf_range(-0.45, 0.45)).scaled(Vector3(scale, scale, scale))
		deadfall_transforms.append(Transform3D(basis, Vector3(x, _terrain_height(x, z) + 0.22, z)))
	var deadfall_mesh := _cylinder_mesh(0.16, 0.2, 3.0, 7)
	_multi_mesh_instance(parent, "Deadfall_MultiMesh", deadfall_mesh, deadfall_transforms, float(settings["distance"]) * 0.9)

func debug_line() -> String:
	return "VISUAL: %s | cell=250m envelope=500x250 | terrain=%.0fm2 | elevation=5m | vegetation=%d | water=%s" % [presentation_profile, _terrain_area, _vegetation_count, "creek" if _water_present else "none"]
