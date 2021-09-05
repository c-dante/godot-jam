extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var save = "user://test.save"
func _on_SaveBtn_pressed():
	# var file = File.new()
	# file.open(save, File.WRITE)
	# print($"/root/Main")
	# file.store_var($"/root/Main", true)
	# file.close()
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	if ResourceSaver.save("user://test_scene.tscn", packed_scene) != OK:
		print("Failed to save!")
