extends GridContainer

const Res = preload("res://src/Resources.gd")
const Events = preload("res://src/Events.gd")
const TooltipButton = preload("res://src/ui/TooltipButton.tscn")


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
		add_child(buildBtn)
