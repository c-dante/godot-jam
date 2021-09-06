extends Node

# ------------------------------ Constants
const GROUP = {
	# Group of things that can be "killed", node must be named the group name
	"KILLABLE": "Killable",
	# The player and player owned things
	"PLAYER": "Player",
	# All the arrows / projectiles
	"ARROW": "Arrow",
	# All resources on the map
	"RESOURCE": "Resource",
	# All neutral mob enemies
	"ENEMY": "Enemy",
	# Holding stuff component
	"EQUIPMENT": "Equipment",
}

# ------------------------------ Statics

# Spatial, Spatial[] -> Spatial
static func findClosestNode(fromNode, candidates):
	var fromPt: Vector3 = fromNode.global_transform.origin
	var best: Spatial
	var best_distance: float
		# = fromPt.distance_squared_to(best.global_transform.origin)
	for candidate in candidates:
		var dist = fromPt.distance_squared_to(candidate.global_transform.origin)
		if best == null || dist < best_distance:
			best = candidate
			best_distance = dist
	return best

static func formatTime(time: float):
	return "%d" % floor(time)

# ------------------------------ Singleton Instance
onready var SPAWN: Node = $"/root/Main/spawn"
onready var viewedIntro = false

var Rng = RandomNumberGenerator.new()

func _ready():
	_reset_state()

func _reset_state():
	Rng.seed = 8675309
	seed(Rng.seed)
	SPAWN = $"/root/Main/spawn"
