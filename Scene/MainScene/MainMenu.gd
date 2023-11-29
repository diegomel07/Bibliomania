extends Control

@onready "res://Scene/MainScene/PlayMenu.tscn"

var db #database object
var db_name = "res://Data/bibliomania" #path to db

# Called when the node enters the scene tree for the first time.
func _ready():
	db = SQLite.new()
	db.path = db_name
	searchDataSlots()

func searchDataSlots():
	db.open_db()
	var tableName = "User"
	db.query("SELECT * from GameData where user_id = " + str(global.user_id) +  ";" )
	
	# si la query esta vacia
	if db.query_result.size() == 0:
		# crear nuevo espacio
		tableName = "GameData"
		var dict : Dictionary = Dictionary()
		dict["user_id"] = global.user_id
		db.insert_row(tableName, dict)
	
	# asginar cada slot en los botones


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scene/MainScene/MainMenu.tscn")


func _on_ajustes_pressed():
	get_tree().change_scene_to_file("res://Scene/MainScene/MainMenu_settings.tscn")


func _on_cerrar_sesion_pressed():
	get_tree().change_scene_to_file("res://Scene/MainScene/LoginScene.tscn")


func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Scene/MainScene/PlayMenu.tscn")
