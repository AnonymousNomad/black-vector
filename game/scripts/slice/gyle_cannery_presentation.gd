extends Node3D

const PG := preload("res://scripts/world/presentation_geometry.gd")

var _steel: ShaderMaterial
var _rust: ShaderMaterial
var _wood: ShaderMaterial
var _concrete: ShaderMaterial
var _glass: StandardMaterial3D
var _rubber: StandardMaterial3D
var _inside: StandardMaterial3D
var _trim: Material

func _ready() -> void:
	_steel = PG.textured_material("steel", Color("#35464a"), Color("#576260"), 0.72, 0.44)
	_rust = PG.textured_material("steel", Color("#693f2c"), Color("#8a5b3c"), 0.82, 0.26)
	_wood = PG.textured_material("wood", Color("#514539"), Color("#78644d"), 0.91, 0.0)
	_concrete = PG.textured_material("concrete", Color("#43494a"), Color("#62615a"), 0.94, 0.0)
	_glass = PG.material(Color("#293c42"), 0.25, 0.18)
	_glass.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	_glass.albedo_color.a = 0.72
	_glass.cull_mode = BaseMaterial3D.CULL_DISABLED
	_rubber = PG.material(Color("#202726"), 0.96, 0.0)
	_inside = PG.material(Color("#1f2829"), 0.95, 0.0)
	_trim = PG.textured_material("steel", Color("#273338"), Color("#414d4d"), 0.82, 0.38)
	call_deferred("_build_presentation")

func _build_presentation() -> void:
	var pad_body := get_node_or_null("CanneryPad") as StaticBody3D
	if pad_body:
		pad_body.collision_layer = 0
		pad_body.collision_mask = 0
	var pad := get_node_or_null("CanneryPad/MeshInstance3D") as MeshInstance3D
	if pad:
		pad.visible = false
	for node in find_children("*", "StaticBody3D", true, false):
		if node is GrayboxBlock:
			var block := node as GrayboxBlock
			var mesh := block.get_node_or_null("MeshInstance3D") as MeshInstance3D
			if mesh:
				mesh.visible = false
	_build_shell()
	_build_door()
	_build_windows()
	_build_exterior_stories()
	_build_interiors()
	_build_machinery()
	_build_vat("Vat01", Color("#566263"))
	_build_vat("Vat02", Color("#4d5d60"))
	_build_crate("CollectCrateF1")
	_build_crate("CrateStack02", 1.15)
	_build_gate()
	_build_conveyor()
	_build_switch()
	_build_fuel_cache()
	_build_approach_cover()
	_build_sign()

func _box(parent: Node, name: String, size: Vector3, position: Vector3, material: Material, bevel := 0.035, rotation := Vector3.ZERO) -> MeshInstance3D:
	var instance := PG.add_mesh(parent, name, PG.rounded_box_mesh(size, bevel, 3), material, position)
	instance.rotation = rotation
	return instance

func _sphere(parent: Node, name: String, radius: float, position: Vector3, scale := Vector3.ONE, material: Material = null) -> MeshInstance3D:
	var instance := PG.add_mesh(parent, name, PG.sphere_mesh(radius, 16, 10), material if material else _steel, position)
	instance.scale = scale
	return instance

func _pipe(parent: Node, name: String, from: Vector3, to: Vector3, radius: float, material: Material) -> MeshInstance3D:
	return PG.beam(parent, name, from, to, radius, material)

func _panel(parent: Node, name: String, width: float, height: float, position: Vector3, rotation: Vector3, material: Material) -> MeshInstance3D:
	var mesh := PG.corrugated_panel(width, height, 0.026, 0.34)
	var instance := PG.add_mesh(parent, name, mesh, material, position)
	instance.rotation = rotation
	instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
	return instance

