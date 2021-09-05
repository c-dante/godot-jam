extends Node
class_name Movement

export (NodePath) var nodePath = ""

# Agument this to speed up
export (float) var movementSpeed = 15

# How fast the movemnet speed is applied
export (float) var acceleration = 3

# Skidding out
export (float) var deacceleration = 5

# Max jump height
export (float) var maxJump = 19

# Become floaty
export (float) var gravity = -10

# Set this to move in a direction
var direction = Vector3()

# Internals
var node: KinematicBody
var accelerate = acceleration
var movement = Vector3()
var speed = Vector3()
var currentVerticalSpeed = Vector3()
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
