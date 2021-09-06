extends Node
class_name Killable


export (float) var life = 20
onready var entity = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	entity.add_to_group(Global.GROUP.KILLABLE)
	# if Events.connect("on_killable_hit", self, "onHit") != OK:
	# 	push_error("Failed to connect to killable bus")

func onHit(_projectile, damage):
	life -= damage
	if life <= 0:
		kill()

func kill():
	entity.queue_free()