func _build_shell() -> void:
	var shell := Node3D.new()
	shell.name = "AuthoredCanneryShell"
	add_child(shell)
	# The low stone skirt lifts weathered sheet-metal cladding clear of standing water.
	_box(shell, "NorthConcreteFooting", Vector3(15.4, 0.52, 0.66), Vector3(0, 0.22, 4.95), _concrete, 0.08)
	_box(shell, "SouthConcreteFooting", Vector3(15.4, 0.52, 0.66), Vector3(0, 0.22, -4.95), _concrete, 0.08)
	_box(shell, "BackConcreteFooting", Vector3(0.66, 0.52, 9.8), Vector3(7.55, 0.22, 0), _concrete, 0.08)
	_panel(shell, "NorthRibbedSiding", 15.0, 4.45, Vector3(0, 0.48, 4.86), Vector3.ZERO, _steel)
	_panel(shell, "SouthRibbedSiding", 15.0, 4.45, Vector3(0, 0.48, -4.86), Vector3(0, PI, 0), _steel)
	_panel(shell, "RearRibbedSiding", 9.65, 4.45, Vector3(7.52, 0.48, 0), Vector3(0, PI * 0.5, 0), _steel)
	# The entry facade remains open at the center so the existing hinged leaf controls access.
	_panel(shell, "FrontRibbedSidingLeft", 3.22, 4.45, Vector3(-7.52, 0.48, -3.32), Vector3(0, PI * 0.5, 0), _steel)
	_panel(shell, "FrontRibbedSidingRight", 3.22, 4.45, Vector3(-7.52, 0.48, 3.32), Vector3(0, PI * 0.5, 0), _steel)
	_panel(shell, "FrontDoorHeader", 3.25, 1.23, Vector3(-7.52, 3.69, 0), Vector3(0, PI * 0.5, 0), _trim)
	_build_gables(shell)
	_build_roof(shell)
	_build_frame_posts(shell)
	_build_drainage(shell)
	# An interior lining gives the doorway real depth and eats light toward the rear bay.
	var floor_material := PG.material(Color("#303737"), 0.93, 0.0)
	var floor := PlaneMesh.new()
	floor.size = Vector2(14.9, 9.4)
	PG.add_mesh(shell, "ScoredConcreteInteriorFloor", floor, floor_material, Vector3(0, 0.504, 0))
	var ceiling := _box(shell, "SootDarkCeiling", Vector3(14.8, 0.12, 9.2), Vector3(0, 4.78, 0), _inside, 0.025)
	ceiling.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

func _build_gables(parent: Node) -> void:
	var surface := SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for x in [-7.48, 7.48]:
		var outward := -1.0 if x < 0.0 else 1.0
		var points := [Vector3(x, 4.82, -4.83), Vector3(x, 4.82, 4.83), Vector3(x, 6.28, 0.0)]
		if outward < 0.0:
			surface.add_vertex(points[0]); surface.add_vertex(points[1]); surface.add_vertex(points[2])
		else:
			surface.add_vertex(points[0]); surface.add_vertex(points[2]); surface.add_vertex(points[1])
		var inside_points := [Vector3(x - outward * 0.06, 4.82, -4.83), Vector3(x - outward * 0.06, 4.82, 4.83), Vector3(x - outward * 0.06, 6.28, 0.0)]
		if outward < 0.0:
			surface.add_vertex(inside_points[2]); surface.add_vertex(inside_points[1]); surface.add_vertex(inside_points[0])
		else:
			surface.add_vertex(inside_points[1]); surface.add_vertex(inside_points[2]); surface.add_vertex(inside_points[0])
	surface.index()
	surface.generate_normals()
	PG.add_mesh(parent, "WeatheredGableEnds", surface.commit(), _steel)
	for x in [-7.56, 7.56]:
		for z in [-3.9, -2.6, -1.3, 0.0, 1.3, 2.6, 3.9]:
			var top_y := 6.25 - absf(z) * 0.29
			_pipe(parent, "GableStiffener", Vector3(x, 4.78, z), Vector3(x, top_y, z), 0.035, _trim)

