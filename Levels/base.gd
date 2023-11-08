extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if $Alice.position.x > 400 or $Alice.position.x < -400:
		$Alice.position.x *= -1
		
	elif $Alice.position.y > 400 or $Alice.position.y < -400:
		$Alice.position.y *= -1


func _on_inventory_closed():
	get_tree().paused = false


func _on_inventory_opened():
	get_tree().paused = true
