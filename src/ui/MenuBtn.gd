extends ToolButton

export (NodePath) var targetPath

var target

func _ready():
	target = get_node(targetPath)
	pass

func _on_MenuBtn_toggled(pressed):
	(target as CanvasItem).visible = pressed