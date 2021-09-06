extends KinematicBody


export (NodePath) var meshPath
onready var mesh = get_node(meshPath)

var target

func _on_FSM_updated(state, _delta):
	# Sync the target state
	$FSM.set_param("has_target", target != null)

	match state:
		"Entry":
			pass

		"FindTarget":
			target = Global.findClosestNode(
				self,
				get_tree().get_nodes_in_group(Global.GROUP.PLAYER)
			)
			print(target)

		"MoveToTarget":
			if target == null:
				return

			# $FSM.set_param("has_target", target != null)
			var targetPt = target.global_transform.origin
			$Movement.direction = (targetPt - global_transform.origin).normalized()
			look_at(targetPt, Vector3.UP)
			pass
