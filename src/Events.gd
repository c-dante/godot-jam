extends Node

const Res = preload("res://src/Resources.gd")

var main_scene = preload("res://FirstScene.tscn")

# int, Resources.ItemType, Dictionary Material -> int
signal on_purchase_attempt(owner, item, cost)
func purchase_attempt(owner, item, cost):
	emit_signal("on_purchase_attempt", owner, item, cost)

signal on_killable_kill(entity)
func killable_kill(entity):
	emit_signal("on_killable_kill", entity)

signal on_resource_gather(owner_instance_id, resource, amount)
func resource_gather(owner_instance_id, resource, amount):
	emit_signal("on_resource_gather", owner_instance_id, resource, amount)

signal on_game_over(player)
func game_over(player):
	emit_signal("on_game_over", player)

signal on_restart_game()
func restart_game():
	emit_signal("on_restart_game")
	call_deferred("_do_reset")

func _do_reset():
	var root = get_tree().get_root()
	var current_scene = root.get_child(root.get_child_count() - 1)
	current_scene.free()
	get_tree().get_root().add_child(main_scene.instance())
	Global._reset_state()
