extends Button

export (String, MULTILINE) var tooltip
export (NodePath) var tooltipPath = "/root/Main/ui/main/ToolTip"
onready var tooltipNode = get_node(tooltipPath)

func _on_btn_mouse_entered():
	if tooltip:
		tooltipNode.setText(tooltip)

func _on_btn_mouse_exited():
	tooltipNode.clear()
