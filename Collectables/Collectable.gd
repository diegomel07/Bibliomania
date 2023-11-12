extends Area2D

@export var itemRes: InventoryItem
@onready var ap = $AnimationPlayer

func collect(inventory :Inventory):
	ap.play("spin")
	await ap.animation_finished
	inventory.insert(itemRes)
	queue_free()
