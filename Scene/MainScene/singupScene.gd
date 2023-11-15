extends Control

var login_screen_path ="res://Scene/MainScene/LoginScene.tscn"

var username_line 
var email_line 
var password_line
var message_label

func _ready():
	username_line = $TextureRect/NinePatchRect/VBoxContainer/LineEdit
	email_line = $TextureRect/NinePatchRect/VBoxContainer/LineEdit2
	password_line = $TextureRect/NinePatchRect/VBoxContainer/LineEdit3
	message_label = $TextureRect/NinePatchRect/VBoxContainer/Message
	password_line.secret = true
	message_label.visible = false  

func _on_login_button_button_down():
	get_tree().change_scene_to_file(login_screen_path)

func _on_create_button_button_down():
	var username = username_line.text.strip_edges()
	var email = email_line.text.strip_edges()
	var password = password_line.text.strip_edges()
	check_and_register(username, email, password)
	
#valida y registra
func check_and_register(username, email, password):	
	if username == "" or password =="" or email =="":
		show_message("fill the blank spaces")
		return
	if len(username)<4:
		show_message("username too short")
		return
	if len(password)<4:
		show_message("password too short")
		return
	if is_valid_email(email):
		show_message("Invalid email format")
		return	
	message_label.visible = false
	get_tree().change_scene_to_file(login_screen_path)
# Muestra el mensaje de error 
func show_message(message):
	message_label.text = message
	message_label.visible = true
	
#validar email	
func is_valid_email(email):
	var regex = RegEx.new()
	regex.compile("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$")
	return regex.search(email) == null
	
#	var json_data = load_json(file_path)
## Verificar si el username ya existe
#	if user_exist(username, json_data):
#		print("Username alredy exist")
#	else:
#		# Agregar el nuevo usuario al JSON
#		json_data.append({"username":username, "password": password, "email": email})
#		save_json(file_path,json_data)
#		print("Usuario registrado correctamente.")

#func user_exist(username, data):
#	for user in data:
#		print(user.username, username)
#		if user.username == username:
#			return true
#	return false
#
#func load_json(file_path):
#	if FileAccess.file_exists(file_path):
#		var dataFile = FileAccess.open(file_path, FileAccess.READ)
#		var parsedResult = JSON.parse_string(dataFile.get_as_text())
#		return parsedResult
#	else:
#		print("File doesnt exist")
#
#func save_json(file_path, new_data):
#	if FileAccess.file_exists(file_path):
#		var json_data = new_data.to_json()
#		var data_file = FileAccess.open(file_path, FileAccess.WRITE)
#		data_file.
