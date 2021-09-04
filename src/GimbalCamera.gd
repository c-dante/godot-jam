extends Spatial

export (float) var turnSpeed = 2.0

func _physics_process(delta):
	if Input.is_action_pressed("turn_cw"):
		rotate_y(turnSpeed * -delta)
	if Input.is_action_pressed("turn_ccw"):
		rotate_y(turnSpeed * delta)
