extends Control

signal opened
signal closed

var isOpen: bool = false

func exit_open():
	visible = true
	isOpen = true
	$"../TextureRect".show()
	opened.emit()

func exit_close():
	visible = false
	isOpen = false	
	$TextureRect.hide()
	closed.emit()


func _on_yes_pressed():
	get_tree().change_scene_to_file("res://Scene/MainScene/LoginScene.tscn")


func _on_no_pressed():
	exit_close()
