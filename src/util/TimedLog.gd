extends Timer

var startAgain = false

func _physics_process(delta):
	if startAgain && is_stopped():
		startAgain = false
		start(wait_time)

func print(value):
	if is_stopped():
		print(value)
		startAgain = true
