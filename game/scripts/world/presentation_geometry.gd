class_name PresentationGeometry
extends RefCounted

static func material(color: Color, roughness := 0.8, metallic := 0.0) -> StandardMaterial3D:
	var out := StandardMaterial3D.new()
	out.albedo_color = color
	out.roughness = roughness
	out.metallic = metallic
	return out

static func textured_material(kind: String, color_a: Color, color_b: Color, roughness := 0.8, metallic := 0.0) -> ShaderMaterial:
	var shader := Shader.new()
	var kind_code: int = int({"steel": 0, "wood": 1, "concrete": 2}.get(kind, 0))
	shader.code = """
	shader_type spatial;
	render_mode diffuse_burley, specular_schlick_ggx;
	uniform vec4 color_a : source_color = vec4(0.22, 0.25, 0.24, 1.0);
	uniform vec4 color_b : source_color = vec4(0.34, 0.30, 0.23, 1.0);
	uniform float base_roughness = 0.8;
	uniform float base_metallic = 0.0;
	uniform int material_kind = 0;
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
		float broad = noise21(world_position.xz * 0.41 + world_position.yy * 0.19);
		float grain = noise21(world_position.xy * 5.7) * 0.62 + noise21(world_position.xz * 13.0) * 0.38;
		float streak = smoothstep(0.68, 0.98, noise21(vec2(world_position.x * 3.1, world_position.y * 0.18)));
		vec3 base = mix(color_a.rgb, color_b.rgb, broad * 0.62 + grain * 0.22);
		if (material_kind == 0) {
			base = mix(base, vec3(0.22, 0.115, 0.064), streak * 0.38);
			base *= 0.86 + broad * 0.18;
		} else if (material_kind == 1) {
			float grainline = noise21(vec2(world_position.x * 2.2, world_position.y * 18.0 + world_position.z * 7.0));
			base = mix(base, color_b.rgb * 0.68, smoothstep(0.57, 0.76, grainline) * 0.38);
		} else if (material_kind == 2) {
			base = mix(base, vec3(0.12, 0.16, 0.16), streak * 0.26);
		}
		ALBEDO = base * mix(0.84, 1.08, grain);
		ROUGHNESS = clamp(base_roughness + (grain - 0.5) * 0.13, 0.35, 1.0);
		METALLIC = base_metallic;
	}
	"""
	var out := ShaderMaterial.new()
	out.shader = shader
	out.set_shader_parameter("color_a", color_a)
	out.set_shader_parameter("color_b", color_b)
	out.set_shader_parameter("base_roughness", roughness)
	out.set_shader_parameter("base_metallic", metallic)
	out.set_shader_parameter("material_kind", kind_code)
	return out

static func add_mesh(parent: Node, name: String, mesh: Mesh, material: Material, position := Vector3.ZERO) -> MeshInstance3D:
	var instance := MeshInstance3D.new()
	instance.name = name
	instance.mesh = mesh
	instance.material_override = material
	instance.position = position
	parent.add_child(instance)
	return instance

static func rounded_box_mesh(size: Vector3, bevel := 0.04, segments := 3) -> ArrayMesh:
	var mesh := ArrayMesh.new()
	var vertices := PackedVector3Array()
	var normals := PackedVector3Array()
	var indices := PackedInt32Array()
	var half := size * 0.5
	var radius := minf(bevel, minf(half.x, minf(half.y, half.z)) * 0.48)
	var faces := [
		[Vector3.RIGHT, Vector3.UP, Vector3.BACK],
		[Vector3.LEFT, Vector3.UP, Vector3.FORWARD],
		[Vector3.UP, Vector3.FORWARD, Vector3.RIGHT],
		[Vector3.DOWN, Vector3.BACK, Vector3.RIGHT],
		[Vector3.FORWARD, Vector3.UP, Vector3.RIGHT],
		[Vector3.BACK, Vector3.UP, Vector3.LEFT],
	]
	for face in faces:
		var normal: Vector3 = face[0]
		var axis_u: Vector3 = face[1]
		var axis_v: Vector3 = face[2]
		var base := vertices.size()
		for y in range(segments + 1):
			for x in range(segments + 1):
				var u := lerpf(-1.0, 1.0, float(x) / float(segments))
				var v := lerpf(-1.0, 1.0, float(y) / float(segments))
				var point := normal * half.dot(normal) + axis_u * half.dot(axis_u) * u + axis_v * half.dot(axis_v) * v
				var inner := Vector3(clampf(point.x, -half.x + radius, half.x - radius), clampf(point.y, -half.y + radius, half.y - radius), clampf(point.z, -half.z + radius, half.z - radius))
				var normal_at := (point - inner).normalized()
				vertices.append(inner + normal_at * radius)
				normals.append(normal_at)
		for y in range(segments):
			for x in range(segments):
				var a := base + y * (segments + 1) + x
				var b := a + 1
				var c := a + segments + 1
				var d := c + 1
				var u_v_outward := axis_u.cross(axis_v).dot(normal) > 0.0
				indices.append_array(PackedInt32Array([a, b, c, b, d, c]) if u_v_outward else PackedInt32Array([a, c, b, b, c, d]))
	var arrays := []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_INDEX] = indices
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return mesh

