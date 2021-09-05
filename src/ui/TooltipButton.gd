extends Button

signal on_press(owner)

export (String, MULTILINE) var tooltip
export (NodePath) var tooltipPath = "/root/Main/ui/ToolTip"
onready var tooltipNode = get_node(tooltipPath)

# Atbitrary meta to carry
var meta

func _on_btn_mouse_entered():
	if tooltip:
		tooltipNode.setText(tooltip)

func _on_btn_mouse_exited():
	tooltipNode.clear()

func _on_btn_pressed():
	emit_signal("on_press", self)
