extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if $Alice.position.x > 400 or $Alice.position.x < -400:
		$Alice.position.x *= -1
		
	elif $Alice.position.y > 400 or $Alice.position.y < -400:
		$Alice.position.y *= -1
