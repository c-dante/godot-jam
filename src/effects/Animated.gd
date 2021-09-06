extends AnimationPlayer

func _on_finish(_name):
	print(get_parent().global_transform.origin)
	get_parent().visible = false
	get_parent().queue_free()
