extends "res://Collectables/Collectable.gd"

@onready var ap = $AnimationPlayer

func collect():
	ap.play("spin")
	await ap.animation_finished
	super.collect()

