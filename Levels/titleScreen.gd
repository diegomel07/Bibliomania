extends Control

@onready var settings = $Settings
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_settings_button_pressed():
	if settings.isOpen:
		settings.sett_close()
	else:
		settings.sett_open()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Levels/base.tscn")
