extends Node

onready var SPAWN = $"/root/Main/spawn"

const GROUP = {
	"PLAYER": "player",
	"ARROW": "arrow",
	"RESOURCE": "resource",
}

static func test():
	print("Hi")
	return 10

func gatherResource(owner_instance_id: int, resource: int, amount: float):
	var inv = Resources.Inventory
	if !inv.has(owner_instance_id):
		inv[owner_instance_id] = {}
	if !inv[owner_instance_id].has(resource):
		inv[owner_instance_id][resource] = 0
	inv[owner_instance_id][resource] += amount
