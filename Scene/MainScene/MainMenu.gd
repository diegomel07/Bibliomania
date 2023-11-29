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
		print("ola")
		# crear nuevo espacio
		tableName = "GameData"
		var dict : Dictionary = Dictionary()
		dict["user_id"] = global.user_id
		db.insert_row(tableName, dict)
	else:
		print("ola2")
		# asginar cada slot en los botones
		var slots = $TextureRect/NinePatchRect/VBoxContainer/Node2D.get_children()
		for i in range(db.query_result.size()):
			$"TextureRect/NinePatchRect/VBoxContainer/Node2D/Slot 1".text = "Muertes" + str(db.query_result[i]["death_count"])
			slots[i].self_modulate = Color.BLUE
	
	dataSlots = db.query_result


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Gui/settings/titleScreen.tscn")


func _on_ajustes_pressed():
	get_tree().change_scene_to_file("res://Scene/MainScene/MainMenu_settings.tscn")


func _on_cerrar_sesion_pressed():
	exit.exit_open()


func _on_jugar_pressed():
	get_tree().change_scene_to_file("res://Scene/MainScene/PlayMenu.tscn")


func _on_play_pressed():
	global.loadData()
	if global.current_scene == "level1":
		if global.matrix:
			print("playmenu")
			print(global.current_point)
			get_tree().change_scene_to_file(global.matrix[global.current_point.x][global.current_point.y]["type"])
			return
	get_tree().change_scene_to_file("res://Levels/base.tscn")
	


func _on_erase_pressed():
	global.deleteData()


func _on_slot_1_pressed():
	if $"TextureRect/NinePatchRect/VBoxContainer/Node2D/Slot 1".self_modulate == Color.BLUE:
		
		global.slot_id = dataSlots[0]["id"]
		$TextureRect/NinePatchRect/Play.show()
		$TextureRect/NinePatchRect/Erase.show()
#	else:
#		db.open_db()
#		# crear nuevo espacio
#		var tableName = "GameData"
#		var dict : Dictionary = Dictionary()
#		dict["user_id"] = global.user_id
#		db.insert_row(tableName, dict)
