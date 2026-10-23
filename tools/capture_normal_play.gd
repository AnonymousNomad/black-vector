extends SceneTree

const MAIN_SCENE := "res://scenes/slice/slice_main.tscn"
const DEFAULT_CAPTURE_DIR := "res://../cloud/evidence/bv-visual-production"

var _scene: Node
var _player: CharacterBody3D
var _region: VisualWildernessProof1
var _game_world: GameWorld
var _capture_dir := ""

func _initialize() -> void:
	call_deferred("_capture_suite")

func _capture_suite() -> void:
	DisplayServer.window_set_size(Vector2i(1280, 720))
	var packed := load(MAIN_SCENE) as PackedScene
	if packed == null:
		push_error("Normal-play capture failed to load the main playable scene.")
		await _orderly_shutdown(1)
		return
	_scene = packed.instantiate()
	root.add_child(_scene)
	await _wait_frames(12)
	_player = get_first_node_in_group("player") as CharacterBody3D
	_region = get_first_node_in_group("visual_wilderness_region") as VisualWildernessProof1
	_game_world = get_first_node_in_group("game_world") as GameWorld
	if _player == null or _region == null or _game_world == null:
		push_error("Normal-play capture could not find the player, wilderness region, or game systems.")
		await _orderly_shutdown(1)
		return
	_capture_dir = OS.get_environment("BV_CAPTURE_DIR")
	if _capture_dir.is_empty():
		_capture_dir = ProjectSettings.globalize_path(DEFAULT_CAPTURE_DIR)
	DirAccess.make_dir_recursive_absolute(_capture_dir)
	var strand_floor := _scene.get_node_or_null("SectorS1/StrandFloor/MeshInstance3D") as MeshInstance3D
	var terrain := _scene.get_node_or_null("VisualWildernessProof1/Region/Cell_0_0/Terrain/TerrainBase/TerrainMesh") as MeshInstance3D
	var terrain_material := terrain.get_active_material(0) as ShaderMaterial if terrain else null
	var ground_texture := terrain_material.get_shader_parameter("terrain_albedo") as Resource if terrain_material else null
	print("CAPTURE RUNTIME renderer=%s strand_floor_visible=%s terrain_material=%s profile=%s" % [
		RenderingServer.get_video_adapter_name(), strand_floor.visible if strand_floor else "missing",
		terrain.get_active_material(0).get_class() if terrain and terrain.get_active_material(0) else "missing",
		_region.presentation_profile])
	print("CAPTURE TERRAIN texture=%s vertices=%d clearing_visible=%s" % [ground_texture.resource_path if ground_texture else "missing", (terrain.mesh.surface_get_array_len(0) if terrain and terrain.mesh else 0), (_scene.get_node_or_null("VisualWildernessProof1/Region/Cell_0_0/Dressing/Clearing") as MeshInstance3D).visible])
	if OS.get_environment("BV_CAPTURE_ONLY") == "terrain-probe":
		await _pose(Vector3(0.0, 0.0, 0.0), 0.0, -0.12)
		await _capture("terrain-probe-1280x720.png")
		await _orderly_shutdown(0)
		return
	if OS.get_environment("BV_CAPTURE_ONLY") == "shoreline":
		await _pose(Vector3(0.0, 0.0, -30.0), 0.0, -0.24, 5.0)
		await _capture("05-shoreline-water-1280x720.png")
		await _orderly_shutdown(0)
		return

	# All frames are captured from the actual game scene, using its player, camera
	# rig, terrain, world state, presentation contract and normal traversal input.
	await _pose(Vector3(0.0, 0.0, 0.0), -PI * 0.5, -0.12)
	await _capture("01-opening-wide-1280x720.png")

	await _pose(Vector3(-2.0, 0.0, 0.0), 0.0, -0.12, 3.25)
	await _capture("02-corley-rear-gameplay-1280x720.png")

	await _pose(Vector3(0.0, 0.0, 0.0), 0.0, -0.12, 3.15, PI - 0.34)
	await _capture("03-corley-front-three-quarter-1280x720.png")

	await _pose(Vector3(42.0, 0.0, 0.0), -0.15, -0.16, 4.2)
	Input.action_press("move_forward", 1.0)
	await _wait_frames(32)
	await _capture("04-wilderness-traversal-1280x720.png")
	Input.action_release("move_forward")

	await _pose(Vector3(0.0, 0.0, -30.0), 0.0, -0.24)
	await _capture("05-shoreline-water-1280x720.png")

	await _pose(Vector3(12.0, 0.0, 0.0), -PI * 0.5, -0.12)
	await _capture("06-industrial-exterior-1280x720.png")

	await _pose(Vector3(23.0, 0.0, 0.0), 2.13, -0.13, 3.8)
	await _capture("07-cannery-interior-1280x720.png")

	_game_world.time_weather.restore_clock(20.0, "STORM")
	_game_world.world_state.set_channel(WorldStateManager.CHANNEL_TIME, "DUSK")
	_game_world.world_state.set_channel(WorldStateManager.CHANNEL_WEATHER, "STORM")
	await _pose(Vector3(12.0, 0.0, 0.0), -PI * 0.5, -0.12, 4.2)
	await _capture("08-low-light-storm-1280x720.png")

	_game_world.time_weather.restore_clock(9.0, "CLEAR")
	_game_world.world_state.set_channel(WorldStateManager.CHANNEL_TIME, "DAY")
	_game_world.world_state.set_channel(WorldStateManager.CHANNEL_WEATHER, "CLEAR")
	await _pose(Vector3(23.0, 0.0, 0.0), 2.13, -0.13, 3.8)
	Input.action_press("interact")
	await _wait_frames(8)
	Input.action_release("interact")
	var interaction := _game_world.get_node_or_null("Interaction") as InteractionManager
	print("INTERACTION CAPTURE action=%s resolved=%s" % [interaction.current_action if interaction else "missing", interaction.last_resolved if interaction else "missing"])
	await _capture("09-interaction-gameplay-1280x720.png")

	await _pose(Vector3(4.0, 0.0, 0.0), -0.70, -0.16, 3.8)
	var contract := _player.get_node_or_null("CharacterPresentation") as CharacterPresentationContract
	if contract:
		contract.set_combat_stance(true)
	await _capture("10-tactical-gameplay-1280x720.png")
	if contract:
		contract.set_combat_stance(false)

	await _orderly_shutdown(0)

