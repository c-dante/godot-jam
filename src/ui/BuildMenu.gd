extends GridContainer

const Res = preload("res://src/Resources.gd")
const TooltipButton = preload("res://src/ui/TooltipButton.tscn")
const Miner = preload("res://src/Miner.tscn")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for itemType in Resources.Items:
		var item = Resources.Items[itemType]
		var buildBtn = TooltipButton.instance()
		buildBtn.tooltip = item["desc"] + "\n"
		for res in item["cost"]:
			buildBtn.tooltip += "- %d %s" % [item["cost"][res], Resources.resourceString(res)]
		buildBtn.text = Resources.itemString(itemType)
		buildBtn.icon = load(item["icon"])
		buildBtn.meta = itemType
		add_child(buildBtn)
		if buildBtn.connect("on_press", self, "_on_btn_press") != OK:
			push_error("Could not connect press to build button")

func _on_btn_press(btn):
	var player = $"/root/Main/Player"
	var purchase_id = player.get_instance_id()
	var itemType = btn.meta
	var cost = Resources.Items[itemType]["cost"]
	if Resources.Inventory.has(purchase_id):
		var inv = Resources.Inventory[purchase_id]

		if !Resources.canAfford(inv, cost):
			return
		Resources.removeCost(inv, cost)

		match itemType:
			Res.ItemType.Miner:
				var miner = Miner.instance()
				miner.owner = miner
				miner.owner_id = purchase_id
				miner.transform.origin = player.transform.origin
				miner.add_to_group(Global.GROUP.PLAYER)
				$"/root/Main/spawn".add_child(miner)
				return
			# Defer to event bus
			var other:
				Events.purchase_attempt(purchase_id, other, cost)
