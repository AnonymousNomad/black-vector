extends Node3D

const PG := preload("res://scripts/world/presentation_geometry.gd")

var _wood: ShaderMaterial
var _rock: ShaderMaterial
var _cloth: StandardMaterial3D
var _metal: StandardMaterial3D
var _mud: ShaderMaterial

func _ready() -> void:
	_wood = PG.textured_material("wood", Color("#463a2e"), Color("#725d44"), 0.93, 0.0)
	_rock = PG.textured_material("concrete", Color("#424b4d"), Color("#66645a"), 0.94, 0.0)
	_mud = PG.textured_material("concrete", Color("#302d27"), Color("#5c5140"), 0.98, 0.0)
	_cloth = PG.material(Color("#353d39"), 0.96, 0.0)
	_cloth.cull_mode = BaseMaterial3D.CULL_DISABLED
	_metal = PG.material(Color("#6a553c"), 0.82, 0.34)
	call_deferred("_dress_strand")

func _dress_strand() -> void:
	var floor_body := get_node_or_null("StrandFloor") as StaticBody3D
	if floor_body:
		floor_body.collision_layer = 0
		floor_body.collision_mask = 0
	var floor_mesh := get_node_or_null("StrandFloor/MeshInstance3D") as MeshInstance3D
	if floor_mesh:
		floor_mesh.visible = false
	for node in find_children("*", "StaticBody3D", true, false):
		if node is GrayboxBlock:
			var visual := node.get_node_or_null("MeshInstance3D") as MeshInstance3D
			if visual:
				visual.visible = false
	_build_boulder("ClimbBlock")
	_build_crate("Crate01")
	_build_medical_pouch("Supply01")
	_build_trace_marker("Damage01", "DAMAGE")
	_build_trace_marker("Trail01", "FOOTPRINTS")
	_build_trace_marker("Weather01", "WEATHER")
	_build_trace_marker("Disturbed01", "DISTURBED")
	_build_lean_to()
	_build_rest_site()
	_build_survey_point()
	_build_evidence_marker()
	_build_concealment()

func _box(parent: Node, name: String, size: Vector3, position: Vector3, material: Material, bevel := 0.035, rotation := Vector3.ZERO) -> MeshInstance3D:
	var instance := PG.add_mesh(parent, name, PG.rounded_box_mesh(size, bevel, 3), material, position)
	instance.rotation = rotation
	return instance

func _beam(parent: Node, name: String, from: Vector3, to: Vector3, radius: float, material: Material) -> MeshInstance3D:
	return PG.beam(parent, name, from, to, radius, material)

func _sphere(parent: Node, name: String, radius: float, position: Vector3, scale: Vector3, material: Material) -> MeshInstance3D:
	var instance := PG.add_mesh(parent, name, PG.sphere_mesh(radius, 18, 12), material, position)
	instance.scale = scale
	return instance

func _build_boulder(node_name: String) -> void:
	var body := get_node_or_null(node_name) as GrayboxBlock
	if body == null:
		return
	var stone := _sphere(body, "GlacialBoulder", 0.5, Vector3(0.0, 0.0, 0.0), Vector3(1.65, 1.15, 1.42), _rock)
	stone.rotation_degrees = Vector3(-6.0, 29.0, 7.0)
	for index in range(4):
		var flake := _sphere(body, "RockSpall", 0.22, Vector3(-0.34 + float(index) * 0.22, -0.28, 0.18 + 0.06 * float(index % 2)), Vector3(0.68, 0.24, 0.54), _mud)
		flake.rotation.z = 0.12 * float(index - 1)

func _build_crate(node_name: String) -> void:
	var body := get_node_or_null(node_name) as GrayboxBlock
	if body == null:
		return
	var size := body.block_size
	var width := maxf(0.42, size.x)
	var height := maxf(0.42, size.y)
	var depth := maxf(0.42, size.z)
	_box(body, "CrateDarkCore", Vector3(width * 0.88, height * 0.82, depth * 0.88), Vector3.ZERO, _mud, 0.05)
	for y in [-height * 0.3, 0.0, height * 0.3]:
		_box(body, "FrontCrateBoard", Vector3(width * 0.94, height * 0.21, 0.065), Vector3(0, y, -depth * 0.47), _wood, 0.025)
		_box(body, "RearCrateBoard", Vector3(width * 0.94, height * 0.21, 0.065), Vector3(0, y, depth * 0.47), _wood, 0.025)
	for x in [-width * 0.47, width * 0.47]:
		for z in [-depth * 0.47, depth * 0.47]:
			_beam(body, "CrateOakCorner", Vector3(x, -height * 0.46, z), Vector3(x, height * 0.46, z), 0.03, _wood)
	_box(body, "CrateLid", Vector3(width * 0.98, 0.07, depth * 0.98), Vector3(0, height * 0.46, 0), _wood, 0.035)
	for x in [-width * 0.35, 0, width * 0.35]:
		_sphere(body, "CrateNail", 0.015, Vector3(x, height * 0.51, -depth * 0.49), Vector3.ONE, _metal)

