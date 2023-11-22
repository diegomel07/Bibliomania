extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_door_1_body_entered(body):
	if body.has_method("player"):
		global.next_room("down")

func _on_door_2_body_entered(body):
	if body.has_method("player"):
		global.next_room("right")

func _on_door_3_body_entered(body):
	if body.has_method("player"):
		global.next_room("left")



