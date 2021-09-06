extends KinematicBody

const Res = preload("res://src/Resources.gd")
const Miner = preload("res://src/Miner.gd")
const Enemy = preload("res://src/Enemy.gd")

var gameTime = 0
var kills = 0
var minersBuilt = 0
var minersLost = 0
var minedResources = 0

func _ready():
	if Events.connect("on_killable_kill", self, "killable_kill") != OK:
		push_error("Could not connect kll stats")

	if Events.connect("on_resource_gather", self, "resourceGather") != OK:
		push_error("Could not connect gather stats")

func _physics_process(delta):
	gameTime += delta

func killable_kill(entity):
	if entity is Miner:
		minersLost += 1

	if entity is Enemy:
		kills += 1

func resourceGather(_owner_instance_id: int, _resource: int, amount: float):
	minedResources += amount