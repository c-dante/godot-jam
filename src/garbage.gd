extends Area

func _on_garbage_body_entered(body):
	body.transform.origin = Vector3(0, 10, 0)