func _build_roof(parent: Node) -> void:
	for sign: float in [-1.0, 1.0]:
		var mesh := ArrayMesh.new()
		var surface := SurfaceTool.new()
		surface.begin(Mesh.PRIMITIVE_TRIANGLES)
		var steps_x := 24
		var steps_z := 10
		for row in range(steps_z + 1):
			var t := float(row) / float(steps_z)
			var z := sign * t * 5.22
			var y := 6.30 - t * 1.52
			for column in range(steps_x + 1):
				var u := float(column) / float(steps_x)
				var x := lerpf(-7.78, 7.78, u)
				var rib := sin(t * 5.22 * TAU / 0.43) * 0.018
				surface.set_uv(Vector2(u * 15.56, t * 5.5))
				surface.add_vertex(Vector3(x, y + rib, z))
		for row in range(steps_z):
			for column in range(steps_x):
				var a := row * (steps_x + 1) + column
				var b := a + 1
				var c := a + steps_x + 1
				var d := c + 1
				surface.add_index(a)
				surface.add_index(b)
				surface.add_index(c)
				surface.add_index(b)
				surface.add_index(d)
				surface.add_index(c)
		surface.index()
		surface.generate_normals()
		mesh = surface.commit()
		var roof := PG.add_mesh(parent, "StandingSeamRoof_%s" % ["North" if sign > 0.0 else "South"], mesh, _trim)
		roof.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
		for rib in range(27):
			var x := lerpf(-7.65, 7.65, float(rib) / 26.0)
			_pipe(parent, "RoofStandingSeam", Vector3(x, 6.31, 0), Vector3(x, 4.80, sign * 5.2), 0.027, _steel)
		for x in [-6.5, -3.2, 0.0, 3.2, 6.5]:
			_pipe(parent, "ExposedRafter", Vector3(x, 4.62, -4.8), Vector3(x, 6.14, 0), 0.085, _wood)
			_pipe(parent, "ExposedRafter", Vector3(x, 6.14, 0), Vector3(x, 4.62, 4.8), 0.085, _wood)
	var ridge := _pipe(parent, "RidgeCap", Vector3(-7.9, 6.27, 0), Vector3(7.9, 6.27, 0), 0.11, _trim)
	ridge.rotation.x = PI * 0.5
	for x in [-8.0, -4.0, 0.0, 4.0, 8.0]:
		_box(parent, "RustStainedRoofPatch", Vector3(0.55, 0.025, 0.42), Vector3(x, 5.12 + sin(x) * 0.4, 3.1 + sin(x * 0.6)), _rust, 0.08)
	# The flue is a seam-built stack, not a primitive cylinder.
	_pipe(parent, "CanneryExhaustFlue", Vector3(4.6, 5.0, -1.1), Vector3(4.6, 7.6, -1.1), 0.34, _rust)
	for y in [5.2, 6.1, 7.0, 7.54]:
		_pipe(parent, "ExhaustFlueCollar", Vector3(4.6, y, -1.1), Vector3(4.6, y + 0.065, -1.1), 0.39, _trim)
	_box(parent, "FlueRainCap", Vector3(0.9, 0.12, 0.9), Vector3(4.6, 7.68, -1.1), _rust, 0.12)

func _build_frame_posts(parent: Node) -> void:
	for x in [-7.2, -4.8, -2.4, 0.0, 2.4, 4.8, 7.2]:
		for z in [-4.70, 4.70]:
			_pipe(parent, "TimberWallPost", Vector3(x, 0.48, z), Vector3(x, 4.7, z), 0.075, _wood)
	for z in [-4.65, 4.65]:
		_pipe(parent, "WallTopPlate", Vector3(-7.45, 4.75, z), Vector3(7.45, 4.75, z), 0.085, _wood)

func _build_drainage(parent: Node) -> void:
	for z in [-5.0, 5.0]:
		_pipe(parent, "GutterRun", Vector3(-7.8, 4.62, z), Vector3(7.8, 4.62, z), 0.06, _trim)
		for x in [-6.8, 6.8]:
			_pipe(parent, "Downspout", Vector3(x, 4.6, z), Vector3(x, 0.45, z), 0.047, _rust)
			_box(parent, "DrainElbow", Vector3(0.21, 0.16, 0.19), Vector3(x, 0.37, z), _rust, 0.04)
			var splash := PG.add_mesh(parent, "DownspoutSplashStone", PG.rounded_box_mesh(Vector3(0.7, 0.035, 0.46), 0.015), _concrete, Vector3(x, 0.035, z + signf(z) * 0.38))
			splash.rotation.y = 0.22 * signf(x)

