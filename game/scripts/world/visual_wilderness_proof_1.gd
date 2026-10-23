class_name VisualWildernessProof1
extends Node3D

const TERRAIN_X_COUNT := 73
const TERRAIN_Z_COUNT := 45
const TERRAIN_STEP := 2.5

## Bounded, presentation-only wilderness cell. Gameplay state remains owned by
## GameWorld and the accepted Strand/Cannery scenes.

@export_enum("PERFORMANCE", "BALANCED", "QUALITY") var presentation_profile := "QUALITY"
@export var planning_envelope := Vector2(500.0, 250.0)
@export var planning_cell_size := 250.0
@export var deterministic_seed := 1337

var _vegetation_count := 0
var _terrain_area := 0.0
var _water_present := false
var _rng := RandomNumberGenerator.new()
var _vegetation_instance_transforms: Dictionary = {}
var _environment: Environment
var _sun: DirectionalLight3D
var _rain: CPUParticles3D
var _world_state: WorldStateManager
var _time_weather: TimeWeatherManager
var _atmosphere_refresh := 0.0

func _ready() -> void:
	if OS.has_feature("android"):
		presentation_profile = "PERFORMANCE"
	add_to_group("visual_wilderness_region")
	$Sun.add_to_group("sun")
	_rng.seed = deterministic_seed
	_configure_environment()
	_build_terrain()
	_build_trail()
	_build_coastline()
	_build_water()
	_build_horizon_landforms()
	_build_rocks_and_elevation()
	_build_cannery_landmark()
	_build_vegetation()
	_build_weather_particles()
	call_deferred("_bind_world_atmosphere")
	set_process(true)

func _process(delta: float) -> void:
	_atmosphere_refresh += delta
	if _atmosphere_refresh >= 0.4:
		_atmosphere_refresh = 0.0
		_apply_world_atmosphere()
	var player := get_tree().get_first_node_in_group("player") as Node3D
	if player and _rain:
		_rain.global_position = player.global_position + Vector3(0.0, 8.0, 0.0)

func _profile_settings() -> Dictionary:
	match presentation_profile:
		"PERFORMANCE":
			return {"trees": 210, "shrubs": 190, "grass": 2200, "deadfall": 32, "distance": 78.0}
		"QUALITY":
			return {"trees": 760, "shrubs": 520, "grass": 9200, "deadfall": 112, "distance": 145.0}
		_:
			return {"trees": 390, "shrubs": 290, "grass": 4800, "deadfall": 62, "distance": 105.0}

func _configure_environment() -> void:
	var environment := Environment.new()
	_environment = environment
	environment.background_mode = Environment.BG_SKY
	var sky := Sky.new()
	var sky_material := ProceduralSkyMaterial.new()
	sky_material.sky_top_color = Color("#183348")
	sky_material.sky_horizon_color = Color("#9eb7bd")
	sky_material.ground_bottom_color = Color("#172126")
	sky_material.ground_horizon_color = Color("#829497")
	sky_material.sun_angle_max = 18.0
	sky_material.sun_curve = 0.08
	sky.sky_material = sky_material
	environment.sky = sky
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	environment.ambient_light_color = Color("#84999b")
	environment.ambient_light_energy = 0.22
	environment.reflected_light_source = Environment.REFLECTION_SOURCE_SKY
	environment.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	environment.tonemap_exposure = 0.96
	environment.fog_enabled = true
	environment.fog_light_color = Color("#83999d")
	environment.fog_light_energy = 0.68
	environment.fog_density = 0.007
	environment.fog_aerial_perspective = 0.34
	environment.fog_sky_affect = 0.28
	$WorldEnvironment.environment = environment

	var sun := $Sun as DirectionalLight3D
	_sun = sun
	sun.light_color = Color("#d5e0df")
	sun.light_energy = 1.05
	# A broad side key keeps both rear and inspection views readable without
	# increasing ambient-source fill over the entire landscape.
	sun.rotation_degrees.y = 90.0
	sun.shadow_enabled = true

func _build_weather_particles() -> void:
	var rain_material := StandardMaterial3D.new()
	rain_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	rain_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	rain_material.albedo_color = Color("#b4c6c8", 0.32)
	rain_material.roughness = 0.45
	var streak := BoxMesh.new()
	streak.size = Vector3(0.009, 0.42, 0.009)
	streak.material = rain_material
	_rain = CPUParticles3D.new()
	_rain.name = "AlaskaRainCurtain"
	_rain.amount = 420
	_rain.lifetime = 1.25
	_rain.emitting = false
	_rain.visible = false
	_rain.mesh = streak
	_rain.direction = Vector3(-0.08, -1.0, 0.02)
	_rain.spread = 5.0
	_rain.gravity = Vector3(-0.4, -12.0, 0.2)
	_rain.initial_velocity_min = 8.0
	_rain.initial_velocity_max = 12.0
	_rain.angular_velocity_min = 0.0
	_rain.angular_velocity_max = 0.0
	_rain.emission_shape = CPUParticles3D.EMISSION_SHAPE_BOX
	_rain.emission_box_extents = Vector3(22.0, 7.0, 22.0)
	_rain.visibility_aabb = AABB(Vector3(-24, -11, -24), Vector3(48, 24, 48))
	_rain.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(_rain)

func _bind_world_atmosphere() -> void:
	var game_world := get_tree().get_first_node_in_group("game_world") as GameWorld
	if game_world:
		_world_state = game_world.world_state
		_time_weather = game_world.time_weather
		if _world_state and not _world_state.channel_changed.is_connected(_on_world_channel_changed):
			_world_state.channel_changed.connect(_on_world_channel_changed)
	_apply_world_atmosphere()

func _on_world_channel_changed(channel: String) -> void:
	if channel == WorldStateManager.CHANNEL_TIME or channel == WorldStateManager.CHANNEL_WEATHER:
		_apply_world_atmosphere()

