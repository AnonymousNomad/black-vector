extends CanvasLayer

const MAX_LINES := 25

@export var player_group := "player"

@onready var label: Label = $StateLabel

var _player_cache: Node = null

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug_toggle_overlay"):
		visible = not visible
	if not visible:
		return
	var lines: Array[String] = []
	lines.append(_world_line())
	lines.append_array(_world_channels())
	lines.append(_player_line())
	lines.append_array(_player_stats())
	lines.append(_input_source())
	lines.append_array(_extra_lines())
	lines.append(_metrics())
	lines.append_array(_performance())
	label.text = "\n".join(lines)

func _world_line() -> String:
	var gw := get_tree().get_first_node_in_group("game_world")
	if gw == null:
		return "WORLD: (no GameWorld)"
	var ws: Node = gw.get_node_or_null("WorldState")
	if ws == null:
		return "WORLD: (no WorldState)"
	var snap: Dictionary = ws.call("snapshot") if ws.has_method("snapshot") else {}
	return "WORLD: seed=%s" % str(snap.get("seed", "?"))

func _world_channels() -> Array[String]:
	var out: Array[String] = []
	var gw := get_tree().get_first_node_in_group("game_world")
	if gw == null:
		return out
	var ws: Node = gw.get_node_or_null("WorldState")
	if ws == null or not ws.has_method("channel_value"):
		return out
	out.append("TIME: %s" % ws.call("channel_value", "TIME_OF_DAY"))
	out.append("WEATHER: %s" % ws.call("channel_value", "WEATHER"))
	out.append("FACILITY: %s" % ws.call("channel_value", "FACILITY_STATE"))
	out.append("AFTERMATH: %s" % ws.call("channel_value", "LOCAL_AFTERMATH"))
	var tw: TimeWeatherManager = gw.get_node_or_null("TimeWeather")
	if tw and tw.get("hour") != null:
		out.append("HOUR: %.2f" % tw.hour)
	var objs: Variant = ws.get("objects")
	if objs is Dictionary:
		out.append("OBJECTS: %d" % (objs as Dictionary).size())
	var obs: Variant = ws.get("observations")
	if obs is Dictionary:
		out.append("OBSERVATIONS: %d" % (obs as Dictionary).size())
	return out

func _player_line() -> String:
	if _player_cache == null:
		_player_cache = get_tree().get_first_node_in_group(player_group)
	if _player_cache == null:
		return "PLAYER: not found"
	if _player_cache.has_method("debug_snapshot"):
		return _player_cache.call("debug_snapshot")
	return "PLAYER: (no debug_snapshot)"

func _player_stats() -> Array[String]:
	var out: Array[String] = []
	var gw := get_tree().get_first_node_in_group("game_world")
	if gw == null:
		return out
	var ps: Node = gw.get_node_or_null("PlayerState")
	if ps == null or not ps.has_method("band"):
		return out
	out.append("CORE_TEMP: %.2f" % ps.call("band", "CORE_TEMP"))
	out.append("CONDITION: %.2f" % ps.call("band", "CONDITION"))
	out.append("EXERTION: %.2f" % ps.call("band", "EXERTION"))
	out.append("FATIGUE: %.2f" % ps.call("band", "FATIGUE"))
	out.append("INJURY: %.2f" % ps.call("band", "INJURY"))
	out.append("HUNGER: %.2f" % ps.call("band", "HUNGER"))
	out.append("THIRST: %.2f" % ps.call("band", "THIRST"))
	out.append("EXPOSURE: %.2f" % ps.call("band", "EXPOSURE"))
	return out

func _input_source() -> String:
	var im := get_tree().root.get_node_or_null("InputManager")
	if im == null:
		return "INPUT: (none)"
	var touch := im.get_node_or_null("TouchInputAdapter")
	if touch != null and touch.get("active"):
		return "INPUT: touch"
	var ctrl := im.get_node_or_null("ControllerAdapter")
	if ctrl != null and ctrl.get("connected"):
		return "INPUT: gamepad"
	return "INPUT: keyboard"

