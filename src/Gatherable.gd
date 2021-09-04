extends Node

const Resources = preload("res://src/Resources.gd")
const Bar = preload("res://src/Bar/Bar.gd")

export (NodePath) var barPath
var bar: Bar

export (NodePath) var gatheringAreaPath
onready var gatheringArea: Area = get_node(gatheringAreaPath)

export (float) var gatherTimeSec = 1.0

export (Array, Resources.ResourceType) var produces

var gatherCycle = {}
var remaining

# Called when the node enters the scene tree for the first time.
func _ready():
	if barPath:
		bar = get_node(barPath)
	gatheringArea.connect('body_entered', self, '_on_bodyEnter')
	gatheringArea.connect('body_exited', self, '_on_bodyExit')

func _on_bodyEnter(body: Node):
	print("ENTER", body)

func _on_bodyExit(body: Node):
	print("EXIT", body)