func _apply_world_atmosphere() -> void:
	if _environment == null or _sun == null:
		return
	var hour: float = _time_weather.hour if _time_weather else 8.0
	var weather: String = _world_state.channel_value(WorldStateManager.CHANNEL_WEATHER) if _world_state else "CLEAR"
	var storm_weight: float = 1.0 if weather == "STORM" else 0.52 if weather == "RAIN" else 0.0
	var dusk_weight := clampf((hour - 15.5) / 3.2, 0.0, 1.0)
	var night_weight := clampf((hour - 19.0) / 2.0, 0.0, 0.82)
	var sky_material := _environment.sky.sky_material as ProceduralSkyMaterial if _environment.sky else null
	if sky_material:
		var sky_blend: float = maxf(storm_weight, night_weight)
		sky_material.sky_top_color = Color("#183348").lerp(Color("#101923"), sky_blend)
		sky_material.sky_horizon_color = Color("#9eb7bd").lerp(Color("#35434b"), sky_blend)
		sky_material.ground_bottom_color = Color("#172126").lerp(Color("#11181d"), sky_blend)
		sky_material.ground_horizon_color = Color("#829497").lerp(Color("#344249"), sky_blend)
		sky_material.sun_angle_max = lerpf(18.0, 10.0, sky_blend)
	var day_factor := 1.0
	if hour >= 16.0:
		day_factor = clampf(1.0 - (hour - 16.0) * 0.23, 0.28, 1.0)
	elif hour < 7.0:
		day_factor = 0.55
	var weather_factor := 1.0
	if weather == "RAIN":
		weather_factor = 0.76
	elif weather == "STORM":
		weather_factor = 0.52
	_sun.light_energy = 1.05 * day_factor * weather_factor
	_sun.rotation_degrees.x = lerpf(-48.0, -7.0, clampf((hour - 8.0) / 10.0, 0.0, 1.0))
	_sun.light_color = Color("#d5e0df").lerp(Color("#c88f69"), clampf((hour - 16.0) / 2.0, 0.0, 0.7))
	_environment.ambient_light_energy = lerpf(0.22, 0.12, 1.0 - day_factor) * (0.88 if weather == "STORM" else 1.0)
	_environment.fog_density = 0.007 + (0.0015 if weather == "RAIN" else 0.004 if weather == "STORM" else 0.0) + (0.002 if hour >= 16.0 else 0.0)
	_environment.fog_light_energy = 0.68 if weather == "CLEAR" else 0.76
	_environment.fog_light_color = Color("#83999d") if weather == "CLEAR" else Color("#748c93")
	var wetness: float = 0.0 if weather == "CLEAR" else 0.55 if weather == "RAIN" else 1.0
	if _rain:
		_rain.visible = wetness > 0.0
		_rain.emitting = wetness > 0.0
		_rain.amount = maxi(1, roundi(420.0 * wetness))

func _material(color: Color, roughness := 0.82, metallic := 0.0) -> StandardMaterial3D:
	var material := StandardMaterial3D.new()
	material.albedo_color = color
	material.roughness = roughness
	material.metallic = metallic
	return material

func _terrain_material() -> ShaderMaterial:
	var shader := Shader.new()
	shader.code = """
	shader_type spatial;
	render_mode diffuse_burley, specular_schlick_ggx;
	uniform sampler2D terrain_albedo : source_color, filter_linear_mipmap, repeat_enable;
	varying vec3 world_pos;
	varying vec3 world_normal;
	varying vec3 terrain_tint;
	varying vec2 terrain_uv;

	float hash21(vec2 p) {
		p = fract(p * vec2(123.34, 456.21));
		p += dot(p, p + 45.32);
		return fract(p.x * p.y);
	}
	float noise21(vec2 p) {
		vec2 i = floor(p);
		vec2 f = fract(p);
		f = f * f * (3.0 - 2.0 * f);
		return mix(mix(hash21(i), hash21(i + vec2(1.0, 0.0)), f.x),
			mix(hash21(i + vec2(0.0, 1.0)), hash21(i + vec2(1.0, 1.0)), f.x), f.y);
	}
	void vertex() {
		world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
		world_normal = normalize(mat3(MODEL_MATRIX) * NORMAL);
		terrain_tint = COLOR.rgb;
		terrain_uv = world_pos.xz * 0.19;
	}
	void fragment() {
		float broad = noise21(world_pos.xz * 0.12) * 0.62 + noise21(world_pos.xz * 0.31) * 0.38;
		float grain = noise21(world_pos.xz * 1.05) * 0.48 + noise21(world_pos.xz * 4.2) * 0.34 + noise21(world_pos.xz * 12.0) * 0.18;
		float slope = 1.0 - clamp(world_normal.y, 0.0, 1.0);
		float height_band = smoothstep(1.3, 4.8, world_pos.y + broad * 1.8);
		vec3 soil = mix(vec3(0.105, 0.085, 0.059), vec3(0.25, 0.20, 0.12), broad);
		soil = mix(soil, vec3(0.34, 0.25, 0.15), smoothstep(0.63, 0.88, grain) * 0.46);
		vec3 moss = mix(vec3(0.075, 0.14, 0.095), vec3(0.26, 0.31, 0.18), grain);
		vec3 stone = mix(vec3(0.18, 0.22, 0.21), vec3(0.39, 0.39, 0.34), broad * 0.55 + grain * 0.45);
		vec3 cold_litter = mix(vec3(0.24, 0.30, 0.29), vec3(0.43, 0.45, 0.40), grain);
		vec3 base = mix(soil, moss, smoothstep(0.22, 0.76, broad + grain * 0.18));
		base = mix(base, stone, smoothstep(0.22, 0.68, slope));
		base = mix(base, cold_litter, height_band * 0.42);
		float damp = smoothstep(0.52, 0.82, noise21(world_pos.xz * 0.19 + vec2(3.4, -1.8)));
		base = mix(base, base * vec3(0.48, 0.55, 0.57), damp * (1.0 - slope));
		vec3 sampled_ground = texture(terrain_albedo, terrain_uv).rgb;
		ALBEDO = mix(base * mix(0.76, 1.18, grain), sampled_ground, 0.76) * terrain_tint;
		ROUGHNESS = mix(0.99, 0.57, damp);
		METALLIC = 0.0;
	}
	"""
	var material := ShaderMaterial.new()
	material.shader = shader
	material.set_shader_parameter("terrain_albedo", load("res://assets/environment/alaskan_forest_floor.png"))
	return material

func _water_material() -> ShaderMaterial:
	var shader := Shader.new()
	shader.code = """
	shader_type spatial;
	render_mode cull_disabled, diffuse_burley, specular_schlick_ggx;
	varying vec3 world_pos;
	void vertex() {
		VERTEX.y += sin(VERTEX.x * 0.54 + VERTEX.z * 0.31 + TIME * 0.32) * 0.035;
		VERTEX.y += cos(VERTEX.z * 0.78 - VERTEX.x * 0.22 - TIME * 0.24) * 0.024;
		world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	}
	void fragment() {
		float long_wave = sin(world_pos.x * 0.28 + world_pos.z * 0.17 + TIME * 0.27);
		float cross_wave = sin(world_pos.z * 0.43 - world_pos.x * 0.11 - TIME * 0.19);
		float fine_wave = sin(world_pos.x * 0.67 + world_pos.z * 0.31 + TIME * 0.38);
		float wave = long_wave * 0.52 + cross_wave * 0.31 + fine_wave * 0.17;
		float sheen = smoothstep(0.0, 0.88, wave);
		ALBEDO = mix(vec3(0.024, 0.085, 0.115), vec3(0.075, 0.18, 0.205), sheen);
		ROUGHNESS = mix(0.34, 0.25, sheen);
		SPECULAR = 0.52;
		METALLIC = 0.02;
	}
	"""
	var material := ShaderMaterial.new()
	material.shader = shader
	return material