func _build_door() -> void:
	var door_mesh := get_node_or_null("EntryDoor/MeshInstance3D") as MeshInstance3D
	if door_mesh == null:
		return
	door_mesh.mesh = PG.rounded_box_mesh(Vector3(0.42, 2.95, 2.94), 0.07, 3)
	door_mesh.material_override = _wood
	for index in range(7):
		var z := lerpf(-1.34, 1.34, float(index) / 6.0)
		_pipe(door_mesh, "DoorVerticalPlankSeam", Vector3(0.23, -1.40, z), Vector3(0.23, 1.40, z), 0.025, _trim)
	for y in [-1.22, 0.0, 1.22]:
		_box(door_mesh, "DoorBrace", Vector3(0.07, 0.17, 2.72), Vector3(0.26, y, 0), _trim, 0.035)
	_pipe(door_mesh, "DoorDiagonalBrace", Vector3(0.31, -1.2, -1.25), Vector3(0.31, 1.2, 1.25), 0.052, _trim)
	_pipe(door_mesh, "DoorDiagonalBrace", Vector3(0.31, -1.2, 1.25), Vector3(0.31, 1.2, -1.25), 0.052, _trim)
	_box(door_mesh, "WornDoorKickPlate", Vector3(0.055, 0.36, 2.35), Vector3(0.30, -1.15, 0), _rust, 0.025)
	_box(door_mesh, "DoorLatchHousing", Vector3(0.09, 0.42, 0.23), Vector3(0.33, 0.10, -1.10), _rust, 0.04)
	_pipe(door_mesh, "DoorPullHandle", Vector3(0.39, 0.18, -1.13), Vector3(0.39, 0.45, -1.13), 0.025, _trim)

func _build_windows() -> void:
	for z_sign in [-1.0, 1.0]:
		for index in range(5):
			var x := -5.9 + float(index) * 2.95
			_build_window(NodePath("."), "SideWindow_%s_%d" % ["North" if z_sign > 0.0 else "South", index], Vector3(x, 2.8, z_sign * 4.95), Vector3(1.1, 0.92, 0.09), Vector3(0, 0, 0))
	# The front transom leaks just enough cold light into the entry bay.
	_build_window(NodePath("."), "EntryTransom", Vector3(-7.55, 4.29, 0), Vector3(2.65, 0.38, 0.08), Vector3(0, PI * 0.5, 0))

func _build_window(_path: NodePath, name: String, position: Vector3, size: Vector3, rotation: Vector3) -> void:
	var frame := Node3D.new()
	frame.name = name
	frame.position = position
	frame.rotation = rotation
	add_child(frame)
	_box(frame, "DeepSetGlass", Vector3(size.x - 0.16, size.y - 0.16, 0.045), Vector3(0, 0, 0), _glass, 0.025)
	for x in [-size.x * 0.5, size.x * 0.5]:
		_box(frame, "HeavyWindowJamb", Vector3(0.13, size.y + 0.18, size.z), Vector3(x, 0, 0.01), _trim, 0.025)
	for y in [-size.y * 0.5, size.y * 0.5]:
		_box(frame, "WeatheredWindowSill", Vector3(size.x + 0.18, 0.13, size.z), Vector3(0, y, 0.01), _wood, 0.025)
	_box(frame, "WindowMuntin", Vector3(size.x - 0.05, 0.045, size.z * 0.8), Vector3(0, 0, 0.04), _trim, 0.012)
	for x in [-size.x * 0.18, size.x * 0.18]:
		_box(frame, "WindowMullion", Vector3(0.036, size.y - 0.04, size.z * 0.8), Vector3(x, 0, 0.04), _trim, 0.01)

func _build_exterior_stories() -> void:
	# A restrained, weathered name board marks the landmark from the beach path.
	var sign_anchor := Node3D.new()
	sign_anchor.name = "GyleColdStoreSign"
	sign_anchor.position = Vector3(-7.94, 4.0, 2.55)
	sign_anchor.rotation.y = -PI * 0.5
	add_child(sign_anchor)
	_box(sign_anchor, "EnamelSignBacking", Vector3(2.7, 0.78, 0.12), Vector3.ZERO, _trim, 0.08)
	for x in [-1.15, 1.15]:
		_box(sign_anchor, "SignMount", Vector3(0.09, 0.62, 0.08), Vector3(x, -0.73, 0), _rust, 0.025)
	var label := Label3D.new()
	label.name = "GyleCanneryLettering"
	label.text = "G Y L E   C O L D   S T O R E"
	label.font_size = 36
	label.pixel_size = 0.004
	label.modulate = Color("#c7b890")
	label.outline_size = 8
	label.outline_modulate = Color("#192426")
	label.position = Vector3(0, 0.0, -0.072)
	sign_anchor.add_child(label)
	for i in range(4):
		var knot := _sphere(self, "FenderBollard_%d" % i, 0.13, Vector3(-8.6, 0.35, -3.6 + i * 2.4), Vector3(1.0, 1.35, 1.0), _rust)
		knot.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	for i in range(3):
		var debris := _box(self, "BeachDriftwood_%d" % i, Vector3(1.0 + i * 0.2, 0.12, 0.18), Vector3(-9.1 + i * 1.25, 0.07, 4.4 + i * 0.36), _wood, 0.06, Vector3(0, 0, -0.08))
		debris.rotation.y = 0.3 + i * 0.54
	# Winch cable runs from the hoist toward the waterline.
	for z in [-3.7, 3.7]:
		_pipe(self, "ShoreHaulPost", Vector3(-9.1, 0.08, z), Vector3(-9.1, 1.1, z), 0.08, _rust)
		_pipe(self, "HaulCable", Vector3(-9.1, 1.08, z), Vector3(-12.6, 0.48, z * 1.12), 0.018, _trim)
	_build_reel(self, Vector3(-8.8, 0.58, -4.35))
	_build_reel(self, Vector3(-8.8, 0.58, 4.35))
	# Standpipe and pressure gauges break the long rear silhouette.
	for y in [1.2, 1.65, 2.1]:
		_box(self, "NorthServicePipeClamp", Vector3(0.17, 0.075, 0.075), Vector3(1.8, y, 5.0), _rust, 0.02)
	_pipe(self, "NorthServicePipe", Vector3(1.8, 0.55, 5.0), Vector3(1.8, 3.9, 5.0), 0.045, _trim)

