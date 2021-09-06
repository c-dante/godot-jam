extends Node

const Res = preload("res://src/Resources.gd")

# int, Resources.ItemType, Dictionary Material -> int
signal on_purchase_attempt(owner, item, cost)
func purchase_attempt(owner, item, cost):
	emit_signal("on_purchase_attempt", owner, item, cost)

# signal on_killable_hit(killable, projectile)
# func killable_hit(killable, projectile):
# 	emit_signal("on_killable_hit", killable, projectile)