func _trail_material() -> ShaderMaterial:
	var shader := Shader.new()
	shader.code = """
	shader_type spatial;
	varying vec3 world_position;
	float hash21(vec2 p) {
		p = fract(p * vec2(123.34, 456.21));
		p += dot(p, p + 45.32);
		return fract(p.x * p.y);
	}
	float noise21(vec2 p) {
		vec2 i = floor(p);
		vec2 f = fract(p);
		f = f * f * (3.0 - 2.0 * f);
		return mix(mix(hash21(i), hash21(i + vec2(1.0, 0.0)), f.x),
			mix(hash21(i + vec2(0.0, 1.0)), hash21(i + vec2(1.0, 1.0)), f.x), f.y);
	}
	void vertex() {
		world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	}
	void fragment() {
		float broad = noise21(world_position.xz * 0.28);
		float grit = noise21(world_position.xz * 5.1) * 0.65 + noise21(world_position.xz * 17.0) * 0.35;
		float damp = smoothstep(0.58, 0.83, noise21(world_position.xz * 0.47 + vec2(7.1, -3.6)));
		vec3 soil = mix(vec3(0.095, 0.081, 0.064), vec3(0.28, 0.235, 0.17), broad * 0.78 + grit * 0.22);
		soil = mix(soil, vec3(0.12, 0.12, 0.105), damp * 0.55);
		ALBEDO = soil;
		ROUGHNESS = mix(0.96, 0.72, damp);
		METALLIC = 0.0;
	}
	"""
	var material := ShaderMaterial.new()
	material.shader = shader
	return material

func _foliage_material(base: Color, roughness := 0.94) -> ShaderMaterial:
	var shader := Shader.new()
	shader.code = """
	shader_type spatial;
	render_mode diffuse_burley, specular_schlick_ggx, cull_disabled;
	uniform vec4 fallback_color : source_color = vec4(0.25, 0.32, 0.23, 1.0);
	uniform float foliage_roughness = 0.94;
	varying vec3 world_position;
	float hash31(vec3 p) {
		p = fract(p * 0.1031);
		p += dot(p, p.yxz + 33.33);
		return fract((p.x + p.y) * p.z);
	}
	float noise31(vec3 p) {
		vec3 i = floor(p);
		vec3 f = fract(p);
		f = f * f * (3.0 - 2.0 * f);
		return mix(mix(mix(hash31(i), hash31(i + vec3(1.0, 0.0, 0.0)), f.x),
			mix(hash31(i + vec3(0.0, 1.0, 0.0)), hash31(i + vec3(1.0, 1.0, 0.0)), f.x), f.y),
			mix(mix(hash31(i + vec3(0.0, 0.0, 1.0)), hash31(i + vec3(1.0, 0.0, 1.0)), f.x),
			mix(hash31(i + vec3(0.0, 1.0, 1.0)), hash31(i + vec3(1.0, 1.0, 1.0)), f.x), f.y), f.z);
	}
	void vertex() {
		world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	}
	void fragment() {
		float has_vertex_tint = 1.0 - smoothstep(0.94, 0.999, min(COLOR.r, min(COLOR.g, COLOR.b)));
		vec3 foliage_color = mix(fallback_color.rgb, COLOR.rgb, has_vertex_tint);
		float needle_noise = noise31(world_position * vec3(23.0, 18.0, 23.0)) * 0.66
			+ noise31(world_position * vec3(5.3, 7.1, 5.3)) * 0.34;
		ALBEDO = foliage_color * mix(0.82, 1.2, needle_noise);
		ROUGHNESS = foliage_roughness;
		METALLIC = 0.0;
	}
	"""
	var material := ShaderMaterial.new()
	material.shader = shader
	material.set_shader_parameter("fallback_color", base)
	material.set_shader_parameter("foliage_roughness", roughness)
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
	var lowland := (sin(x * 0.09) * cos(z * 0.13) * 0.88 + sin(x * 0.19 + z * 0.12) * 0.34) * (1.0 - route_mask * 0.38)
	lowland += sin(x * 0.34 + z * 0.28) * cos(z * 0.22 - x * 0.12) * 0.08
	var ridge := exp(-pow((x - 54.0) / 24.0, 2.0) - pow((z - 17.0) / 28.0, 2.0)) * 8.0
	ridge *= 1.0 - 0.82 * exp(-pow(z / 7.0, 2.0))
	var creek_cut := exp(-pow((z + 19.0) / 5.8, 2.0) - pow((x - 58.0) / 42.0, 2.0)) * 4.0
	var shore_z := _shoreline_z(x)
	var inland_distance := maxf(0.0, z - shore_z)
	var flatten_amount := clampf(inland_distance / 6.0, 0.0, 1.0)
	var flatten := 1.0 - flatten_amount * flatten_amount * (3.0 - 2.0 * flatten_amount)
	lowland = lerpf(lowland, 0.0, flatten)
	var seaward_cut := clampf((shore_z - z) / 6.0, 0.0, 1.0) * 3.0
	return lowland + ridge - creek_cut - seaward_cut

func _shoreline_z(x: float) -> float:
	return -31.0 + sin(x * 0.095) * 1.75 + sin(x * 0.21 + 0.7) * 0.48

func terrain_normal(x: float, z: float) -> Vector3:
	var sample_step := 0.5
	var slope_x := (_terrain_height(x + sample_step, z) - _terrain_height(x - sample_step, z)) / (2.0 * sample_step)
	var slope_z := (_terrain_height(x, z + sample_step) - _terrain_height(x, z - sample_step)) / (2.0 * sample_step)
	return Vector3(-slope_x, 1.0, -slope_z).normalized()

func _build_terrain() -> void:
	var terrain_mesh := ArrayMesh.new()
	var vertices := PackedVector3Array()
	var normals := PackedVector3Array()
	var colors := PackedColorArray()
	var uvs := PackedVector2Array()
	var indices := PackedInt32Array()
	var x_count := TERRAIN_X_COUNT
	var z_count := TERRAIN_Z_COUNT
	var step := TERRAIN_STEP
	for z_index in range(z_count):
		var z := -55.0 + float(z_index) * step
		for x_index in range(x_count):
			var x := -70.0 + float(x_index) * step
			var height := _terrain_height(x, z)
			vertices.append(Vector3(x, height, z))
			normals.append(terrain_normal(x, z))
			var broad := 0.5 + sin(x * 0.13 + cos(z * 0.1)) * cos(z * 0.17 - x * 0.06) * 0.30
			var grain := 0.5 + sin(x * 0.61 + z * 0.37) * cos(z * 0.53 - x * 0.29) * 0.20
			var moss_ratio := clampf(0.18 + broad * 0.72 + grain * 0.10, 0.0, 1.0)
			var pigment := Color(1.24, 0.94, 0.72).lerp(Color(0.82, 1.18, 0.78), moss_ratio)
			var slope := 1.0 - terrain_normal(x, z).y
			pigment = pigment.lerp(Color(0.84, 0.96, 1.18), clampf(slope * 1.45, 0.0, 0.65))
			var brightness := 0.76 + grain * 0.42
			colors.append(Color(pigment.r * brightness, pigment.g * brightness, pigment.b * brightness))
			uvs.append(Vector2(float(x_index) / float(x_count - 1), float(z_index) / float(z_count - 1)))
	for z_index in range(z_count - 1):
		for x_index in range(x_count - 1):
			var a := z_index * x_count + x_index
			var b := a + 1
			var c := a + x_count
			var d := c + 1
			indices.append(a)
			indices.append(b)
			indices.append(c)
			indices.append(b)
			indices.append(d)
			indices.append(c)
	var arrays := []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_COLOR] = colors
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_INDEX] = indices
	terrain_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	terrain_mesh.surface_set_material(0, _terrain_material())
	var terrain_mesh_instance := get_node("Region/Cell_0_0/Terrain/TerrainBase/TerrainMesh") as MeshInstance3D
	terrain_mesh_instance.mesh = terrain_mesh
	_terrain_area = 180.0 * 110.0

	var faces := PackedVector3Array()
	for index in indices:
		faces.append(vertices[index])
	var shape := ConcavePolygonShape3D.new()
	shape.set_faces(faces)
	shape.backface_collision = true
	var terrain_collision := get_node("Region/Cell_0_0/Terrain/TerrainBase/TerrainCollision") as CollisionShape3D
	terrain_collision.shape = shape
	# The irregular terrain is the walking surface. The flat sector pads are
	# presentation/collision helpers and are removed from the collision mask.
	var terrain_base := get_node("Region/Cell_0_0/Terrain/TerrainBase") as StaticBody3D
	terrain_base.collision_layer = 1