func _build_reel(parent: Node, position: Vector3) -> void:
	var reel := Node3D.new()
	reel.name = "WoodenNetReel"
	reel.position = position
	parent.add_child(reel)
	_pipe(reel, "ReelAxle", Vector3(-0.42, 0.45, 0), Vector3(0.42, 0.45, 0), 0.075, _rust)
	for sign in [-1.0, 1.0]:
		var wheel := _sphere(reel, "ReelFlange", 0.46, Vector3(sign * 0.36, 0.45, 0), Vector3(0.16, 1.0, 1.0), _wood)
		wheel.rotation.z = PI * 0.5
	for i in range(8):
		var a := TAU * float(i) / 8.0
		_pipe(reel, "ReelSpoke", Vector3(0, 0.45, 0), Vector3(0, 0.45 + cos(a) * 0.39, sin(a) * 0.39), 0.026, _trim)

func _build_interiors() -> void:
	# Structural ribs, fish hooks and equipment rails make the interior read as a working cold store.
	for x in [-6.4, -3.2, 0.0, 3.2, 6.4]:
		_pipe(self, "InteriorRafterTie", Vector3(x, 4.48, -4.25), Vector3(x, 4.48, 4.25), 0.055, _wood)
		for z in [-3.6, 0.0, 3.6]:
			_pipe(self, "HangingRailChain", Vector3(x, 4.40, z), Vector3(x, 3.72, z), 0.012, _rust)
			_pipe(self, "EmptyProcessingHook", Vector3(x - 0.08, 3.72, z), Vector3(x + 0.08, 3.55, z), 0.019, _trim)
	for z in [-4.05, 4.05]:
		_pipe(self, "InteriorCableRun", Vector3(-6.8, 3.95, z), Vector3(6.7, 3.95, z), 0.022, _rubber)
	for x in [-1.0, 4.5]:
		var lamp := _box(self, "CagedWorkLampHousing", Vector3(0.68, 0.22, 0.32), Vector3(x, 4.22, 0), _trim, 0.07)
		lamp.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		_box(self, "WorkLampFrostedLens", Vector3(0.54, 0.025, 0.2), Vector3(x, 4.09, 0), PG.material(Color("#b4a57e"), 0.45, 0.0), 0.02)
	# Fixed light controllers remain the sole state owners; these fixtures are decorative and unlit.

