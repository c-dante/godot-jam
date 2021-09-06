extends Area

const Enemey = preload("res://src/Enemy.tscn")

# { owner: Object, shape: Shape }[]
var areas = []

# Spawn interval
var nextSpawn = 0

func _ready():
	for id in get_shape_owners():
		var owner = shape_owner_get_owner(id)
		for idx in shape_owner_get_shape_count(id):
			areas.append({
				"owner": owner,
				"shape": shape_owner_get_shape(id, idx)
			})

	if areas.size() <= 0:
		push_error("No shapes registered to spawner.")

func _physics_process(delta):
	if nextSpawn > 0:
		nextSpawn -= delta

	if nextSpawn <= 0:
		nextSpawn = 5
		var enemy = Enemey.instance()
		Global.SPAWN.add_child(enemy)
		enemy.global_translate(randomPointInShapes())
		enemy.add_to_group(Global.GROUP.ENEMY)


func randomPointInShapes():
	var spawn = areas[randi() % areas.size()]
	if spawn == null || !spawn["owner"] is Spatial:
		print("Unhandled spawn area case: ", spawn)
		return;

	var owner = spawn["owner"] as Spatial
	var shape = spawn["shape"]
	if shape is BoxShape:
		# Get a random point in the extents + transform using the owner
		var pt = Vector3(
			Global.Rng.randf_range(-shape.extents.x, shape.extents.x),
			Global.Rng.randf_range(-shape.extents.y, shape.extents.y),
			Global.Rng.randf_range(-shape.extents.y, shape.extents.z)
		)
		return owner.to_global(pt)

	print("Unhandled shape: ", shape)
	return Vector3(0, 0, 0)