func _strip_mesh(points: Array[Vector2], width: float, material: Material, y_offset := 0.025, follow_terrain := true) -> ArrayMesh:
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
			var edge: Vector2 = point + side * float(side_sign)
			var surface_y := _terrain_height(edge.x, edge.y) + y_offset if follow_terrain else y_offset
			vertices.append(Vector3(edge.x, surface_y, edge.y))
			normals.append(Vector3.UP)
			uvs.append(Vector2(float(i) / float(points.size() - 1), 0.5 + side_sign * 0.5))
	for i in range(points.size() - 1):
		var base := i * 2
		# Wind each strip's top face upward so one-sided gravel and trail
		# materials remain visible from the normal gameplay camera.
		indices.append_array(PackedInt32Array([base, base + 1, base + 2, base + 1, base + 3, base + 2]))
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
	trail.mesh = _strip_mesh(points, 3.1, _trail_material(), 0.035)
	var clearing := get_node("Region/Cell_0_0/Dressing/Clearing") as MeshInstance3D
	# The old rectangular clearing read as a floating test platform. Terrain and
	# irregular footpaths now form the playable clearing without visible proxy slabs.
	clearing.visible = false

func _build_coastline() -> void:
	var dressing := get_node("Region/Cell_0_0/Dressing")
	var points: Array[Vector2] = []
	for x in [-68.0, -58.0, -48.0, -36.0, -25.0, -13.0, -2.0, 9.0, 20.0]:
		points.append(Vector2(x, _shoreline_z(x)))
	var shoreline_water := _mesh_instance(get_node("Region/Cell_0_0"), "CoastlineWater", _coast_water_mesh(points), _water_material())
	shoreline_water.position.y = -0.08
	var shore_material := _trail_material()
	var shore := _mesh_instance(dressing, "StrandShoreline", _strip_mesh(points, 4.6, shore_material, 0.02), shore_material)
	var pebble_material := _material(Color("#77786f"), 0.93)
	for index in range(22):
		var point_index := _rng.randi_range(0, points.size() - 2)
		var point := points[point_index].lerp(points[point_index + 1], _rng.randf())
		var size := Vector3(_rng.randf_range(0.12, 0.42), _rng.randf_range(0.08, 0.2), _rng.randf_range(0.1, 0.3))
		var pebble := _mesh_instance(dressing, "ShorePebble%02d" % index, _build_rock_mesh(index + 41), pebble_material, Vector3(point.x, _terrain_height(point.x, point.y) + 0.04, point.y))
		pebble.scale = size
		pebble.rotation.y = _rng.randf_range(0.0, TAU)
		pebble.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

func _coast_water_mesh(points: Array[Vector2]) -> ArrayMesh:
	var mesh := ArrayMesh.new()
	var vertices := PackedVector3Array()
	var normals := PackedVector3Array()
	var indices := PackedInt32Array()
	var columns := points.size()
	for row in range(8):
		var depth := float(row) / 7.0
		for x_index in range(columns):
			var shore := points[x_index]
			var x := shore.x
			var z := lerpf(shore.y - 0.2, -55.0, depth)
			z += sin(x * 0.085 + depth * 4.0) * depth * 1.2
			vertices.append(Vector3(x, -0.1 + sin(x * 0.15 + depth) * 0.018, z))
			normals.append(Vector3.UP)
	for row in range(7):
		for x_index in range(columns - 1):
			var a := row * columns + x_index
			var b := a + 1
			var c := a + columns
			var d := c + 1
			indices.append(a)
			indices.append(b)
			indices.append(c)
			indices.append(b)
			indices.append(d)
			indices.append(c)
	var arrays := []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_INDEX] = indices
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return mesh

func _build_water() -> void:
	var points: Array[Vector2] = []
	for i in range(11):
		var x := 32.0 + float(i) * 5.2
		points.append(Vector2(x, -19.0 + sin(x * 0.12) * 2.4))
	var water := get_node("Region/Cell_0_0/Water") as MeshInstance3D
	water.mesh = _strip_mesh(points, 7.5, _water_material(), -0.08, false)
	_water_present = true
	var dressing := get_node("Region/Cell_0_0/Dressing")
	var wet_points: Array[Vector2] = []
	for point in points:
		wet_points.append(point + Vector2(0.0, 2.0))
	var wet_material := _material(Color("#353c36"), 0.94, 0.02)
	_mesh_instance(dressing, "WetCreekBank", _strip_mesh(wet_points, 2.8, wet_material, 0.025), wet_material)

func _build_horizon_landforms() -> void:
	# Layered, low-relief island ridges break the open sea horizon on the beach
	# approach. They remain distant background meshes without gameplay collision.
	var dressing := get_node("Region/Cell_0_0/Dressing")
	var palette := [Color("#526268"), Color("#657477"), Color("#718184")]
	for layer in range(3):
		var mesh := ArrayMesh.new()
		var vertices := PackedVector3Array()
		var normals := PackedVector3Array()
		var colors := PackedColorArray()
		var indices := PackedInt32Array()
		var count := 49
		var base_y := -1.2 - float(layer) * 0.8
		for index in range(count):
			var x := lerpf(-142.0, 142.0, float(index) / float(count - 1))
			var ridge := 2.4
			for peak in range(7):
				var center := -120.0 + float(peak) * 40.0 + float(layer) * 5.5
				var amplitude := 5.5 + float((peak * 7 + layer * 3) % 6) * 1.35
				var width := 8.5 + float((peak + layer * 2) % 4) * 3.2
				ridge += amplitude * exp(-pow((x - center) / width, 2.0))
			ridge += 0.7 * sin(x * 0.16 + float(layer) * 1.4) + 0.35 * sin(x * 0.38 - float(layer))
			var crest := maxf(base_y + 1.0, ridge)
			vertices.append(Vector3(x, base_y, 0.0))
			vertices.append(Vector3(x, crest, 0.0))
			normals.append(Vector3.FORWARD)
			normals.append(Vector3.FORWARD)
			var tint := 0.83 + 0.13 * sin(float(index) * 0.31 + float(layer))
			colors.append(palette[layer] * tint)
			colors.append(palette[layer] * tint)
		for index in range(count - 1):
			var lower_a := index * 2
			var upper_a := lower_a + 1
			var lower_b := lower_a + 2
			var upper_b := lower_a + 3
			indices.append_array(PackedInt32Array([lower_a, upper_a, lower_b, lower_b, upper_a, upper_b]))
		var arrays := []
		arrays.resize(Mesh.ARRAY_MAX)
		arrays[Mesh.ARRAY_VERTEX] = vertices
		arrays[Mesh.ARRAY_NORMAL] = normals
		arrays[Mesh.ARRAY_COLOR] = colors
		arrays[Mesh.ARRAY_INDEX] = indices
		mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
		var material := _material(Color.WHITE, 1.0)
		material.cull_mode = BaseMaterial3D.CULL_DISABLED
		mesh.surface_set_material(0, material)
		var ridge_instance := _mesh_instance(dressing, "DistantIslandRidge_%d" % layer, mesh, material)
		ridge_instance.position = Vector3(0.0, 0.0, -70.0 - float(layer) * 13.0)
		ridge_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

