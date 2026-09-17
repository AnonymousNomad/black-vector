class_name DataPaths
extends RefCounted

const SAVE_SCHEMA_VERSION := 1
const SAVE_DIR := "user://saves/slice"
const SETTINGS_PATH := "user://settings/slice_settings.cfg"
const FIXTURE_RECORD_DIR := "res://data/fixture"

static func ensure_save_dir() -> void:
	DirAccess.make_dir_recursive_absolute(SAVE_DIR)

static func save_path(slot: int) -> String:
	return SAVE_DIR.path_join("slot_%02d.save" % slot)

static func ensure_settings_dir() -> void:
	DirAccess.make_dir_recursive_absolute(SETTINGS_PATH.get_base_dir())