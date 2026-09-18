class_name GameWorld
extends Node

const TIME_WEATHER := "TimeWeather"
const PLAYER_STATE := "PlayerState"
const INTERACTION := "Interaction"
const SAVE_STATE := "SaveState"
const AUDIO := "Audio"
const PRESSURE := "Pressure"
const FIELD_INTERFACE := "FieldInterface"
const RECON := "Recon"
const TACTICAL := "Tactical"
const WORLD_CHANNELS := "WorldState"
const NARRATIVE := "Narrative"
const CONTACT := "Contact"
const PRESENTER := "Presentation"
const CANNERY := "CanneryState"
const BEATS := "BeatStaging"

@export var slice_seed := 0

var time_weather: TimeWeatherManager
var player_state: PlayerStateManager
var world_state: WorldStateManager
var interaction: InteractionManager
var save_state: SaveStateManager
var audio: AudioManager
var pressure: PressureManager
var field_interface: FieldInterface
var recon: ReconManager
var tactical: TacticalManager
var narrative: NarrativeChannels
var contact: ContactManager
var presenter: NarrativePresenter
var cannery: CanneryState
var beats: BeatStaging
var _player_body: BodyState
var _player_signature: SignatureController
var _move_trace_accum := 0.0
var _route_anchor := Vector3.ZERO
var _route_anchor_valid := false
var _presence_awareness: Array[HumanAwareness] = []

func _enter_tree() -> void:
	add_to_group("game_world")

func _ready() -> void:
	build_services()
	wire_services()
	if slice_seed != 0:
		world_state.seed(slice_seed)
	else:
		world_state.seed(randi())
	player_state.seed_value = world_state.seed_value
	wire_player()
	wire_input()
	wire_presences()

func build_services() -> void:
	world_state = WorldStateManager.new()
	world_state.name = WORLD_CHANNELS
	add_child(world_state)
	audio = AudioManager.new()
	audio.name = AUDIO
	add_child(audio)
	time_weather = TimeWeatherManager.new()
	time_weather.name = TIME_WEATHER
	add_child(time_weather)
	player_state = PlayerStateManager.new()
	player_state.name = PLAYER_STATE
	player_state.add_to_group("player_state")
	add_child(player_state)
	interaction = InteractionManager.new()
	interaction.name = INTERACTION
	add_child(interaction)
	pressure = PressureManager.new()
	pressure.name = PRESSURE
	add_child(pressure)
	field_interface = FieldInterface.new()
	field_interface.name = FIELD_INTERFACE
	add_child(field_interface)
	recon = ReconManager.new()
	recon.name = RECON
	add_child(recon)
	tactical = TacticalManager.new()
	tactical.name = TACTICAL
	add_child(tactical)
	narrative = NarrativeChannels.new()
	narrative.name = NARRATIVE
	add_child(narrative)
	contact = ContactManager.new()
	contact.name = CONTACT
	add_child(contact)
	presenter = NarrativePresenter.new()
	presenter.name = PRESENTER
	add_child(presenter)
	save_state = SaveStateManager.new()
	save_state.name = SAVE_STATE
	add_child(save_state)
	cannery = CanneryState.new()
	cannery.name = CANNERY
	add_child(cannery)
	beats = BeatStaging.new()
	beats.name = BEATS
	add_child(beats)

func wire_services() -> void:
	time_weather.setup(world_state)
	time_weather.tick(0.0)
	world_state.clock_hour = time_weather.hour
	interaction.setup(world_state)
	pressure.setup(world_state, time_weather, player_state, audio)
	field_interface.setup(player_state, world_state, tactical)
	recon.setup(world_state, tactical)
	tactical.setup(world_state)
	narrative.setup(world_state)
	contact.setup(world_state, narrative, recon)
	recon.contact = contact
	presenter.bind(narrative)
	player_state.seed_equipment(FieldItem.baseline_kit())
	save_state.setup(world_state, player_state, time_weather, pressure)
	save_state.load_completed.connect(_on_load_completed)
	var cannery_root := get_node_or_null("GyleCannery") as Node3D
	if cannery_root:
		cannery.setup(world_state, save_state, cannery_root)
	else:
		push_warning("D032: GyleCannery sub-scene not found")
	beats.setup(world_state, narrative)
	beats.stage_awakening()
	world_state.channel_changed.connect(_on_channel_changed)
	interaction.action_resolved.connect(_on_action_resolved)
	add_to_group("game_world")

func _on_load_completed(_slot: int) -> void:
	var player := get_tree().get_first_node_in_group("player") as Node3D
	if player:
		player.global_position = player_state.position
		var cam := player.get_node_or_null("CameraRig") as Node3D
		if cam:
			cam.global_position = player_state.position
	for awareness in _presence_awareness:
		if awareness.presence:
			awareness.restore_from(world_state.awareness_record(awareness.presence.presence_id))
	if contact:
		contact.restore_from(world_state.contact_records)