func _add_rock(parent: Node, index: int, position: Vector3, scale: Vector3) -> void:
	var body := StaticBody3D.new()
	body.name = "RockCollision%02d" % index
	body.collision_layer = 1
	body.collision_mask = 0
	body.position = position
	parent.add_child(body)
	var mesh := _build_rock_mesh(index + 13)
	var rock_colors := [Color("#4b5251"), Color("#62625a"), Color("#686d68"), Color("#555953")]
	var rock_material := _material(rock_colors[index % rock_colors.size()], 0.91, 0.015)
	var visual := _mesh_instance(body, "Rock%02d" % index, mesh, rock_material)
	visual.scale = scale
	visual.rotation_degrees = Vector3(_rng.randf_range(-8.0, 8.0), _rng.randf_range(0.0, 360.0), _rng.randf_range(-8.0, 8.0))
	var collision := CollisionShape3D.new()
	var sphere := SphereShape3D.new()
	sphere.radius = 0.82
	collision.shape = sphere
	collision.scale = Vector3(scale.x, scale.y, scale.z)
	body.add_child(collision)

func _build_rock_mesh(seed_value: int) -> ArrayMesh:
	var rng := RandomNumberGenerator.new()
	rng.seed = seed_value * 7919
	var ring_count := 7
	var side_count := 12
	var points: Array[PackedVector3Array] = []
	for ring in range(ring_count + 1):
		var ring_points := PackedVector3Array()
		var latitude := -PI * 0.5 + PI * float(ring) / float(ring_count)
		for side in range(side_count):
			var angle := TAU * float(side) / float(side_count)
			var roughness := rng.randf_range(0.88, 1.12)
			var radial := maxf(0.02, cos(latitude) * roughness)
			var y := sin(latitude) * rng.randf_range(0.92, 1.08)
			if ring == 0:
				y = -0.78
			elif ring == ring_count:
				y = 0.67
			ring_points.append(Vector3(cos(angle) * radial, y, sin(angle) * radial * 0.88))
		points.append(ring_points)
	var surface := SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for ring in range(ring_count):
		for side in range(side_count):
			var next_side := (side + 1) % side_count
			var a := points[ring][side]
			var b := points[ring + 1][side]
			var c := points[ring][next_side]
			var d := points[ring + 1][next_side]
			surface.add_vertex(a)
			surface.add_vertex(b)
			surface.add_vertex(c)
			surface.add_vertex(c)
			surface.add_vertex(b)
			surface.add_vertex(d)
	surface.index()
	surface.generate_normals()
	return surface.commit()

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
	var rust_material := _material(Color("#7c5138"), 0.78, 0.18)
	var mast := Node3D.new()
	mast.name = "CanneryShoreRadioMast"
	mast.position = Vector3(32.0, 0.0, -1.5)
	dressing.add_child(mast)
	for x in [-0.42, 0.42]:
		for z in [-0.42, 0.42]:
			var foot := Vector3(x, 0.0, z)
			_append_tapered_tube_to_node(mast, "MastLeg", foot, Vector3(x * 0.45, 11.0, z * 0.45), 0.095, 0.026, rust_material)
	for y in [1.2, 2.6, 4.0, 5.4, 6.8, 8.2, 9.6]:
		for z in [-0.32, 0.32]:
			var left := Vector3(-0.32 * maxf(0.25, 1.0 - y / 13.0), y, z)
			var right := Vector3(0.32 * maxf(0.25, 1.0 - y / 13.0), y, z)
			_append_tapered_tube_to_node(mast, "MastCrossBrace", left, right, 0.033, 0.033, rust_material)
	for y in [2.0, 4.8, 7.6, 10.0]:
		var t := clampf(y / 11.0, 0.0, 1.0)
		var half_span := lerpf(0.42, 0.19, t)
		_append_tapered_tube_to_node(mast, "MastDiagonal", Vector3(-half_span, y, -0.4 * (1.0 - t * 0.45)), Vector3(half_span, y + 1.0, 0.4 * (1.0 - t * 0.45)), 0.023, 0.023, rust_material)
	var beacon := OmniLight3D.new()
	beacon.name = "CanneryRoofBeacon"
	beacon.position = Vector3(0.0, 10.85, 0.0)
	beacon.omni_range = 5.0
	beacon.light_energy = 0.0
	beacon.visible = false
	mast.add_child(beacon)
	var warning := _mesh_instance(mast, "MastWarningDisk", _cylinder_mesh(0.12, 0.12, 0.09, 16), rust_material, Vector3(0.0, 11.1, 0.0))
	warning.rotation_degrees.x = 90.0

func _append_tapered_tube_to_node(parent: Node, name: String, start: Vector3, finish: Vector3, radius_start: float, radius_end: float, material: Material) -> MeshInstance3D:
	var surface := SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	_append_tapered_tube(surface, start, finish, radius_start, radius_end, 8, start.x + finish.z)
	surface.index()
	surface.generate_normals()
	return _mesh_instance(parent, name, surface.commit(), material)

func _multi_mesh_instance(parent: Node, name: String, mesh: Mesh, transforms: Array[Transform3D], distance: float, material: Material) -> MultiMeshInstance3D:
	_vegetation_instance_transforms[name] = transforms.duplicate()
	if mesh.get_surface_count() > 0:
		mesh.surface_set_material(0, material)
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

func vegetation_instance_transform(instance_name: String, index: int) -> Transform3D:
	var transforms: Array[Transform3D] = _vegetation_instance_transforms.get(instance_name, [])
	if index < 0 or index >= transforms.size():
		return Transform3D.IDENTITY
	return transforms[index]

func _can_place_foliage(x: float, z: float) -> bool:
	if z < _shoreline_z(x) + 7.0:
		return false
	if Vector2(x, z).length() < 8.0:
		return false
	if absf(z) < 3.6 and x < 49.0:
		return false
	if Vector2(x, z).distance_to(Vector2(22.0, 0.0)) < 11.5:
		return false
	if x > 30.0 and absf(z + 19.0) < 6.5:
		return false
	return true

