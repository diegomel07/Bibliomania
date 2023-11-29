extends Control

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
	get_tree().change_scene_to_file("res://Gui/settings/titleScreen.tscn")


func _on_slot_1_pressed():
	global.slot_id = dataSlots[0]["id"]
	global.loadData()
	get_tree().change_scene_to_file("res://Levels/base.tscn")
	
