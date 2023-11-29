extends Node2D
# Called every frame. 'delta' is the elapsed time since the previous frame. m
	
	
func _process(_delta):
	
	if $Alice.position.x > 400 or $Alice.position.x < -400:
		$Alice.position.x *= -1
		
	elif $Alice.position.y > 400 or $Alice.position.y < -400:
		$Alice.position.y *= -1
	
	change_scene()

func _on_inventory_closed():
	$DirectionalLight2D.energy = 0
	get_tree().paused = false


func _on_inventory_opened():
	$DirectionalLight2D.energy = 0.6
	get_tree().paused = true

func _on_alice_item_droped(item):
	item.position = $Alice.position
	$Collectables.add_child(item)


func _on_settings_node_closed():
	$DirectionalLight2D.energy = 0
	get_tree().paused = false


func _on_settings_node_opened():
	$DirectionalLight2D.energy = 0.6
	get_tree().paused = true

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		global.transition_scene = false
		
func change_scene():
	
	if global.transition_scene == true:
		if global.current_scene == "base":
			get_tree().change_scene_to_file("res://Room/Initialize.tscn")
			global.current_scene = "initialize"
			global.finish_changedscenes()