func _build_machinery() -> void:
	var body := get_node_or_null("Machinery01") as Node3D
	if body == null:
		return
	var station := Node3D.new()
	station.name = "AuthoredColdPlant"
	body.add_child(station)
	_box(station, "CastingFrame", Vector3(1.6, 1.05, 0.88), Vector3(0, 0.02, 0), _trim, 0.12)
	_box(station, "OiledServiceDoor", Vector3(0.8, 0.78, 0.045), Vector3(0, 0.04, -0.46), _steel, 0.06)
	for i in range(7):
		var y := -0.34 + float(i) * 0.11
		_pipe(station, "CoolingFin", Vector3(-0.63, y, -0.50), Vector3(0.63, y, -0.50), 0.027, _rust if i == 5 else _trim)
	for x in [-0.47, 0.47]:
		_pipe(station, "FramePost", Vector3(x, -0.47, -0.51), Vector3(x, 0.52, -0.51), 0.036, _rust)
	var gauge := _sphere(station, "AnalogPressureGauge", 0.15, Vector3(0.39, 0.34, -0.54), Vector3(1.0, 1.0, 0.28), _glass)
	gauge.rotation.x = PI * 0.5
	_pipe(station, "GaugeRim", Vector3(0.39, 0.34, -0.59), Vector3(0.39, 0.34, -0.53), 0.18, _rust)
	_pipe(station, "GaugeNeedle", Vector3(0.39, 0.34, -0.61), Vector3(0.43, 0.41, -0.61), 0.008, _rust)
	_box(station, "EmergencyLeverMount", Vector3(0.28, 0.34, 0.22), Vector3(-0.46, -0.36, 0.52), _wood, 0.06)
	_pipe(station, "EmergencyLever", Vector3(-0.46, -0.24, 0.52), Vector3(-0.46, 0.13, 0.52), 0.027, _rust)
	_pipe(station, "PlantExhaustPipe", Vector3(-0.61, 0.58, 0.14), Vector3(-0.61, 1.9, 0.14), 0.072, _rust)
	for y in [0.74, 1.45, 1.82]:
		_pipe(station, "ExhaustJoint", Vector3(-0.61, y, 0.14), Vector3(-0.61, y + 0.05, 0.14), 0.095, _trim)
	for x in [-0.53, -0.29, -0.05, 0.19, 0.43]:
		_box(station, "PressurePanelMark", Vector3(0.035, 0.23, 0.035), Vector3(x, 0.35, -0.57), _rust, 0.015)

func _build_vat(node_name: String, color: Color) -> void:
	var body := get_node_or_null(node_name) as Node3D
	if body == null:
		return
	var steel := PG.textured_material("steel", color.darkened(0.22), color.lightened(0.06), 0.42, 0.66)
	_pipe(body, "WeldedVatShell", Vector3(0, -0.86, 0), Vector3(0, 0.87, 0), 0.78, steel)
	for y in [-0.81, -0.57, 0.58, 0.82]:
		_pipe(body, "RivetedVatHoop", Vector3(0, y, 0), Vector3(0, y + 0.075, 0), 0.83, _rust if y < 0.0 else _trim)
	_box(body, "VatInspectionLid", Vector3(0.12, 0.09, 0.74), Vector3(0, 0.89, 0), _trim, 0.07)
	_pipe(body, "VatFillPipe", Vector3(0.1, 0.92, -0.1), Vector3(0.1, 1.56, -0.1), 0.075, _rust)
	_pipe(body, "VatDrainPipe", Vector3(0.55, -0.48, 0.4), Vector3(1.15, -0.48, 0.4), 0.06, _trim)
	_pipe(body, "VatValveStem", Vector3(1.12, -0.48, 0.4), Vector3(1.12, -0.12, 0.4), 0.025, _rust)
	var wheel := Node3D.new()
	wheel.name = "VatValveWheel"
	wheel.position = Vector3(1.12, -0.03, 0.4)
	body.add_child(wheel)
	for spoke in range(4):
		var angle := TAU * float(spoke) / 4.0
		_pipe(wheel, "ValveSpoke", Vector3.ZERO, Vector3(cos(angle) * 0.19, sin(angle) * 0.19, 0), 0.017, _rust)
	_pipe(wheel, "ValveOuterRim", Vector3(0, 0, 0), Vector3(0, 0.0, 0.02), 0.24, _rust)

