extends Node

# ------------------------------ Constants
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
		"cost": { ResourceType.Stone: 10 },
		"desc": "Drop near resources to auto-mine them.",
		"icon": "res://assets/icon/Pickaxe.png"
	},
	ItemType.Bow: {
		"cost": { ResourceType.Wood: 5 },
		"desc": "Defend yourself.",
		"icon": "res://assets/icon/Bow.png"
	}
}

# Upgrades
enum UpgradeType { FireRate, Piercing }

static func upgradeString(res):
	match res:
		UpgradeType.FireRate:
			return "Fire Rate"
		UpgradeType.Piercing:
			return "Piercing"

var Upgrades = {
	UpgradeType.FireRate: {
		"levels": [
			{ ResourceType.Wood: 5 },
			{ ResourceType.Stone: 5, ResourceType.Wood: 5 },
			{ ResourceType.Stone: 15, ResourceType.Wood: 15 },
			{ ResourceType.Stone: 50, ResourceType.Wood: 50 },
		],
		"desc": "More arrows.",
		"icon": "res://assets/icon/FireRate.png"
	},
	UpgradeType.Piercing: {
		"levels": [
			{ ResourceType.Stone: 10 },
			{ ResourceType.Stone: 20, ResourceType.Wood: 20 },
			{ ResourceType.Stone: 50, ResourceType.Wood: 50 },
		],
		"desc": "Pierce enemies.",
		"icon": "res://assets/icon/Piercing.png"
	}
}

# ------------------------------ Statics
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


# ------------------------------ Singleton Instance
# Object.instance_id -> ResourceType -> int
var Inventory = {}

func _ready():
	if Events.connect("on_restart_game", self, "_reset_state", [], CONNECT_DEFERRED) != OK:
		push_error("Failed to connect to reset")

func _reset_state():
	Inventory = {}

func gatherResource(owner_instance_id: int, resource: int, amount: float):
	var inv = Resources.Inventory
	if !inv.has(owner_instance_id):
		inv[owner_instance_id] = {}
	if !inv[owner_instance_id].has(resource):
		inv[owner_instance_id][resource] = 0
	inv[owner_instance_id][resource] += amount
	Events.resource_gather(owner_instance_id, resource, amount)

func getResource(ownerId: int, resourceType: int):
	var inv = Resources.Inventory
	if !inv.has(ownerId):
		return 0
	return inv[ownerId].get(resourceType, 0)
