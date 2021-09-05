extends Node

const Res = preload("res://src/Resources.gd")

# int, Resources.ItemType, Dictionary Material -> int
signal on_purchase_attempt(owner, item, cost)

func purchase_attempt(owner, item, cost):
	emit_signal("on_purchase_attempt", owner, item, cost)