func _build_crate(node_name: String, height_scale := 1.0) -> void:
	var body := get_node_or_null(node_name) as GrayboxBlock
	if body == null:
		return
	var size := body.block_size
	var width := maxf(0.42, size.x)
	var height := maxf(0.42, size.y * height_scale)
	var depth := maxf(0.42, size.z)
	var visual := Node3D.new()
	visual.name = "AuthoredCratePresentation"
	body.add_child(visual)
	_box(visual, "DarkCrateCore", Vector3(width * 0.92, height * 0.84, depth * 0.92), Vector3(0, 0, 0), _inside, 0.08)
	var board_width := width / 5.0
	for index in range(5):
		var x := -width * 0.4 + float(index) * width * 0.2
		_box(visual, "FrontOakSlat", Vector3(board_width * 0.82, height * 0.88, 0.075), Vector3(x, 0, -depth * 0.48), _wood, 0.035)
		_box(visual, "RearOakSlat", Vector3(board_width * 0.82, height * 0.88, 0.075), Vector3(x, 0, depth * 0.48), _wood, 0.035)
	for y in [-height * 0.34, -height * 0.05, height * 0.25]:
		_box(visual, "CrateCrossStrap", Vector3(width * 0.96, 0.09, depth * 1.03), Vector3(0, y, 0), _rust, 0.025)
	for x in [-width * 0.49, width * 0.49]:
		for z in [-depth * 0.49, depth * 0.49]:
			_pipe(visual, "CrateCornerCleat", Vector3(x, -height * 0.47, z), Vector3(x, height * 0.47, z), 0.032, _trim)
	_box(visual, "CrateTopLid", Vector3(width * 0.94, 0.075, depth * 0.94), Vector3(0, height * 0.46, 0), _wood, 0.04)
	for x in [-width * 0.31, -width * 0.1, width * 0.1, width * 0.31]:
		_sphere(visual, "OxidizedCrateNail", 0.018, Vector3(x, height * 0.50, -depth * 0.33), Vector3.ONE, _rust)
	if "Collect" in node_name or "Fuel" in node_name:
		_box(visual, "StencilledSupplyMark", Vector3(width * 0.35, height * 0.12, 0.015), Vector3(0, height * 0.12, -depth * 0.525), _trim, 0.015)

func _build_gate() -> void:
	var body := get_node_or_null("DeepGate") as Node3D
	if body == null:
		return
	for index in range(19):
		var z := -4.5 + float(index) * 0.5
		_pipe(body, "GalvanizedGateBar", Vector3(0, -2.5, z), Vector3(0, 2.5, z), 0.034, _trim)
	for y in [-2.3, -0.8, 0.8, 2.3]:
		_pipe(body, "GateCrossBrace", Vector3(0.08, y, -4.72), Vector3(0.08, y, 4.72), 0.054, _rust)
	for z in [-4.7, 4.7]:
		_pipe(body, "GateHingePost", Vector3(0, -2.6, z), Vector3(0, 2.7, z), 0.09, _trim)
	for y in [-2.1, -1.4, 1.4, 2.1]:
		_pipe(body, "GateWarningBand", Vector3(0.095, y, -4.65), Vector3(0.095, y + 0.16, 4.65), 0.022, _rust)

func _build_conveyor() -> void:
	var body := get_node_or_null("Conveyor01") as GrayboxBlock
	if body == null:
		return
	var line := Node3D.new()
	line.name = "AuthoredFishConveyor"
	body.add_child(line)
	_box(line, "WetBelt", Vector3(3.3, 0.12, 0.82), Vector3(0, 0.13, 0), _rubber, 0.07, Vector3(0, 0, -0.06))
	for side in [-1.0, 1.0]:
		_box(line, "ConveyorSideRail", Vector3(3.5, 0.18, 0.12), Vector3(0, 0.28, side * 0.49), _trim, 0.05)
		for x in [-1.48, -0.5, 0.5, 1.48]:
			_pipe(line, "RollerShaft", Vector3(x, 0.02, -0.48), Vector3(x, 0.02, 0.48), 0.049, _rust)
		for x in [-1.35, 1.35]:
			_pipe(line, "ConveyorLeg", Vector3(x, -0.36, side * 0.4), Vector3(x, 0.05, side * 0.4), 0.052, _trim)
	for index in range(14):
		var x := -1.55 + float(index) * 0.24
		_box(line, "BeltCleat", Vector3(0.035, 0.028, 0.74), Vector3(x, 0.21, 0), _rust, 0.012)

func _build_switch() -> void:
	var body := get_node_or_null("LightSwitch") as GrayboxBlock
	if body == null:
		return
	_box(body, "CastIronSwitchBox", Vector3(0.34, 0.52, 0.18), Vector3(0, 0, -0.14), _rust, 0.07)
	_box(body, "PorcelainSwitchFace", Vector3(0.22, 0.32, 0.035), Vector3(0, 0.02, -0.25), _glass, 0.045)
	_pipe(body, "ToggleLever", Vector3(0, -0.06, -0.30), Vector3(0, 0.16, -0.31), 0.024, _trim)
	_sphere(body, "ToggleHandle", 0.055, Vector3(0, 0.18, -0.31), Vector3(1.0, 0.75, 1.0), _wood)
	for x in [-0.12, 0.12]:
		for y in [-0.21, 0.22]:
			_sphere(body, "SwitchMountScrew", 0.018, Vector3(x, y, -0.28), Vector3.ONE, _trim)