func _build_vegetation() -> void:
	var settings := _profile_settings()
	var parent := get_node("Region/Cell_0_0/Dressing/Vegetation")
	var spruce_canopies: Array[Transform3D] = []
	var spruce_trunks: Array[Transform3D] = []
	var hemlock_canopies: Array[Transform3D] = []
	var hemlock_trunks: Array[Transform3D] = []
	var snag_trunks: Array[Transform3D] = []
	var clusters := [Vector2(-59, -8), Vector2(-48, 16), Vector2(-34, 32), Vector2(-19, -15), Vector2(-10, 13), Vector2(1, -13), Vector2(9, 14), Vector2(31, -10), Vector2(37, 18), Vector2(54, 30), Vector2(62, -8), Vector2(82, -28), Vector2(96, 22)]
	for _i in range(int(settings["trees"])):
		var cluster: Vector2 = clusters[_rng.randi_range(0, clusters.size() - 1)]
		var x := clampf(cluster.x + _rng.randfn(0.0, 9.0), -62.0, 104.0)
		var z := clampf(cluster.y + _rng.randfn(0.0, 6.2), -50.0, 54.0)
		if not _can_place_foliage(x, z):
			continue
		var scale := _rng.randf_range(0.82, 1.45)
		var height := _terrain_height(x, z)
		var basis := Basis(Vector3.UP, _rng.randf_range(0.0, TAU)).scaled(Vector3(scale * _rng.randf_range(0.9, 1.12), scale, scale * _rng.randf_range(0.9, 1.12)))
		var transform := Transform3D(basis, Vector3(x, height, z))
		var species := _rng.randi_range(0, 9)
		if species < 6:
			spruce_canopies.append(transform)
			spruce_trunks.append(transform)
		elif species < 9:
			hemlock_canopies.append(transform)
			hemlock_trunks.append(transform)
		else:
			snag_trunks.append(transform)
	var spruce := _build_conifer_mesh(0)
	var hemlock := _build_conifer_mesh(1)
	var snag := _build_conifer_mesh(2)
	_multi_mesh_instance(parent, "ConiferCanopies_MultiMesh", spruce["foliage"], spruce_canopies, float(settings["distance"]), _foliage_material(Color("#354a3a")))
	_multi_mesh_instance(parent, "ConiferTrunks_MultiMesh", spruce["trunk"], spruce_trunks, float(settings["distance"]), _material(Color("#58483a"), 0.95))
	_multi_mesh_instance(parent, "ConiferCanopies_Hemlock_MultiMesh", hemlock["foliage"], hemlock_canopies, float(settings["distance"]), _foliage_material(Color("#3c4c3d")))
	_multi_mesh_instance(parent, "ConiferTrunks_Hemlock_MultiMesh", hemlock["trunk"], hemlock_trunks, float(settings["distance"]), _material(Color("#625044"), 0.95))
	_multi_mesh_instance(parent, "ConiferTrunks_Snag_MultiMesh", snag["trunk"], snag_trunks, float(settings["distance"]), _material(Color("#68635a"), 0.96))

	var shrub_transforms: Array[Transform3D] = []
	var shrub_centers := [Vector2(-56, 8), Vector2(-42, -18), Vector2(-27, 31), Vector2(-13, -14), Vector2(-8, 10), Vector2(6, -12), Vector2(11, 12), Vector2(28, -12), Vector2(35, 20), Vector2(53, 33), Vector2(67, -7), Vector2(82, 14), Vector2(99, -24)]
	for _i in range(int(settings["shrubs"])):
		var center: Vector2 = shrub_centers[_rng.randi_range(0, shrub_centers.size() - 1)]
		var x := clampf(center.x + _rng.randfn(0.0, 8.0), -62.0, 105.0)
		var z := clampf(center.y + _rng.randfn(0.0, 5.0), -52.0, 54.0)
		if not _can_place_foliage(x, z):
			continue
		var scale := _rng.randf_range(0.58, 1.34)
		var basis := Basis(Vector3.UP, _rng.randf_range(0.0, TAU)).scaled(Vector3(scale * 1.25, scale, scale))
		shrub_transforms.append(Transform3D(basis, Vector3(x, _terrain_height(x, z), z)))
	_multi_mesh_instance(parent, "Shrubs_MultiMesh", _build_shrub_mesh(), shrub_transforms, float(settings["distance"]) * 0.8, _foliage_material(Color("#536044")))

	var grass_transforms: Array[Transform3D] = []
	for _i in range(int(settings["grass"])):
		var x := _rng.randf_range(-65.0, 106.0)
		var z := _rng.randf_range(-52.0, 56.0)
		if not _can_place_foliage(x, z):
			continue
		if _rng.randf() < 0.34 and absf(z) > 4.0:
			continue
		var scale := _rng.randf_range(0.55, 1.45)
		var basis := Basis(Vector3.UP, _rng.randf_range(0.0, TAU)).scaled(Vector3(scale, scale, scale))
		grass_transforms.append(Transform3D(basis, Vector3(x, _terrain_height(x, z), z)))
	_multi_mesh_instance(parent, "GroundCover_MultiMesh", _build_grass_mesh(), grass_transforms, float(settings["distance"]) * 0.72, _foliage_material(Color("#7b8051"), 0.98))

	var deadfall_transforms: Array[Transform3D] = []
	for _i in range(int(settings["deadfall"])):
		var x := _rng.randf_range(24.0, 98.0)
		var z := _rng.randf_range(-46.0, 48.0)
		if not _can_place_foliage(x, z):
			continue
		var scale := _rng.randf_range(0.68, 1.4)
		var basis := Basis(Vector3.UP, _rng.randf_range(0.0, TAU)).scaled(Vector3(scale, scale * _rng.randf_range(0.86, 1.18), scale))
		deadfall_transforms.append(Transform3D(basis, Vector3(x, _terrain_height(x, z) + 0.14, z)))
	_multi_mesh_instance(parent, "Deadfall_MultiMesh", _build_deadfall_mesh(), deadfall_transforms, float(settings["distance"]) * 0.9, _material(Color("#746653"), 0.97))

func _append_tapered_tube(surface: SurfaceTool, start: Vector3, finish: Vector3, radius_start: float, radius_end: float, sides := 6, wobble := 0.0) -> void:
	var axis := (finish - start).normalized()
	var tangent := axis.cross(Vector3.UP)
	if tangent.length_squared() < 0.001:
		tangent = axis.cross(Vector3.RIGHT)
	tangent = tangent.normalized()
	var bitangent := axis.cross(tangent).normalized()
	var rings: Array[PackedVector3Array] = []
	for ring in range(3):
		var t := float(ring) / 2.0
		var center := start.lerp(finish, t)
		var radius := lerpf(radius_start, radius_end, t)
		var ring_points := PackedVector3Array()
		for side in range(sides):
			var angle := TAU * float(side) / float(sides)
			var variance := 1.0 + sin(angle * 3.0 + wobble) * 0.08 + cos(angle * 5.0 - wobble) * 0.045
			ring_points.append(center + (tangent * cos(angle) + bitangent * sin(angle)) * radius * variance)
		rings.append(ring_points)
	for ring in range(2):
		for side in range(sides):
			var next_side := (side + 1) % sides
			var a := rings[ring][side]
			var b := rings[ring + 1][side]
			var c := rings[ring][next_side]
			var d := rings[ring + 1][next_side]
			surface.add_vertex(a)
			surface.add_vertex(b)
			surface.add_vertex(c)
			surface.add_vertex(c)
			surface.add_vertex(b)
			surface.add_vertex(d)

