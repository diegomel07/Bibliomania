extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_door_3_body_entered(body):
	if body.has_method("player"):
		global.next_room("left")

func _on_door_4_body_entered(body):
	if body.has_method("player"):
		global.next_room("up")

