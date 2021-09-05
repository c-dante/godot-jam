extends Tree

onready var root: TreeItem = create_item()
onready var resources: TreeItem = create_item(root)

# Object.instance_id -> { "tree": TreeItem, "res": ResourceType -> TreeItem }
var resourceItems = {}

func _ready():
	root.set_text(0, "Resources")
	resources.set_text(0, "Inventory")


func _process(_delta):
	for id in Resources.Inventory:
		var node = instance_from_id(id)
		if !resourceItems.has(id):
			var treeItem = create_item(resources)
			treeItem.set_text(0, node.name)
			resourceItems[id] = {
				"tree": treeItem,
				"res": {}
			}

		var inventory = Resources.Inventory[id]
		var ownerTree = resourceItems[id]
		for resource in inventory:
			if !ownerTree["res"].has(resource):
				var treeItem = create_item(ownerTree["tree"])
				treeItem.set_text(0, Resources.resourceString(resource))
				ownerTree["res"][resource] = treeItem

			var value = "%d" % floor(inventory[resource])
			ownerTree["res"][resource].set_text(1, value)



	pass