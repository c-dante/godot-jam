extends Control

export (Vector2) var OFFSET = Vector2(10, 10)

func _ready():
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Text.rect_position = get_viewport().get_mouse_position() + OFFSET

func setText(text: String):
	$Text.bbcode_text = text
	visible = true

func clear():
	visible = false
