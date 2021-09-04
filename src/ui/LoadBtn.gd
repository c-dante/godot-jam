extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var save = "user://test.save"
func _on_LoadBtn_pressed():
	# var file = File.new()
	# if file.file_exists(save):
	# 	file.open(save, File.READ)
	# 	var out = file.get_var(true)
	# 	file.close()
	# 	if out:
	# 		print(out)
	# 		get_tree().change_scene_to(out)
	# Load the PackedScene resource
	var packed_scene = load("user://test_scene.tscn")
	get_tree().change_scene_to(packed_scene)
