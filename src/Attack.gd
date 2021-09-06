extends Area

const Killable = preload("res://src/Killable.gd")
const Burst = preload("res://src/effects/Burst.tscn")

export (float) var damage = 5.0
export (float) var cooldown = 1.0
export (float) var knockback = 20.0
var currentCooldown: float = 0

onready var owner_id = get_parent().get_instance_id()

var toHit = {}

func _physics_process(delta):
	if currentCooldown > 0:
		currentCooldown -= delta
		return

	if !toHit.empty():
		currentCooldown = cooldown
		var anim = Burst.instance()
		anim.set_translation(get_global_transform().origin)
		Global.SPAWN.add_child(anim)
		for hit in toHit:
			var body = toHit[hit]
			if body == null || body.is_queued_for_deletion():
				continue

			if body.get_instance_id() != owner_id:
				# Apply knockback, kine
				# var as_kine = body as KinematicBody
				# if as_kine != null:
				# 	var direction = global_transform.origin.direction_to(as_rb.global_transform.origin)
				# 	as_kine.move_and_slide(knockback * direction)

				# Apply knockback, rigid
				var as_rb = body as RigidBody
				if as_rb != null:
					var direction = global_transform.origin.direction_to(as_rb.global_transform.origin)
					as_rb.apply_central_impulse(direction * knockback)

				if body.is_in_group(Global.GROUP.KILLABLE):
					var killable = body.find_node(Global.GROUP.KILLABLE) as Killable
					if killable == null:
						push_error("Failed to find killable in collision!")
					else:
						killable.onHit(self, damage)

func _on_Attack_body_entered(body):
	if body.is_in_group(Global.GROUP.PLAYER):
		var id = body.get_instance_id()
		toHit[id] = body
		body.connect("tree_exiting", self, "_remove_body_tracking", [body])

func _on_Attack_body_exited(body):
	_remove_body_tracking(body)

func _remove_body_tracking(body):
	var id = body.get_instance_id()
	if toHit.has(id):
		toHit.erase(id)
	if body.is_connected("tree_exiting", self, "_remove_body_tracking"):
		body.disconnect("tree_exiting", self, "_remove_body_tracking")

