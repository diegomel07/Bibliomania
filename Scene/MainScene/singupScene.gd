extends Control

var login_screen_path ="res://Scene/MainScene/LoginScene.tscn"

var username_line 
var email_line 
var password_line
var message_label
var message2_label

func _ready():
	username_line = $TextureRect/NinePatchRect/VBoxContainer/LineEdit
	email_line = $TextureRect/NinePatchRect/VBoxContainer/LineEdit2
	password_line = $TextureRect/NinePatchRect/VBoxContainer/LineEdit3
	message_label = $TextureRect/NinePatchRect/VBoxContainer/Message
	message2_label = $TextureRect/NinePatchRect/VBoxContainer/Message2  

func _on_create_button_button_down():
	var username = username_line.text.strip_edges()
	var email = email_line.text.strip_edges()
	var password = password_line.text.strip_edges()
	check_and_register(username, email, password)
	
#valida y registra
func check_and_register(username, email, password):	
	
	if username == "" or password =="" or email =="":
		show_message("fill the blank spaces","red")
		return
	if len(username)<4:
		show_message("username too short","red")
		return
	if len(password)<4:
		show_message("password too short","red")
		return
	if is_valid_email(email):
		show_message("Invalid email format","red")
		return	
		
	show_message("User created","green")

#validar email	
func is_valid_email(email):
	var regex = RegEx.new()
	regex.compile("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$")
	return regex.search(email) == null
	
# Muestra el mensaje de error o creacion de perfil completada
func show_message(message, color):
	if color == "green":
		message_label.visible = false
		message2_label.text = message
		message2_label.visible = true
		username_line.text = ""
		email_line.text = ""
		password_line.text = ""
		
	if color == "red":
		message2_label.visible = false
		message_label.text = message
		message_label.visible = true
		

func _on_login_button_button_down():
	get_tree().change_scene_to_file(login_screen_path)