func _pose(horizontal: Vector3, yaw: float, pitch: float, camera_distance := 5.0, camera_yaw_offset := 0.0) -> void:
	var terrain_y: float = _region.call("_terrain_height", horizontal.x, horizontal.z)
	var position := Vector3(horizontal.x, terrain_y + 0.06, horizontal.z)
	_player.velocity = Vector3.ZERO
	_player.global_position = position
	_player.rotation = Vector3(0.0, yaw, 0.0)
	var rig := _player.get_node("CameraRig") as CameraRig
	rig.set("_follow_initialized", true)
	rig.global_position = position + Vector3.UP * 1.62
	rig.rotation.y = camera_yaw_offset
	rig.pitch_pivot.rotation.x = pitch
	var spring := rig.get_node("PitchPivot/SpringArm3D") as SpringArm3D
	spring.spring_length = camera_distance
	var animation := _player.get_node_or_null("AnimationState") as AnimationState
	if animation:
		animation.present(AnimationState.IDLE, "STAND", 0.0)
	await _wait_frames(8)

func _capture(file_name: String) -> void:
	await _wait_frames(3)
	var rig := _player.get_node("CameraRig") as CameraRig
	var spring := rig.get_node("PitchPivot/SpringArm3D") as SpringArm3D
	var camera := rig.get_node("PitchPivot/SpringArm3D/Camera3D") as Camera3D
	print("CAPTURE CAMERA %s player=%s camera=%s arm=%.2f/%.2f" % [file_name, _player.global_position, camera.global_position, spring.get_hit_length(), spring.spring_length])
	var image := root.get_texture().get_image()
	if image == null or image.is_empty():
		push_error("Normal-play viewport returned an empty image: %s" % file_name)
		return
	var output := _capture_dir.path_join(file_name)
	var error := image.save_png(output)
	if error != OK:
		push_error("Failed to save normal-play capture %s: %s" % [output, error_string(error)])
	else:
		print("NORMAL-PLAY CAPTURE %s %dx%d" % [output, image.get_width(), image.get_height()])
	image.clear_mipmaps()

func _wait_frames(count: int) -> void:
	for _frame in range(count):
		await physics_frame

func _orderly_shutdown(exit_code: int) -> void:
	Input.action_release("move_forward")
	for audio in get_nodes_in_group("wilderness_audio"):
		if audio.has_method("shutdown_audio"):
			audio.call("shutdown_audio")
	await create_timer(0.15).timeout
	quit(exit_code)
