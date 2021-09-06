extends Spatial

const ParticleBurst = preload("res://src/effects/ParticleBurst.tscn")
const Killable = preload("res://src/Killable.gd")

const FORWARD = Vector3(0, 0, 1)
const LIFETIME = 3

export (int) var owner_id
export (float) var speed = 25.0
export (float) var knockback = 100.0
export (float) var damage = 10.0

var alive = true

func _ready():
	if get_tree().create_timer(LIFETIME).connect("timeout", self, "_on_timeout") != OK:
		push_error("Failed to create timer")
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	translate_object_local(speed * delta * FORWARD)

func _on_timeout():
	queue_free()
	var particles: Particles = ParticleBurst.instance()
	particles.set_translation(global_transform.origin)
	particles.amount = 5
	particles.process_material.scale = 0.1
	Global.SPAWN.add_child(particles)

func _on_arrow_body_entered(body):
	if !alive:
		return

	# todo: instead of owner id maybe group ownership for friendly fire?
	if body.is_in_group(Global.GROUP.PLAYER):
		return

	if body.get_instance_id() != owner_id:
		# Apply knockback
		var as_kine = body as KinematicBody
		if as_kine != null:
			var xform = global_transform.basis.z
			as_kine.move_and_slide(knockback * xform)

		if body.is_in_group(Global.GROUP.KILLABLE):
			var killable = body.find_node(Global.GROUP.KILLABLE) as Killable
			if killable == null:
				push_error("Failed to find killable in collision!")
			else:
				killable.onHit(self, damage)

		# Remove self
		alive = false
		queue_free()
