extends Node
class_name Movement

export (NodePath) var nodePath = ""
export (float) var movementSpeed = 15
export (float) var acceleration = 3
export (float) var deacceleration = 5
export (float) var maxJump = 19
export (float) var rotationSpeed = 3
export (float) var maxZoom = 0.5
export (float) var minZoom = 1.5
export (float) var zoomSpeed = 2
export (float) var gravity = -10

var node: KinematicBody
var accelerate = acceleration
var movement = Vector3()
var speed = Vector3()
var currentVerticalSpeed = Vector3()
var direction = Vector3()
var lastDirection = Vector3()
var jumpAcceleration = 3
var isAirborne = false

func _ready():
	if nodePath:
		node = get_node(nodePath)
	else:
		node = get_parent();

func _physics_process(delta):
	# Apply movement direction
	direction.y = 0
	lastDirection = direction.normalized()
	var maxSpeed = movementSpeed * direction.normalized()
	accelerate = deacceleration
	if direction.dot(speed) > 0:
		accelerate = acceleration
	direction = Vector3.ZERO

	# Move and slide
	speed = speed.linear_interpolate(maxSpeed, delta * accelerate)
	movement = node.transform.basis * (speed)
	movement = speed
	currentVerticalSpeed.y += gravity * delta * jumpAcceleration
	movement += currentVerticalSpeed
	var _drop = node.move_and_slide(movement, Vector3.UP)
	if node.is_on_floor():
		currentVerticalSpeed.y = 0
		isAirborne = false

	# Respawn
	if node.transform.origin.y < -10:
		node.transform.origin = Vector3(0, 10, 0)