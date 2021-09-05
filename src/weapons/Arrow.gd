extends Spatial

const FORWARD = Vector3(0, 0, 1)
const LIFETIME = 3

export (int) var owner_id
export (float) var speed = 25.0

func _ready():
	if get_tree().create_timer(LIFETIME).connect("timeout", self, "_on_timeout") != OK:
		push_error("Failed to create timer")
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	translate_object_local(speed * delta * FORWARD)

func _on_timeout():
	queue_free()

func _on_arrow_body_entered(body):
	if body.get_instance_id() != owner_id:
		print("Arrow struck", body, body.get_path())
		queue_free()