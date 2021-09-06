extends Area

func _on_garbage_body_entered(body):
	if body == $"/root/Main/Player":
		body.transform.origin = Vector3(0, 10, 0)
	else:
		if !body.is_queued_for_deletion():
			body.queue_free()
