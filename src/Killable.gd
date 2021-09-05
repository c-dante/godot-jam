extends Node
class_name Killable


export (float) var life = 100
onready var entity = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	entity.add_to_group(Global.GROUP.KILLABLE)
	pass # Replace with function body.

func dealDamage(_source, damage):
	life -= damage
	if life <= 0:
		kill()

func kill():
	print("Killed ", self)
	queue_free()