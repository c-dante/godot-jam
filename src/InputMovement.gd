extends "res://src/Movement.gd"
const Global = preload("res://src/Global.gd")

onready var view = get_viewport()

var ray_length = 1000
export (NodePath) var test
func _ready():
	print(Global.test())

func _physics_process(delta):
	var camera = view.get_camera()

	# Handle camera based movement
	var cameraTransform = camera.get_global_transform()
	if Input.is_action_pressed("move_up"):
		direction += -cameraTransform.basis[2]
	if Input.is_action_pressed("move_down"):
		direction += cameraTransform.basis[2]
	if Input.is_action_pressed("move_left"):
		direction += -cameraTransform.basis[0]
	if Input.is_action_pressed("move_right"):
		direction += cameraTransform.basis[0]

	# Player rotation to mouse target
	var mouse = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse)
	var to = from + camera.project_ray_normal(mouse) * ray_length
	var space_state = node.get_world().direct_space_state
	var intersections = space_state.intersect_ray(from, to, [], 1 << 19)
	$"/root/Main/TimedLog".print(intersections)

