extends Control

@onready var Delete = $Delete

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scene/MainScene/MainMenu.tscn")


func _on_sound_pressed():
	$TextureRect/NinePatchRect.hide()
	$TextureRect/Audio.show() 


func _on_back_audio_pressed():
	get_tree().change_scene_to_file("res://Scene/MainScene/MainMenu_settings.tscn")


func _on_back_video_pressed():
	get_tree().change_scene_to_file("res://Scene/MainScene/MainMenu_settings.tscn")


func _on_screen_pressed():
	$TextureRect/NinePatchRect.hide()
	$TextureRect/Video.show()


func _on_fullscreen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_delete_pressed():
	Delete.sett_open()
