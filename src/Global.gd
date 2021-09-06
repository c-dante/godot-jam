extends Node

onready var SPAWN: Node = $"/root/Main/spawn"

const GROUP = {
	# Group of things that can be "killed", node must be named the group name
	"KILLABLE": "Killable",
	# The player and player owned things
	"PLAYER": "player",
	# All the arrows / projectiles
	"ARROW": "arrow",
	# All resources on the map
	"RESOURCE": "resource",
	# All neutral mob enemies
	"ENEMY": "Enemy",
}

var Rng = RandomNumberGenerator.new()

func _ready():
	_reset_state()

func _reset_state():
	print("RESET GLOBAL")
	Rng.seed = 8675309
	seed(Rng.seed)
	SPAWN = $"/root/Main/spawn"

func gatherResource(owner_instance_id: int, resource: int, amount: float):
	var inv = Resources.Inventory
	if !inv.has(owner_instance_id):
		inv[owner_instance_id] = {}
	if !inv[owner_instance_id].has(resource):
		inv[owner_instance_id][resource] = 0
	inv[owner_instance_id][resource] += amount
