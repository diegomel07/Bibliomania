extends Control

signal opened
signal closed
var isOpen: bool = false

var db #database object
var db_name = "res://Data/bibliomania" #path to db

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func sett_open():
	visible = true
	isOpen = true
	$TextureRect.show()
	opened.emit()


func _on_no_pressed():
	visible = false
	isOpen = false	
	$TextureRect.hide()
	closed.emit()


func _on_yes_pressed():
	visible = false
	isOpen = false	
	$TextureRect.hide()
	closed.emit()
	
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	var tableName = "User"
	
	db.query("DELETE FROM "+tableName+" WHERE USERNAME = '"+Global.CURRENTUSER+"';")
	
	get_tree().change_scene_to_file("res://Gui/settings/titleScreen.tscn")
