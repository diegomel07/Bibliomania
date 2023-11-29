extends Control

signal opened
signal closed

var isOpen: bool = false

func sett_open():
	visible = true
	isOpen = true
	$TextureRect/SettingsBox.show()
	opened.emit()

func sett_close():
	visible = false
	isOpen = false	
	$TextureRect/SettingsBox.hide()
	$TextureRect/Audio.hide()
	$TextureRect/Video.hide()
	closed.emit()

func _on_video_buttton_pressed():
	$TextureRect/SettingsBox.hide()
	$TextureRect/Video.show()
	
func _on_sound_button_pressed():
	$TextureRect/SettingsBox.hide()
	$TextureRect/Audio.show()

func _on_back_button_pressed():
	if isOpen == true:
		sett_close()
	else:
		sett_open()

func _on_back_from_audio_pressed():
	$TextureRect/SettingsBox.show()
	$TextureRect/Audio.hide()

func _on_back_from_video_pressed():
	$TextureRect/SettingsBox.show()
	$TextureRect/Video.hide()

func _on_fullscreen_toggled(button_pressed):
	# Obtén una referencia al objeto OS
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_exit_button_pressed():
	global.saveData()
	get_tree().quit()

func _on_restart_button_pressed():
	get_tree().change_scene_to_file("res://Room/Initialize.tscn")
	global.current_scene = "initialize"