func _append_leaf_cluster(surface: SurfaceTool, base: Vector3, direction: Vector3, length: float, width: float) -> void:
	var axis := direction.normalized()
	var side := axis.cross(Vector3.UP)
	if side.length_squared() < 0.01:
		side = axis.cross(Vector3.RIGHT)
	side = side.normalized() * width
	var up := Vector3.UP * width * 0.42
	var mid := base + axis * length * 0.58
	var tip := base + axis * length + up * 0.18
	var a := base - side
	var b := base + side
	var c := mid - side * 0.52 + up
	var d := mid + side * 0.52 + up
	surface.add_vertex(a)
	surface.add_vertex(c)
	surface.add_vertex(b)
	surface.add_vertex(b)
	surface.add_vertex(c)
	surface.add_vertex(d)
	surface.add_vertex(c)
	surface.add_vertex(tip)
	surface.add_vertex(d)
	surface.add_vertex(d)
	surface.add_vertex(tip)
	surface.add_vertex(c)

func _build_conifer_mesh(species: int) -> Dictionary:
	var foliage := SurfaceTool.new()
	foliage.begin(Mesh.PRIMITIVE_TRIANGLES)
	var branch_color := Color("#354a3a") if species == 0 else Color("#3c4c3d")
	foliage.set_color(branch_color)
	var tiers := 10 if species == 0 else 9
	var max_width := 1.68 if species == 0 else 1.92
	var total_height := 7.5 if species == 0 else 6.8
	if species == 2:
		var snag_trunk := SurfaceTool.new()
		snag_trunk.begin(Mesh.PRIMITIVE_TRIANGLES)
		_append_tapered_tube(snag_trunk, Vector3(0.0, 0.0, 0.0), Vector3(0.0, total_height + 0.9, 0.0), 0.3, 0.045, 9, float(species))
		for branch in range(5):
			var branch_angle := TAU * float(branch) / 5.0 + 0.3
			var branch_y := 2.5 + float(branch % 3) * 1.35
			var branch_start := Vector3(0.0, branch_y, 0.0)
			var branch_finish := Vector3(cos(branch_angle) * (1.0 + float(branch % 2) * 0.4), branch_y + 0.65, sin(branch_angle) * (1.0 + float(branch % 2) * 0.4))
			_append_tapered_tube(snag_trunk, branch_start, branch_finish, 0.095, 0.018, 5, branch_angle)
		snag_trunk.index()
		snag_trunk.generate_normals()
		return {"foliage": ArrayMesh.new(), "trunk": snag_trunk.commit()}
	# Build a visibly branching, layered crown with small 3D needle masses. There
	# is no continuous cone shell: gaps between boughs keep trunks, light and sky
	# legible through the forest.
	var needle_palette := [Color("#344c39"), Color("#40583f"), Color("#2d4537"), Color("#4a5d43")]
	var branch_count := 7 if species == 0 else 8
	for tier in range(tiers):
		var ratio := float(tier) / float(tiers - 1)
		var y := 0.58 + ratio * total_height * 0.88
		var width := max_width * pow(1.0 - ratio, 0.82) + 0.035
		for branch in range(branch_count):
			var angle := TAU * (float(branch) + float(tier % 2) * 0.47) / float(branch_count) + float(tier) * 0.41
			var direction := Vector3(cos(angle), 0.0, sin(angle))
			var start := Vector3(0.0, y, 0.0)
			var droop := width * (0.53 if species == 0 else 0.46)
			var finish := direction * width + Vector3(0.0, y - droop, 0.0)
			foliage.set_color(branch_color)
			_append_tapered_tube(foliage, start, finish, 0.095 * (1.0 - ratio * 0.56), 0.014, 5, angle)
			for clump in range(4):
				var along := 0.22 + float(clump) * 0.19
				var center := start.lerp(finish, along)
				center.y += 0.045 * sin(angle * 2.0 + float(clump) * 1.8)
				var lobe_scale := width * (0.21 if clump < 3 else 0.16)
				var tint: Color = needle_palette[(branch + tier * 2 + species) % needle_palette.size()]
				_append_needle_mass(foliage, center, direction, Vector3(lobe_scale * 1.42, lobe_scale * 0.8, lobe_scale * 0.98), tint)
	# A living leader continues through the crown. The exposed bare spear from
	# the graybox tree was visually reading as a pole above stacked foliage.
	foliage.set_color(needle_palette[1])
	_append_tapered_tube(foliage, Vector3(0.0, total_height * 0.78, 0.0), Vector3(0.0, total_height + 0.38, 0.0), 0.27, 0.008, 7, float(species))
	foliage.index()
	foliage.generate_normals()
	var foliage_mesh := foliage.commit()
	var trunk := SurfaceTool.new()
	trunk.begin(Mesh.PRIMITIVE_TRIANGLES)
	_append_tapered_tube(trunk, Vector3(0.0, 0.0, 0.0), Vector3(0.0, total_height + 0.12, 0.0), 0.24 if species != 2 else 0.3, 0.045, 9, float(species))
	if species == 2:
		for branch in range(5):
			var angle := TAU * float(branch) / 5.0 + 0.3
			var y := 2.5 + float(branch % 3) * 1.35
			var start := Vector3(0.0, y, 0.0)
			var finish := Vector3(cos(angle) * (1.0 + float(branch % 2) * 0.4), y + 0.65, sin(angle) * (1.0 + float(branch % 2) * 0.4))
			_append_tapered_tube(trunk, start, finish, 0.095, 0.018, 5, angle)
	trunk.index()
	trunk.generate_normals()
	return {"foliage": foliage_mesh, "trunk": trunk.commit()}

func _append_needle_mass(surface: SurfaceTool, center: Vector3, horizontal_axis: Vector3, radii: Vector3, tint: Color) -> void:
	var axis := Vector3(horizontal_axis.x, 0.0, horizontal_axis.z).normalized()
	var side := Vector3(-axis.z, 0.0, axis.x)
	var sides := 6
	var station_ratios := PackedFloat32Array([0.0, 0.22, 0.47, 0.70, 0.88, 1.0])
	var width_profile := PackedFloat32Array([0.04, 0.50, 0.82, 0.74, 0.44, 0.015])
	var loops: Array[PackedVector3Array] = []
	for station in range(station_ratios.size()):
		var t := station_ratios[station]
		var section := width_profile[station]
		var longitudinal := lerpf(-0.68, 0.82, t)
		var centerline := center + axis * radii.x * longitudinal + Vector3.DOWN * radii.y * t * 0.14
		var points := PackedVector3Array()
		for index in range(sides):
			var angle := TAU * float(index) / float(sides) + float(station % 2) * 0.12
			var irregular := 1.0 + 0.09 * sin(angle * 3.0 + center.y * 2.1) + 0.06 * cos(angle * 5.0 + center.x * 1.7)
			var local := Vector3.UP * (cos(angle) * radii.y * section * irregular) + side * (sin(angle) * radii.z * section * irregular)
			points.append(centerline + local)
		loops.append(points)
	for ring in range(station_ratios.size() - 1):
		var brightness_factor := 0.80 + float(ring) * 0.065
		surface.set_color(tint * brightness_factor)
		for index in range(sides):
			var next_index := (index + 1) % sides
			surface.add_vertex(loops[ring][index])
			surface.add_vertex(loops[ring + 1][index])
			surface.add_vertex(loops[ring][next_index])
			surface.add_vertex(loops[ring][next_index])
			surface.add_vertex(loops[ring + 1][index])
			surface.add_vertex(loops[ring + 1][next_index])

