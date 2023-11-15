extends Control
var singup_screen_path ="res://Scene/MainScene/singupScene.tscn"

var username_line 
var password_line
var message_label

func _ready():
	username_line = $TextureRect/NinePatchRect/VBoxContainer/LineEdit
	password_line = $TextureRect/NinePatchRect/VBoxContainer/LineEdit2
	message_label = $TextureRect/NinePatchRect/VBoxContainer/Message
	message_label.visible = false  
	password_line.secret = true
func _on_login_button_button_down():
	var username = username_line.text.strip_edges()
	var password = password_line.text.strip_edges()
	check_and_register(username, password)

func check_and_register(username, password):	
	if username == "" or password =="" :
		show_message("fill the blank spaces")
		return
	message_label.visible = false
		
func show_message(message):
	message_label.text = message
	message_label.visible = true
		
func _on_singup_button_button_down():
	get_tree().change_scene_to_file(singup_screen_path)