static func sphere_mesh(radius := 1.0, radial_segments := 20, rings := 12) -> ArrayMesh:
	var mesh := ArrayMesh.new()
	var vertices := PackedVector3Array()
	var normals := PackedVector3Array()
	var indices := PackedInt32Array()
	for ring in range(rings + 1):
		var latitude := -PI * 0.5 + PI * float(ring) / float(rings)
		for side in range(radial_segments):
			var angle := TAU * float(side) / float(radial_segments)
			var normal := Vector3(cos(latitude) * cos(angle), sin(latitude), cos(latitude) * sin(angle))
			vertices.append(normal * radius)
			normals.append(normal)
	for ring in range(rings):
		for side in range(radial_segments):
			var a := ring * radial_segments + side
			var b := ring * radial_segments + (side + 1) % radial_segments
			var c := (ring + 1) * radial_segments + side
			var d := (ring + 1) * radial_segments + (side + 1) % radial_segments
			indices.append_array(PackedInt32Array([a, c, b, b, c, d]))
	var arrays := []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_INDEX] = indices
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return mesh

static func pipe_mesh(length: float, radius: float, sides := 12) -> ArrayMesh:
	var mesh := ArrayMesh.new()
	var vertices := PackedVector3Array()
	var normals := PackedVector3Array()
	var indices := PackedInt32Array()
	var profile := [Vector2(0.0, 0.78), Vector2(0.06, 1.0), Vector2(0.2, 0.93), Vector2(0.78, 0.91), Vector2(0.94, 1.0), Vector2(1.0, 0.76)]
	for row in profile.size():
		var t: Vector2 = profile[row]
		for side in range(sides):
			var angle := TAU * float(side) / float(sides)
			vertices.append(Vector3(cos(angle) * radius * t.y, -length * 0.5 + length * t.x, sin(angle) * radius * t.y))
			normals.append(Vector3(cos(TAU * float(side) / float(sides)), 0.0, sin(TAU * float(side) / float(sides))))
	for row in range(profile.size() - 1):
		for side in range(sides):
			var a := row * sides + side
			var b := row * sides + (side + 1) % sides
			var c := (row + 1) * sides + side
			var d := (row + 1) * sides + (side + 1) % sides
			indices.append_array(PackedInt32Array([a, c, b, b, d, c]))
	var arrays := []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_INDEX] = indices
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return mesh

static func beam(parent: Node, name: String, from: Vector3, to: Vector3, radius: float, material: Material) -> MeshInstance3D:
	var axis := to - from
	var instance := add_mesh(parent, name, pipe_mesh(axis.length(), radius), material, (from + to) * 0.5)
	instance.quaternion = Quaternion(Vector3.UP, axis.normalized())
	return instance

static func rounded_prop(parent: Node, name: String, size: Vector3, material: Material, position: Vector3, bevel := 0.04) -> MeshInstance3D:
	return add_mesh(parent, name, rounded_box_mesh(size, bevel), material, position)

static func corrugated_panel(width: float, height: float, wave_depth := 0.025, wave_period := 0.32) -> ArrayMesh:
	var mesh := ArrayMesh.new()
	var vertices := PackedVector3Array()
	var normals := PackedVector3Array()
	var uvs := PackedVector2Array()
	var indices := PackedInt32Array()
	var columns := maxi(24, int(ceil(width / wave_period * 8.0)))
	var rows := 12
	for row in range(rows + 1):
		var y := height * float(row) / float(rows)
		for column in range(columns + 1):
			var u := float(column) / float(columns)
			var x := -width * 0.5 + width * u
			var wave := sin(x * TAU / wave_period) * wave_depth
			vertices.append(Vector3(x, y, wave))
			normals.append(Vector3(-cos(x * TAU / wave_period) * wave_depth * TAU / wave_period, 0.0, 1.0).normalized())
			uvs.append(Vector2(u * width, float(row) / float(rows) * height))
	for row in range(rows):
		for column in range(columns):
			var a := row * (columns + 1) + column
			var b := a + 1
			var c := a + columns + 1
			var d := c + 1
			indices.append_array(PackedInt32Array([a, b, c, b, d, c]))
	var arrays := []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_NORMAL] = normals
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_INDEX] = indices
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return mesh
