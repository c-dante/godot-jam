extends Node

const Res = preload("res://src/Resources.gd")
const Bow = preload("res://src/weapons/Bow.gd")

export (NodePath) var meshPath
onready var mesh: Spatial = get_node(meshPath)

export (NodePath) var ownerPath
onready var parent: Node = get_node(ownerPath)

var owner_id
var owned_items = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	print(mesh, parent)
	owner_id = parent.get_instance_id()
	if Events.connect("on_purchase_attempt", self, "on_purchase_attempt") != OK:
		push_error("Could not attach to purchase event bus")

func on_purchase_attempt(owner, item, cost):
	var inv = Resources.Inventory.get(owner, {})

	if owner != owner_id || !Resources.canAfford(inv, cost):
		return

	if owned_items.has(item):
		print("Already owned!")
		return

	match item:
		Res.ItemType.Bow:
			var bow = Bow.new()
			bow.meshPath = meshPath
			bow.owner_id = owner_id
			parent.add_child(bow)
			owned_items[item] = bow

		var other:
			push_error("TODO: Handle equipment purchase of " + Resources.itemString(other))