func _extra_lines() -> Array[String]:
	var out: Array[String] = []
	var gw := get_tree().get_first_node_in_group("game_world")
	if gw:
		var im: Node = gw.get_node_or_null("Interaction")
		if im:
			out.append("RESOLVED: %s (%d)" % [str(im.get("last_resolved")), int(im.get("resolved_count"))])
		var pres: Node = gw.get_node_or_null("Pressure")
		if pres:
			out.append("PRESSURE: rest=%s shelter=%s breath=%.2f" % [bool(pres.get("resting")), bool(pres.get("sheltered")), float(pres.get("breathing"))])
		var fi: Node = gw.get_node_or_null("FieldInterface")
		if fi:
			var eq: Dictionary = fi.call("equipped_item")
			if not eq.is_empty():
				out.append("GEAR: %s [%s]" % [str(eq.get("name", "")), str(fi.call("condition_label", float(eq.get("condition", 0.0))))])
			var surv: Dictionary = fi.call("survival_summary")
			if not surv.is_empty():
				out.append("WRIST: exh=%s exp=%s inj=%s" % [surv.get("exertion"), surv.get("exposure"), surv.get("injury")])
			var rec: Dictionary = fi.call("recon_summary")
			if not rec.is_empty():
				out.append("RECON: pois=%d traces=%d record=%d last=%s" % [int(rec.get("pois", 0)), int(rec.get("traces", 0)), int(rec.get("record", 0)), str(rec.get("last", ""))])
			if _player_cache is CharacterBody3D:
				var report: Dictionary = fi.call("position_report", _player_cache)
				if not report.is_empty():
					out.append("POSITION: %s cover=%.2f obs=%.2f risk=%.2f" % [str(report.get("classification", "")), float(report.get("concealment_quality", 0.0)), float(report.get("observation_quality", 0.0)), float(report.get("exposure_risk", 0.0))])
				var route: Dictionary = fi.call("route_report", _player_cache)
				if not route.is_empty():
					out.append("ROUTE: approach=%s disturbance=%s observation=%s (%s)" % [str(route.get("approach", "")), str(route.get("disturbance", "")), str(route.get("observation", "")), str(route.get("speed_band", ""))])
			var threats: Array = fi.call("threat_summary")
			if not threats.is_empty():
				var threat_line := ""
				for threat in threats:
					if threat_line != "":
						threat_line += ", "
					threat_line += str(threat)
				out.append("THREAT: " + threat_line)
			for node in get_tree().get_nodes_in_group("human_presence"):
				var presence := node as HumanPresence
				if presence:
					var awareness: Node = presence.get_node_or_null("Awareness")
					if awareness:
						out.append("PRESENCE: %s %s target=%s" % [presence.presence_id, str(awareness.call("state_name")), str(awareness.get("investigation_target"))])
			var contact_svc: Node = gw.get_node_or_null("Contact")
			if contact_svc:
				for node in get_tree().get_nodes_in_group("human_presence"):
					var presence := node as HumanPresence
					if presence:
						var reaction: HumanReaction = contact_svc.call("reaction_for", presence.presence_id)
						out.append("CONTACT: %s %s fear=%.2f conf=%.2f tolerance=%s intent=%s" % [
							presence.presence_id,
							str(contact_svc.call("state_name_for", presence.presence_id)),
							reaction.fear,
							reaction.confidence,
							reaction.contact_tolerance_band(),
							str(contact_svc.get("selected_intent")),
						])
			var presentation: Node = gw.get_node_or_null("Presentation")
			if presentation and presentation.has_method("line"):
				out.append(str(presentation.call("line")))
	var observer := get_tree().get_first_node_in_group("observer")
	if observer and observer.has_method("debug_line"):
		out.append(observer.call("debug_line"))
	var opponent := get_tree().get_first_node_in_group("training_opponent")
	if opponent and opponent.has_method("debug_line"):
		out.append(opponent.call("debug_line"))
	var visual_region := get_tree().get_first_node_in_group("visual_wilderness_region")
	if visual_region and visual_region.has_method("debug_line"):
		out.append(visual_region.call("debug_line"))
	var wilderness_audio := get_tree().get_first_node_in_group("wilderness_audio")
	if wilderness_audio and wilderness_audio.has_method("debug_line"):
		out.append(wilderness_audio.call("debug_line"))
	return out

func _metrics() -> String:
	return "MEM: %d KB | NODES: %d" % [
		Performance.get_monitor(Performance.MEMORY_STATIC),
		Performance.get_monitor(Performance.OBJECT_NODE_COUNT),
	]

func _performance() -> Array[String]:
	return ["FPS: %d" % Performance.get_monitor(Performance.TIME_FPS)]
