extends Node

const Res = preload("res://src/Resources.gd")
const Bar = preload("res://src/Bar/Bar.gd")

export (NodePath) var barPath
var bar: Bar

export (NodePath) var gatheringAreaPath
onready var gatheringArea: Area = get_node(gatheringAreaPath)

export (float) var gatherTimeSec = 2.0

export (Array, Res.ResourceType) var produces
export (Array, float) var producesVolume

var gathering = {}
var miners = 0
var gatherCycle = {}
var remaining = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if barPath:
		bar = get_node(barPath)
	if gatheringArea.connect('body_entered', self, '_on_bodyEnter') != OK:
		push_error("Gatherable failed to connect enter")

	if gatheringArea.connect('body_exited', self, '_on_bodyExit') != OK:
		push_error("Gatherable failed to connect exit")

	remaining = gatherTimeSec
	assert(produces.size() == producesVolume.size(), "Production and volume length must align")
	bar.progress = remaining / gatherTimeSec;

func _on_bodyEnter(body: Node):
	var gatherer = body.get_instance_id()
	gathering[gatherer] = true
	miners += 1
	if !gatherCycle.has(gatherer):
		gatherCycle[gatherer] = 0

func _on_bodyExit(body: Node):
	gathering[body.get_instance_id()] = false
	miners -= 1

func _physics_process(delta):
	# no-op if no one is mining
	if miners <= 0:
		return

	# Error rate
	var minedDelta = delta * miners
	var adjDelta = minedDelta if minedDelta < remaining else remaining

	# Allocate mining ownership
	for name in gathering:
		if gathering[name]:
			gatherCycle[name] += adjDelta / miners

	# Distribute resources
	remaining -= adjDelta

	# Consume a cycle of resource and reset values
	if remaining <= 0:
		remaining = gatherTimeSec

		# Allocate based on consumption porition
		for name in gatherCycle:
			var portion = gatherCycle[name] / gatherTimeSec
			gatherCycle[name] = 0
			var miner = instance_from_id(name)
			var contribute_id = miner.owner_id if miner.get("owner_id") != null else name
			for produceIdx in range(produces.size()):
				var resource = produces[produceIdx]
				var volume = producesVolume[produceIdx]
				Global.gatherResource(contribute_id, resource, portion * volume)

	# Update bar
	bar.progress = remaining / gatherTimeSec;
