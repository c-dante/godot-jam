extends Spatial

class_name Bar

export (float) var progress = 0.5
onready var filling: Spatial = $"inside"

func _process(_delta):
	# Look at viewport
	var view = get_viewport()
	var cam = get_viewport().get_camera()
	var rect = view.get_visible_rect()
	var center = rect.position + rect.end / 2
	var eye = cam.project_position(center, 0)
	look_at(eye, Vector3.UP)

	# Scale for progress
	filling.scale.x = clamp(progress, 0, 1)