func _on_channel_changed(channel: String) -> void:
	if channel == world_state.CHANNEL_WEATHER and audio:
		audio.set_weather_audio(world_state.channel_value(world_state.CHANNEL_WEATHER))

func _on_action_resolved(action: String, _object_id: String) -> void:
	if action == "REST" or action == "RECOVER":
		pressure.start_rest()
	elif action == "SURVEY":
		var player := get_tree().get_first_node_in_group("player") as CharacterBody3D
		if player:
			recon.survey(player)

func wire_player() -> void:
	var player := get_tree().get_first_node_in_group("player")
	if player:
		player_state.register_player(player)
		var probe: Node = player.get_node_or_null("InteractionProbe")
		if probe is InteractionProbe:
			var typed_probe := probe as InteractionProbe
			interaction.accept_probe(typed_probe)
			if not typed_probe.activated.is_connected(interaction.on_object_activated):
				typed_probe.activated.connect(interaction.on_object_activated)
		var body_state: Node = player.get_node_or_null("BodyState")
		if body_state is BodyState:
			_player_body = body_state as BodyState
			_player_body.bind(player_state)
		var signature: Node = player.get_node_or_null("SignatureController")
		if signature is SignatureController:
			_player_signature = signature as SignatureController
			if not _player_signature.noise_event.is_connected(_on_noise_event):
				_player_signature.noise_event.connect(_on_noise_event)

func wire_input() -> void:
	var settings := get_tree().root.get_node_or_null("Settings")
	if settings and settings.get("profile") != null:
		var im := get_tree().root.get_node_or_null("InputManager")
		if im and im.has_method("configure"):
			im.call("configure", settings.profile)

func wire_presences() -> void:
	for node in get_tree().get_nodes_in_group("human_presence"):
		var presence := node as HumanPresence
		if presence:
			presence.bind(world_state)
			presence.record_evidence()
			var awareness := presence.get_node_or_null("Awareness") as HumanAwareness
			if awareness:
				awareness.bind(presence, world_state, recon)
				awareness.restore_from(world_state.awareness_record(presence.presence_id))
				_presence_awareness.append(awareness)

func _process(_delta: float) -> void:
	time_weather.tick(_delta)
	if Input.is_action_just_pressed("debug_save"):
		save_state.save_slot(0)
	if Input.is_action_just_pressed("debug_load"):
		save_state.load_slot(0)
	if Input.is_action_just_pressed("contact_speak"):
		contact.speak_selected()
	if Input.is_action_just_pressed("contact_cycle"):
		contact.cycle_intent()
	var player := get_tree().get_first_node_in_group("player")
	if player is CharacterBody3D:
		pressure.update(_delta, player)
		if _player_body:
			_player_body.set_condition(pressure.condition)
		if _player_signature:
			_player_signature.set_environment(world_state.channel_value(world_state.CHANNEL_WEATHER), pressure.breathing, pressure.condition)
		world_state.clock_hour = time_weather.hour
		_record_move_trace(player, _delta)
		_record_route_traversal(player)
		for awareness in _presence_awareness:
			awareness.update(_delta, player)
		contact.update(_delta, player)
		player_state.position = player.global_position
		if interaction.probe != null:
			interaction.resolve(false)

func _record_move_trace(player: CharacterBody3D, delta: float) -> void:
	if _player_signature == null or not player.is_on_floor():
		return
	var speed := Vector2(player.velocity.x, player.velocity.z).length()
	if speed <= 0.5:
		return
	_move_trace_accum += delta
	if _move_trace_accum < 0.25:
		return
	_move_trace_accum = 0.0
	world_state.record_trace("FOOTPRINT", player.global_position, _player_signature.trace_intensity(), "")

func _on_noise_event(origin: Vector3, volume: float, kind: String) -> void:
	world_state.record_trace("SOUND", origin, volume, kind)

func _record_route_traversal(player: CharacterBody3D) -> void:
	if tactical == null:
		return
	if not _route_anchor_valid:
		_route_anchor = player.global_position
		_route_anchor_valid = true
		return
	if player.global_position.distance_to(_route_anchor) < 4.0:
		return
	var route := tactical.assess_route(player, _route_anchor, player.global_position)
	world_state.record_route(_route_anchor, player.global_position, str(route.get("classification", "")), float(route.get("disturbance_risk", 0.0)))
	world_state.add_field_entry("ROUTE TRAVERSED", "segment", str(route.get("classification", "")).to_lower(), player.global_position)
	_route_anchor = player.global_position