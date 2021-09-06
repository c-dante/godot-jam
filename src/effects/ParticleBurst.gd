extends Particles

func _ready():
	emitting = true

func _process(_delta):
	if !emitting && !is_queued_for_deletion():
		queue_free()