func _build_medical_pouch(node_name: String) -> void:
	var body := get_node_or_null(node_name) as GrayboxBlock
	if body == null:
		return
	var bag_material := PG.material(Color("#77745d"), 0.96, 0.0)
	var bag := _sphere(body, "DampMedicalRoll", 0.42, Vector3(0, -0.04, 0), Vector3(0.98, 0.66, 0.78), bag_material)
	bag.rotation.z = 0.13
	_box(body, "PouchFlap", Vector3(0.34, 0.10, 0.37), Vector3(0, 0.14, -0.22), bag_material, 0.045, Vector3(0.11, 0, 0))
	_beam(body, "PouchShoulderStrap", Vector3(-0.32, -0.02, 0.12), Vector3(0.32, 0.07, 0.12), 0.026, _wood)
	_box(body, "OldHospitalStencil", Vector3(0.17, 0.035, 0.04), Vector3(0, 0.03, -0.30), PG.material(Color("#a39a78"), 0.9), 0.012)
	for side in [-1.0, 1.0]:
		_beam(body, "TornPouchSeam", Vector3(side * 0.38, -0.12, -0.1), Vector3(side * 0.32, 0.13, -0.1), 0.012, _wood)

func _build_trace_marker(node_name: String, kind: String) -> void:
	var body := get_node_or_null(node_name) as GrayboxBlock
	if body == null:
		return
	var marker := Node3D.new()
	marker.name = "GroundEvidence_%s" % kind
	marker.position.y = -body.block_size.y * 0.43
	body.add_child(marker)
	var palette := {
		"DAMAGE": Color("#704234"),
		"FOOTPRINTS": Color("#565147"),
		"WEATHER": Color("#879493"),
		"DISTURBED": Color("#403b32"),
	}.get(kind, Color("#5c5140")) as Color
	var material := PG.material(palette, 0.99, 0.0)
	for index in range(5):
		var x := -0.52 + float(index) * 0.25
		var z := sin(float(index) * 1.6) * 0.19
		var width := 0.18 + 0.04 * float(index % 3)
		var stamp := _sphere(marker, "SurfaceTraceStamp", 0.5, Vector3(x, 0.015 + 0.003 * float(index % 2), z), Vector3(width, 0.018, width * 0.64), material)
		stamp.rotation.y = float(index) * 0.41
	for index in range(3):
		var debris := _sphere(marker, "TraceDebris", 0.13, Vector3(-0.42 + index * 0.41, 0.045, 0.36 - 0.12 * float(index % 2)), Vector3(1.1, 0.5, 0.72), _rock if kind != "WEATHER" else _cloth)
		debris.rotation.z = float(index - 1) * 0.18

func _build_lean_to() -> void:
	var body := get_node_or_null("TemporaryCover") as GrayboxBlock
	if body == null:
		return
	var tarp_material := PG.material(Color("#343b36"), 0.94, 0.0)
	tarp_material.cull_mode = BaseMaterial3D.CULL_DISABLED
	var points := PackedVector3Array([
		Vector3(-1.52, -0.28, -1.42), Vector3(1.52, -0.28, -1.42), Vector3(-1.52, 0.0, 1.42),
		Vector3(1.52, -0.28, -1.42), Vector3(1.52, 0.0, 1.42), Vector3(-1.52, 0.0, 1.42),
	])
	var mesh := ArrayMesh.new()
	var arrays := []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = points
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	PG.add_mesh(body, "PitchedWeatherTarp", mesh, tarp_material, Vector3(0, -0.15, 0))
	for x in [-1.28, 1.28]:
		for z in [-1.2, 1.2]:
			_beam(body, "LeanToSupport", Vector3(x, -2.06, z), Vector3(x * 0.9, -0.1 if z > 0 else -0.38, z * 0.9), 0.045, _wood)
	for z in [-1.1, 1.1]:
		_beam(body, "LeanToRidgePole", Vector3(-1.3, -0.18, z), Vector3(1.3, -0.18, z), 0.045, _wood)
	for x in [-1.2, 1.2]:
		_beam(body, "TarpGuyline", Vector3(x, -0.2, 1.05), Vector3(x * 1.23, -2.08, 1.56), 0.012, _metal)

