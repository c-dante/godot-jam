extends Node

const Arrow = preload("res://src/weapons/arrow.tscn")

export (NodePath) var meshPath
onready var mesh: Spatial = get_node(meshPath)

export (bool) var active = true

export (float) var cooldown = 1
onready var cool = cooldown

func _physics_process(delta):
	if cool > 0:
		cool -= delta
		return

	if active && Input.is_action_pressed("fire"):
		cool = cooldown
		print("PEW", Global.SPAWN)
		var meshxform = mesh.get_global_transform()
		var arrow = Arrow.instance()
		arrow.set_translation(meshxform.origin)
		arrow.rotate_y(PI + mesh.rotation.y)
		Global.SPAWN.add_child(arrow)
