extends KinematicBody


export (NodePath) var meshPath
onready var mesh = get_node(meshPath)

var target

func _on_FSM_updated(state, _delta):
	match state:
		"Entry":
			pass

		"FindTarget":
			target = Global.findClosestNode(
				self,
				get_tree().get_nodes_in_group(Global.GROUP.PLAYER)
			)

		"MoveToTarget":
			if target == null:
				continue

			# $FSM.set_param("has_target", target != null)
			var targetPt = Vector3(target.global_transform.origin)
			targetPt.y = global_transform.origin.y
			$Movement.direction = global_transform.origin.direction_to(targetPt)
			$Movement.direction.y = 0
			look_at(targetPt, Vector3.UP)
			pass

	$FSM.set_param("has_target", target != null)