func _build_rest_site() -> void:
	var body := get_node_or_null("RestSite01") as GrayboxBlock
	if body == null:
		return
	var bedroll := _sphere(body, "DampWoolBedroll", 0.5, Vector3(0, -0.07, 0), Vector3(1.2, 0.23, 0.77), _cloth)
	bedroll.rotation.y = -0.12
	_box(body, "BedrollStrap", Vector3(1.0, 0.045, 0.07), Vector3(0, 0.08, 0), _metal, 0.018)
	var soot := _sphere(body, "ColdFireSoot", 0.62, Vector3(0, -0.18, -0.68), Vector3(1.1, 0.02, 0.75), _mud)
	soot.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	for index in range(9):
		var angle := TAU * float(index) / 9.0
		var stone := _sphere(body, "ColdFireRingStone", 0.14 + 0.025 * float(index % 2), Vector3(cos(angle) * 0.67, -0.10, -0.68 + sin(angle) * 0.46), Vector3(1.2, 0.78, 0.9), _rock)
		stone.rotation.y = angle
	for index in range(3):
		_beam(body, "AshColdKindling", Vector3(-0.25, -0.07, -0.68), Vector3(0.28, -0.07, -0.68), 0.035, _wood)

func _build_survey_point() -> void:
	var body := get_node_or_null("SurveyPoint01") as GrayboxBlock
	if body == null:
		return
	for angle in [0.0, TAU / 3.0, TAU * 2.0 / 3.0]:
		_beam(body, "SurveyTripodLeg", Vector3(0, 0.16, 0), Vector3(cos(angle) * 0.44, -0.24, sin(angle) * 0.44), 0.027, _wood)
	_box(body, "TripodInstrumentBody", Vector3(0.38, 0.2, 0.3), Vector3(0, 0.16, 0), _metal, 0.075)
	_sphere(body, "CompassLens", 0.095, Vector3(0, 0.28, -0.08), Vector3(1.0, 0.22, 0.82), PG.material(Color("#87928a"), 0.24, 0.25))
	_beam(body, "AntennaStem", Vector3(0.12, 0.24, 0.1), Vector3(0.12, 0.58, 0.1), 0.012, _metal)
	_sphere(body, "AntennaTip", 0.035, Vector3(0.12, 0.61, 0.1), Vector3.ONE, _rock)

func _build_evidence_marker() -> void:
	var body := get_node_or_null("Evidence01") as GrayboxBlock
	if body == null:
		return
	var swab := _box(body, "BloodSwabPacket", Vector3(0.42, 0.07, 0.24), Vector3(0, -0.14, 0), PG.material(Color("#a39b80"), 0.88), 0.045, Vector3(0, 0, 0.08))
	swab.rotation.y = -0.19
	var cap := _sphere(body, "SwabTubeCap", 0.05, Vector3(-0.2, -0.08, 0), Vector3(0.45, 0.45, 1.2), _metal)
	cap.rotation.z = 0.3
	_box(body, "WaterproofEvidenceTag", Vector3(0.28, 0.018, 0.16), Vector3(0.17, -0.08, 0.10), _wood, 0.02)

func _build_concealment() -> void:
	var body := get_node_or_null("Conceal01") as GrayboxBlock
	if body == null:
		return
	var frond_material := PG.material(Color("#46513c"), 0.97)
	for index in range(13):
		var angle := TAU * float(index) / 13.0
		var base := Vector3(0, -0.38, 0)
		var tip := Vector3(cos(angle) * 0.95, 0.18 + 0.24 * float(index % 4), sin(angle) * 0.95)
		_beam(body, "SpruceBoughStem", base, tip, 0.028, _wood)
		for side in [-1.0, 1.0]:
			var branch := tip.lerp(base, 0.38) + Vector3(-sin(angle) * side * 0.24, 0.08, cos(angle) * side * 0.24)
			_beam(body, "BoughNeedleSprig", tip.lerp(base, 0.48), branch, 0.017, frond_material)
	for index in range(5):
		var leaf := _sphere(body, "MattedSpruceCover", 0.48, Vector3(-0.58 + 0.29 * index, -0.15 + 0.12 * float(index % 2), -0.18), Vector3(0.72, 0.48, 0.8), frond_material)
		leaf.rotation.y = index * 0.55
