extends Node

enum ResourceType { Stone, Wood }

static func resourceString(res):
	match res:
		ResourceType.Stone:
			return "Stone"
		ResourceType.Wood:
			return "Wood"

# Object.instance_id -> ResourceType -> int
var Inventory = {}
