extends Node
class_name Killable


export (float) var life = 20
export (bool) var removeSelf = true
onready var entity = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	entity.add_to_group(Global.GROUP.KILLABLE)

func onHit(_projectile, damage):
	life -= damage
	if life <= 0:
		kill()

func kill():
	Events.killable_kill(entity)
	if removeSelf:
		entity.queue_free()
