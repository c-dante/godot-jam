extends Node
class_name Bow

const Arrow = preload("res://src/weapons/arrow.tscn")

export (NodePath) var meshPath
onready var mesh: Spatial = get_node(meshPath)

export (int) var owner_id
export (bool) var active = true

export (float) var cooldown = 1
onready var cool = cooldown

# Upgrades
const COOLDOWN_REDUCTION = 0.15
export (int) var cooldownLevel = 0
export (int) var piercingLevel = 0

# Res.UpgradeType -> int
var upgrades = {}

func _physics_process(delta):
	if cool > 0:
		cool -= delta
		return

	if active && Input.is_action_pressed("fire"):
		cool = max(0.2, cooldown - COOLDOWN_REDUCTION * cooldownLevel)
		var meshxform = mesh.get_global_transform()
		var arrow = Arrow.instance()
		arrow.owner_id = owner_id
		arrow.set_translation(meshxform.origin)
		arrow.rotate_y(PI + mesh.rotation.y)
		arrow.piercing = piercingLevel + 1
		Global.SPAWN.add_child(arrow)
