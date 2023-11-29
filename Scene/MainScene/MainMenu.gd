extends Control

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Gui/settings/titleScreen.tscn")