func _append_conifer_canopy(surface: SurfaceTool, species: int, height: float, max_width: float) -> void:
	var sides := 28
	var tier_count := 7 if species == 0 else 6
	for tier in range(tier_count):
		var tier_fraction := float(tier) / float(tier_count)
		var base_y := 0.78 + tier_fraction * height * 0.82
		var radius := max_width * pow(maxf(0.035, 1.0 - tier_fraction), 0.76)
		var tier_height := height / float(tier_count) * (1.26 if species == 0 else 1.34)
		var rows := 5
		var tier_rings: Array[PackedVector3Array] = []
		for row in range(rows):
			var t := float(row) / float(rows - 1)
			var ring_radius := lerpf(radius * 0.62, radius * 0.98, 1.0 - t) + 0.02
			var y := base_y + t * tier_height
			var points := PackedVector3Array()
			for side in range(sides):
				var angle := TAU * float(side) / float(sides)
				var lobe := 1.0 + 0.16 * sin(angle * 7.0 + tier * 1.6) + 0.07 * cos(angle * 13.0 - tier)
				var droop := -0.055 * sin(angle * 6.0 + tier) * (1.0 - t)
				points.append(Vector3(cos(angle) * ring_radius * lobe, y + droop, sin(angle) * ring_radius * lobe * 0.92))
			tier_rings.append(points)
		for row in range(rows - 1):
			for side in range(sides):
				var next_side := (side + 1) % sides
				var a := tier_rings[row][side]
				var b := tier_rings[row + 1][side]
				var c := tier_rings[row][next_side]
				var d := tier_rings[row + 1][next_side]
				surface.add_vertex(a)
				surface.add_vertex(b)
				surface.add_vertex(c)
				surface.add_vertex(c)
				surface.add_vertex(b)
				surface.add_vertex(d)

func _build_shrub_mesh() -> ArrayMesh:
	var surface := SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for branch in range(13):
		var angle := TAU * float(branch) / 13.0
		var height := 0.42 + float(branch % 5) * 0.13
		var direction := Vector3(cos(angle), 0.2 + float(branch % 3) * 0.06, sin(angle)).normalized()
		var finish := direction * (0.38 + float(branch % 3) * 0.12) + Vector3(0.0, height, 0.0)
		_append_tapered_tube(surface, Vector3(0.0, 0.08, 0.0), finish, 0.06, 0.012, 4, angle)
		_append_leaf_cluster(surface, finish, (direction + Vector3.UP * 0.6).normalized(), 0.40 + float(branch % 2) * 0.08, 0.16)
		_append_leaf_cluster(surface, finish * 0.72 + Vector3(0.0, 0.12, 0.0), (direction + Vector3.UP * 0.25).normalized(), 0.32, 0.15)
	surface.index()
	surface.generate_normals()
	return surface.commit()

func _build_grass_mesh() -> ArrayMesh:
	var surface := SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	for blade in range(9):
		var angle := TAU * float(blade) / 9.0
		var direction := Vector3(cos(angle), 0.0, sin(angle))
		var height := 0.34 + float(blade % 4) * 0.075
		var width := 0.028 + float(blade % 3) * 0.008
		var root := Vector3.ZERO
		var mid := direction * height * 0.46 + Vector3(0.0, height * 0.62, 0.0)
		var tip := direction * height + Vector3(0.0, height, 0.0)
		var side := Vector3(-direction.z, 0.0, direction.x) * width
		surface.add_vertex(root - side)
		surface.add_vertex(mid - side * 0.58)
		surface.add_vertex(root + side)
		surface.add_vertex(root + side)
		surface.add_vertex(mid - side * 0.58)
		surface.add_vertex(mid + side * 0.58)
		surface.add_vertex(mid - side * 0.58)
		surface.add_vertex(tip)
		surface.add_vertex(mid + side * 0.58)
		surface.add_vertex(mid + side * 0.58)
		surface.add_vertex(tip)
		surface.add_vertex(mid - side * 0.58)
	surface.index()
	surface.generate_normals()
	return surface.commit()

func _build_deadfall_mesh() -> ArrayMesh:
	var surface := SurfaceTool.new()
	surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	_append_tapered_tube(surface, Vector3(-1.55, 0.0, 0.0), Vector3(1.5, 0.0, 0.0), 0.2, 0.135, 9, 1.7)
	for branch in range(4):
		var x := -1.0 + float(branch) * 0.62
		var direction := Vector3(0.12 * float(branch % 2), 0.25 + float(branch % 3) * 0.08, -0.34 if branch % 2 == 0 else 0.38)
		_append_tapered_tube(surface, Vector3(x, 0.03, 0.0), Vector3(x, 0.03, 0.0) + direction, 0.062, 0.014, 5, float(branch))
	surface.index()
	surface.generate_normals()
	return surface.commit()

func vegetation_line_transmission(from: Vector3, to: Vector3) -> float:
	var segment := to - from
	var segment_length_squared := segment.length_squared()
	if segment_length_squared <= 0.0001:
		return 1.0
	var transmission := 1.0
	for instance_name in ["ConiferTrunks_MultiMesh", "ConiferTrunks_Hemlock_MultiMesh", "ConiferTrunks_Snag_MultiMesh"]:
		transmission *= _multimesh_line_transmission(instance_name, from, segment, segment_length_squared, 0.28, 0.24)
	transmission *= _multimesh_line_transmission("Shrubs_MultiMesh", from, segment, segment_length_squared, 0.62, 1.0)
	return clampf(transmission, 0.24, 1.0)

func _multimesh_line_transmission(instance_name: String, from: Vector3, segment: Vector3,
		segment_length_squared: float, attenuation: float, horizontal_radius: float) -> float:
	var instance := get_node_or_null("Region/Cell_0_0/Dressing/Vegetation/%s" % instance_name) as MultiMeshInstance3D
	if instance == null or instance.multimesh == null:
		return 1.0
	var transforms: Array[Transform3D] = _vegetation_instance_transforms.get(instance_name, [])
	var transmission := 1.0
	for local_transform in transforms:
		var world_transform := instance.global_transform * local_transform
		var center := world_transform.origin
		var along := clampf((center - from).dot(segment) / segment_length_squared, 0.0, 1.0)
		var closest := from + segment * along
		var scale := world_transform.basis.get_scale()
		var dx := (closest.x - center.x) / maxf(0.01, horizontal_radius * scale.x)
		var dz := (closest.z - center.z) / maxf(0.01, horizontal_radius * scale.z)
		var is_trunk := instance_name.begins_with("ConiferTrunks_") or instance_name == "ConiferTrunks_MultiMesh"
		var vertical_radius := 4.4 * scale.y if is_trunk else 0.62 * scale.y
		if dx * dx + dz * dz <= 1.0 and absf(closest.y - center.y) <= vertical_radius:
			transmission *= attenuation
			if transmission <= 0.24:
				return 0.24
	return transmission

func debug_line() -> String:
	return "VISUAL: %s | cell=250m envelope=500x250 | terrain=%.0fm2 | elevation=5m | vegetation=%d | water=%s" % [presentation_profile, _terrain_area, _vegetation_count, "creek" if _water_present else "none"]
