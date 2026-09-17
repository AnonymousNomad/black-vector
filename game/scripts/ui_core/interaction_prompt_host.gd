extends CanvasLayer

var _label: Label

func _ready() -> void:
	_label = Label.new()
	_label.name = "PromptLabel"
	_label.offset_left = 10.0
	_label.offset_bottom = 60.0
	_label.offset_right = 400.0
	_label.offset_top = 40.0
	_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_label.add_theme_color_override("font_color", Color(1.0, 0.95, 0.85, 1.0))
	_label.add_theme_font_size_override("font_size", 20)
	add_child(_label)
	visible = false

func _process(_delta: float) -> void:
	var gw := get_tree().get_first_node_in_group("game_world")
	if gw == null:
		visible = false
		return
	var im: Node = gw.get_node_or_null("Interaction")
	if im == null:
		visible = false
		return
	var action: String = im.get("current_action") if im.has_method("get") else ""
	if action == "":
		visible = false
	else:
		visible = true
		_label.text = action.capitalize()