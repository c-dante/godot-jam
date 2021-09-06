extends KinematicBody

const Miner = preload("res://src/Miner.gd")
const Enemy = preload("res://src/Enemy.gd")

var life = 5
var gameTime = 0
var kills = 0
var minersBuilt = 0
var minersLost = 0

func _ready():
	if Events.connect("on_killable_kill", self, "killable_kill") != OK:
		push_error("Could not connect player stats events")

func _physics_process(delta):
	gameTime += delta

func killable_kill(entity):
	if entity is Miner:
		minersLost += 1

	if entity is Enemy:
		kills += 1