func _build_fuel_cache() -> void:
	var body := get_node_or_null("ApproachCrate") as GrayboxBlock
	if body == null:
		return
	_box(body, "FuelTinBody", Vector3(0.58, 0.68, 0.4), Vector3.ZERO, _rust, 0.12)
	_box(body, "FuelTinShoulder", Vector3(0.42, 0.1, 0.36), Vector3(0, 0.37, 0), _rust, 0.1)
	_pipe(body, "FuelCanHandle", Vector3(-0.16, 0.39, 0), Vector3(0.16, 0.39, 0), 0.025, _trim)
	_pipe(body, "FuelCanHandleSide", Vector3(-0.16, 0.31, 0), Vector3(-0.16, 0.39, 0), 0.025, _trim)
	_pipe(body, "FuelCanHandleSide", Vector3(0.16, 0.31, 0), Vector3(0.16, 0.39, 0), 0.025, _trim)
	_pipe(body, "FuelCanNeck", Vector3(0.12, 0.42, -0.12), Vector3(0.12, 0.55, -0.12), 0.048, _trim)
	_pipe(body, "FuelCanCap", Vector3(0.12, 0.55, -0.12), Vector3(0.12, 0.60, -0.12), 0.07, _rust)
	_box(body, "FuelHazardLabel", Vector3(0.29, 0.18, 0.02), Vector3(0, 0.04, -0.212), _wood, 0.02)

func _build_approach_cover() -> void:
	var body := get_node_or_null("ApproachCoverF1") as GrayboxBlock
	if body == null:
		return
	var canopy := Node3D.new()
	canopy.name = "CanvasWindbreak"
	canopy.position.y = -1.15
	body.add_child(canopy)
	var tarp := PG.material(Color("#343c37"), 0.9, 0.0)
	tarp.cull_mode = BaseMaterial3D.CULL_DISABLED
	_box(canopy, "WeatherTarpPanel", Vector3(2.45, 0.06, 2.35), Vector3(0, 0.42, 0), tarp, 0.16, Vector3(0.0, 0.02, -0.04))
	for x in [-1.05, 1.05]:
		for z in [-1.0, 1.0]:
			_pipe(canopy, "TarpSupportPole", Vector3(x, -0.75, z), Vector3(x * 0.92, 0.52, z * 0.92), 0.033, _wood)
			_pipe(canopy, "GuyLine", Vector3(x * 0.92, 0.45, z * 0.92), Vector3(x * 1.24, -0.95, z * 1.24), 0.011, _rust)
	for x in [-0.8, 0.0, 0.8]:
		_pipe(canopy, "TarpSeam", Vector3(x, 0.48, -1.1), Vector3(x * 0.93, 0.48, 1.1), 0.012, _trim)

func _build_sign() -> void:
	var body := get_node_or_null("IntroSign") as GrayboxBlock
	if body == null:
		return
	var board := _box(body, "HandPaintedFacilityBoard", Vector3(0.12, 0.72, 1.64), Vector3(0.0, 0.52, 0.0), _wood, 0.07)
	board.rotation.y = 0.035
	for z in [-0.68, 0.68]:
		_pipe(body, "SignPost", Vector3(0.0, -1.35, z), Vector3(0.0, 0.88, z), 0.045, _rust)
	for y in [-0.14, 0.86]:
		_pipe(body, "SignBorder", Vector3(-0.08, y, -0.81), Vector3(-0.08, y, 0.81), 0.025, _trim)
	var lettering := Label3D.new()
	lettering.name = "ColdStoreSignage"
	lettering.text = "G Y L E\nCOLD STORE"
	lettering.font_size = 40
	lettering.pixel_size = 0.004
	lettering.modulate = Color("#d0bd91")
	lettering.outline_size = 7
	lettering.outline_modulate = Color("#1e2929")
	lettering.position = Vector3(-0.075, 0.49, -0.05)
	lettering.rotation.y = -PI * 0.5
	body.add_child(lettering)
