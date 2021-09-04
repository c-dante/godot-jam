extends "res://src/Movement.gd"

export (NodePath) var cameraPath = ""

var camera: Camera

func _ready():
	print("CHILD READY")
	if !cameraPath:
		push_error("Camera path required")
	camera = get_node(cameraPath)
	print(camera)

func _physics_process(delta):
	var cameraTransform = camera.get_global_transform()
	if Input.is_action_pressed("move_up"):
		direction += -cameraTransform.basis[2]
	if Input.is_action_pressed("move_down"):
		direction += cameraTransform.basis[2]
	if Input.is_action_pressed("move_left"):
		direction += -cameraTransform.basis[0]
	if Input.is_action_pressed("move_right"):
		direction += cameraTransform.basis[0]
