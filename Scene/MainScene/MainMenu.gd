extends Control

@onready var exit = $Close

var db #database object
var db_name = "res://Data/bibliomania" #path to db
var dataSlots

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
	else:
		# asginar cada slot en los botones
		var slots = $TextureRect/NinePatchRect/VBoxContainer/Node2D.get_children()
		for i in range(db.query_result.size()):
			slots[i].self_modulate = Color.BLUE
	
	dataSlots = db.query_result


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scene/MainScene/MainMenu.tscn")


func _on_ajustes_pressed():
	get_tree().change_scene_to_file("res://Scene/MainScene/MainMenu_settings.tscn")


func _on_cerrar_sesion_pressed():
	exit.exit_open()


func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Scene/MainScene/PlayMenu.tscn")


func _on_play_pressed():
	pass # Replace with function body.


func _on_erase_pressed():
	pass # Replace with function body.


func _on_slot_1_pressed():
	$TextureRect/NinePatchRect/Play.show()
	$TextureRect/NinePatchRect/Erase.show()
