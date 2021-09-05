extends ToolButton

export (NodePath) var targetPath

var target

func _ready():
	target = get_node(targetPath)
	(target as CanvasItem).visible = self.pressed
	pass

func _on_MenuBtn_toggled(pressed):
	(target as CanvasItem).visible = pressed
