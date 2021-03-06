extends Spatial

const Res = preload("res://src/Resources.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.has_feature("editor"):
		cheat_grant()
		pass

func cheat_grant():
	Resources.gatherResource($Player.get_instance_id(), Res.ResourceType.Stone, 1000)
	Resources.gatherResource($Player.get_instance_id(), Res.ResourceType.Wood, 1000)
	Events.purchase_attempt($Player.get_instance_id(), Res.ItemType.Bow, {})

	$"/root/Main/Level/Spawners/EnemySpawn".waveNum = 5
	$"/root/Main/Level/Spawners/EnemySpawn/Timer".wait_time = 2
