extends Node

const SETTINGS_VERSION := 1

var profile: InputProfile
var _ops: String = ""

func _ready() -> void:
	load_settings()

func load_settings() -> void:
	_ops = str(FileAccess.get_open_error())
	var cfg := ConfigFile.new()
	var err := cfg.load(DataPaths.SETTINGS_PATH)
	if err != OK:
		profile = InputProfile.new()
		_ops = "default"
		return
	var v: int = cfg.get_value("meta", "version", 0)
	if v != SETTINGS_VERSION:
		profile = InputProfile.new()
		_ops = "rebuilt:%d" % v
		return
	profile = InputProfile.new()
	profile.look_sensitivity = cfg.get_value("controls", "look_sensitivity", profile.look_sensitivity)
	profile.invert_look_y = cfg.get_value("controls", "invert_look_y", profile.invert_look_y)
	profile.mirror_layout = cfg.get_value("controls", "mirror_layout", profile.mirror_layout)
	profile.controller_preferred = cfg.get_value("controls", "controller_preferred", profile.controller_preferred)
	_ops = "loaded"
	DataPaths.ensure_settings_dir()
	if bool(cfg.get_value("meta", "commit", false)):
		_ops += ":commit"
	else:
		_ops += ":uncommitted"

func save_settings() -> void:
	DataPaths.ensure_settings_dir()
	var cfg := ConfigFile.new()
	cfg.set_value("meta", "version", SETTINGS_VERSION)
	cfg.set_value("controls", "look_sensitivity", profile.look_sensitivity)
	cfg.set_value("controls", "invert_look_y", profile.invert_look_y)
	cfg.set_value("controls", "mirror_layout", profile.mirror_layout)
	cfg.set_value("controls", "controller_preferred", profile.controller_preferred)
	var err := cfg.save(DataPaths.SETTINGS_PATH)
	_ops = "written:%d" % err

func version() -> int:
	return SETTINGS_VERSION