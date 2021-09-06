extends GridContainer

const Equipment = preload("res://src/Equipment.gd")
const Res = preload("res://src/Resources.gd")
const TooltipButton = preload("res://src/ui/TooltipButton.tscn")
const Miner = preload("res://src/Miner.tscn")
const Bow = preload("res://src/weapons/Bow.gd")

var itemBtns = {}
var upgradeBtns = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for itemType in Resources.Items:
		var item = Resources.Items[itemType]
		var buildBtn = TooltipButton.instance()
		buildBtn.tooltip = renderWithCost(item["desc"], item["cost"])
		buildBtn.text = Resources.itemString(itemType)
		buildBtn.icon = load(item["icon"])
		buildBtn.meta = itemType
		add_child(buildBtn)
		itemBtns[itemType] = buildBtn
		if buildBtn.connect("on_press", self, "_on_btn_press") != OK:
			push_error("Could not connect press to build button")

	for upgradeType in Resources.Upgrades:
		var upgrade = Resources.Upgrades[upgradeType]
		var buildBtn = TooltipButton.instance()
		buildBtn.tooltip = renderWithCost(upgrade["desc"], upgrade["levels"][0])
		buildBtn.text = Resources.upgradeString(upgradeType)
		buildBtn.icon = load(upgrade["icon"])
		buildBtn.meta = upgradeType
		add_child(buildBtn)
		upgradeBtns[upgradeType] = buildBtn
		if buildBtn.connect("on_press", self, "_on_upgrade") != OK:
			push_error("Could not connect press to build button")

func _process(_delta):
	var player = $"/root/Main/Player"
	var equip: Equipment = player.get_node(Global.GROUP.EQUIPMENT)
	if equip == null:
		return

	var has_bow = equip.owned_items.has(Res.ItemType.Bow)
	itemBtns[Res.ItemType.Bow].disabled = has_bow
	if has_bow:
		itemBtns[Res.ItemType.Bow].text = "(owned)"

	# JUST GET IT WORKING
	var fireRateUpgrade = Resources.Upgrades[Res.UpgradeType.FireRate]
	var piercingUpgrade = Resources.Upgrades[Res.UpgradeType.Piercing]

	upgradeBtns[Res.UpgradeType.FireRate].disabled = !has_bow
	upgradeBtns[Res.UpgradeType.Piercing].disabled = !has_bow

	if !has_bow:
		upgradeBtns[Res.UpgradeType.FireRate].tooltip = fireRateUpgrade["desc"] + "\n\nRequires the bow."
		upgradeBtns[Res.UpgradeType.Piercing].tooltip = piercingUpgrade["desc"] + "\n\nRequires the bow."
	else:
		var player_bow = equip.owned_items.get(Res.ItemType.Bow) as Bow
		if player_bow != null:
			if player_bow.cooldownLevel >= fireRateUpgrade["levels"].size():
				upgradeBtns[Res.UpgradeType.FireRate].disabled = true
				upgradeBtns[Res.UpgradeType.FireRate].tooltip = fireRateUpgrade["desc"] + "\n\nMax level."
			else:
				upgradeBtns[Res.UpgradeType.FireRate].disabled = false
				var cost = fireRateUpgrade["levels"][player_bow.cooldownLevel]
				upgradeBtns[Res.UpgradeType.FireRate].tooltip = renderWithCost(fireRateUpgrade["desc"], cost)

			if player_bow.piercingLevel >= piercingUpgrade["levels"].size():
				upgradeBtns[Res.UpgradeType.Piercing].disabled = true
				upgradeBtns[Res.UpgradeType.Piercing].tooltip = piercingUpgrade["desc"] + "\n\nMax level."
			else:
				upgradeBtns[Res.UpgradeType.Piercing].disabled = false
				var cost = piercingUpgrade["levels"][player_bow.piercingLevel]
				upgradeBtns[Res.UpgradeType.Piercing].tooltip = renderWithCost(piercingUpgrade["desc"], cost)

func renderWithCost(desc, cost):
	var out = desc + "\n"
	for res in cost:
		out += "- %d %s" % [cost[res], Resources.resourceString(res)]
	return out

func _on_btn_press(btn):
	var player = $"/root/Main/Player"
	var buyer_id = player.get_instance_id()
	var itemType = btn.meta
	var cost = Resources.Items[itemType]["cost"]
	if Resources.Inventory.has(buyer_id):
		var inv = Resources.Inventory[buyer_id]

		match itemType:
			Res.ItemType.Miner:
				if !Resources.canAfford(inv, cost):
					return
				Resources.removeCost(inv, cost)
				var miner = Miner.instance()
				miner.owner = miner
				miner.owner_id = buyer_id
				miner.transform.origin = player.transform.origin
				miner.add_to_group(Global.GROUP.PLAYER)
				$"/root/Main/spawn".add_child(miner)
				$"/root/Main/Player".minersBuilt += 1

			# Defer to event bus
			var other:
				Events.purchase_attempt(buyer_id, other, cost)

func _on_upgrade(btn):
	var upgradeType = btn.meta
	var upgrade = Resources.Upgrades[upgradeType]

	var player = $"/root/Main/Player"
	var buyer_id = player.get_instance_id()

	var equip: Equipment = player.get_node(Global.GROUP.EQUIPMENT)
	if equip == null:
		push_warning("Attemt to buy upgrade without equipment")
		return

	var player_bow = equip.owned_items.get(Res.ItemType.Bow) as Bow
	if player_bow == null:
		push_warning("Attemt to buy upgrade without a bow")
		return

	if Resources.Inventory.has(buyer_id):
		var inv = Resources.Inventory[buyer_id]

		match upgradeType:
			Res.UpgradeType.FireRate:
				if player_bow.cooldownLevel >= upgrade["levels"].size():
					push_warning("Attemt to upgrade fire rate past max level")
					return

				var cost = upgrade["levels"][player_bow.cooldownLevel]
				if !Resources.canAfford(inv, cost):
					return
				Resources.removeCost(inv, cost)
				player_bow.cooldownLevel += 1

			Res.UpgradeType.Piercing:
				if player_bow.piercingLevel >= upgrade["levels"].size():
					push_warning("Attemt to upgrade piercing past max level")
					return

				var cost = upgrade["levels"][player_bow.piercingLevel]
				if !Resources.canAfford(inv, cost):
					return
				Resources.removeCost(inv, cost)
				player_bow.piercingLevel += 1

			# Defer to event bus
			var other:
				push_warning("Unhandled upgrade type %d" % other)
