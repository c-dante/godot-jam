extends Node
class_name Killable

const ParticleBurst = preload("res://src/effects/ParticleBurst.tscn")

export (float) var life = 20
export (bool) var removeSelf = true
onready var entity: Spatial = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	entity.add_to_group(Global.GROUP.KILLABLE)

func onHit(_projectile, damage):
	life -= damage
	if life <= 0:
		kill()

func kill():
	var particles = ParticleBurst.instance()
	particles.set_translation(entity.global_transform.origin)
	Global.SPAWN.add_child(particles)

	Events.killable_kill(entity)
	if removeSelf && !entity.is_queued_for_deletion():
		entity.queue_free()
