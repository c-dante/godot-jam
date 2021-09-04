extends Timer

var startAgain = false

func _ready():
	wait_time = 0.1
	one_shot = true

func _physics_process(_delta):
	if startAgain && is_stopped():
		startAgain = false
		start(wait_time)

func print(value):
	if is_stopped():
		print(value)
		startAgain = true
