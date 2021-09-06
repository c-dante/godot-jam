extends AnimationPlayer

func _on_finish(_name):
	get_parent().visible = false
	get_parent().queue_free()
