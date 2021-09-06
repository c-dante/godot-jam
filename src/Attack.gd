extends Area

const Killable = preload("res://src/Killable.gd")

export (float) var damage = 5.0
export (float) var cooldown = 1.0

onready var owner_id = get_parent().get_instance_id()

func _on_Attack_body_entered(body):
	if body.is_in_group(Global.GROUP.PLAYER):
		print("enemy attack: ", body)
