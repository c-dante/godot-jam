extends Spatial


export (int) var owner_id
export (float) var speed = 25.0
const FORWARD = Vector3(0, 0, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	translate_object_local(speed * delta * FORWARD)