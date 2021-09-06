extends Button

signal on_press(btn)

export (String, MULTILINE) var tooltip setget set_tooltip
export (NodePath) var tooltipPath = "/root/Main/ui/ToolTip"
onready var tooltipNode = get_node(tooltipPath)

# Atbitrary meta to carry
var meta

var _active = false

func _on_btn_mouse_entered():
	if tooltip:
		tooltipNode.setText(tooltip)
		_active = true

func _on_btn_mouse_exited():
	tooltipNode.clear()
	_active = false

func _on_btn_pressed():
	emit_signal("on_press", self)

func set_tooltip(new_value):
	tooltip = new_value
	if tooltipNode && _active:
		tooltipNode.setText(tooltip)
