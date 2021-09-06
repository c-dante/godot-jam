extends KinematicBody
class_name Enemy

export (NodePath) var meshPath
onready var mesh = get_node(meshPath)

var target

func _on_FSM_updated(state, _delta):
	match state:
		"Entry":
			pass

		"FindTarget":
			# Jank to not just alays pick the closest
			var candidates = get_tree().get_nodes_in_group(Global.GROUP.PLAYER)
			candidates.shuffle()
			var sample = candidates.slice(0, 15)
			sample.append($"/root/Main/Player")
			target = Global.findClosestNode(self, sample)

		"MoveToTarget":
			if target == null:
				continue

			# Handle fall through floor problem
			if target.global_transform.origin.y < -1:
				target = null
				continue

			var targetPt = Vector3(
				target.global_transform.origin.x,
				0,
				target.global_transform.origin.z
			)
			$Movement.direction = global_transform.origin.direction_to(targetPt)
			$Movement.direction.y = 0
			look_at(targetPt, Vector3.UP)
			rotation.x = 0
			pass

	$FSM.set_param("has_target", target != null)
