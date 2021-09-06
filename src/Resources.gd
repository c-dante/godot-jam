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

# Checks if a given inventorty can afford a cost
static func canAfford(inv, cost):
	for mat in cost:
		if !inv.has(mat) || inv[mat] < cost[mat]:
			return false
	return true

# Removes the cost from the inventory
static func removeCost(inv, cost):
	for mat in cost:
		inv[mat] -= cost[mat]


# --------------------------------------------
# Object.instance_id -> ResourceType -> int
var Inventory = {}

func _ready():
	if Events.connect("on_restart_game", self, "_reset_state", [], CONNECT_DEFERRED) != OK:
		push_error("Failed to connect to reset")

func _reset_state():
	Inventory = {}