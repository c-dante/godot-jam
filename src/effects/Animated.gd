extends AnimationPlayer

func _on_finish(_name):
	get_parent().visible = false
	if !get_parent().is_queued_for_deletion():
		get_parent().queue_free()
