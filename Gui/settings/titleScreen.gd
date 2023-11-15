extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Levels/base.tscn")


func _on_settings_button_pressed():
	pass
