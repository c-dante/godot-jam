extends Node

enum ResourceType { Stone, Wood }

static func resourceString(res):
	match res:
		ResourceType.Stone:
			return "Stone"
		ResourceType.Wood:
			return "Wood"

# Items
enum ItemType { Miner, Bow }

static func itemString(res):
	match res:
		ItemType.Miner:
			return "Miner"
		ItemType.Bow:
			return "Bow"

# Order here is order in the build menu
var Items = {
	ItemType.Miner: {
		"cost": { ResourceType.Stone: 20 },
		"desc": "Drop near resources to auto-mine them.",
		"icon": "res://assets/icon/Pickaxe.png"
	},
	ItemType.Bow: {
		"cost": { ResourceType.Wood: 10 },
		"desc": "Defend yourself.",
		"icon": "res://assets/icon/Bow.png"
	}
}

# Object.instance_id -> ResourceType -> int
var Inventory = {}
