extends "res://src/Movement.gd"

onready var view = get_viewport()

export (NodePath) var meshPath
onready var mesh: Spatial = get_node(meshPath)

var plane: Plane = Plane(Vector3.UP, 0)
var baseMax: float = movementSpeed

func _physics_process(_delta):
	var camera = view.get_camera()
	plane.d = node.transform.origin.y

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
	if Input.is_action_pressed("sprint"):
		movementSpeed = baseMax * 2
	else:
		movementSpeed = baseMax

	# Player rotation to mouse target
	var mouse = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse)
	var facing = plane.intersects_ray(from, camera.project_ray_normal(mouse))
	if facing:
		# Set the position's y to the player's y so we only turn to face
		facing.y = mesh.global_transform.origin.y
		mesh.look_at(facing, Vector3.UP)
