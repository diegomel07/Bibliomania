extends Node

# user
var user_id
var slot_id

# level
var matrix 
var matrix_size = 7
var rooms_alredy_passed: Array
var current_point
var end_point
var current_scene = "base"
var transition_scene = false
var level_count = 1

var db #database object
var db_name = "res://Data/bibliomania" #path to db

# stats
var death_count = 0

# alice
var health = 100
var damage = 33

var player_current_attack = false

var player_position = "start"

func finish_changedscenes():
	if transition_scene == true:
		transition_scene = false

func change_room():
	current_scene = "level1"
	rooms_alredy_passed.append(matrix[current_point.x][current_point.y]["id"])
	get_tree().change_scene_to_file(matrix[current_point.x][current_point.y]["type"])

func next_room(direction):

	match direction:
		"up":
			current_point.x -= 1
		"down":
			current_point.x += 1
		"right":
			current_point.y += 1
		"left":
			current_point.y -= 1
	change_room()

func saveData():
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	var tableName = "GameData"
	var dict : Dictionary = Dictionary()
	dict["user_id"] = user_id
	dict["matrix"] = parseMatrix() # la matrix debe venir en una cadena de texto
	dict["matrix_size"] = matrix_size
	dict["rooms_already_passed"] = parseRoomsId() # debe venir en una cadena de texto
	dict["current_point"] = current_point
	dict["end_point"] = end_point
	dict["current_scene"] = current_scene
	dict["death_count"] = death_count
	dict["health"] = health
	dict["damage"] = damage
	dict["level_count"] = level_count
	
	db.insert_row(tableName, dict)


func loadData():
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	# seria elegir la que se quiere cargar de acuerdo al slot presionado
	db.query("SELECT * from GameData where user_id = " + str(global.user_id) +  " and id = " + str(slot_id) +";")
	
	# se asigna cada espacio del resultado a las variables globales
	matrix = db.query_result[0]["matrix"] # toca arreglarla
	matrix_size = db.query_result[0]["matrix_size"]
	rooms_alredy_passed = db.query_result[0]["rooms_already_passed"] # toca arreglarla
	current_point = db.query_result[0]["current_point"]
	end_point = db.query_result[0]["end_point"]
	current_scene = db.query_result[0]["current_scene"]
	death_count = db.query_result[0]["death_count"]
	health = db.query_result[0]["health"]
	damage = db.query_result[0]["damage"]
	level_count = db.query_result[0]["level_count"]
	

func deleteData():
	db = SQLite.new()
	db.path = db_name
	db.open_db()
	db.query("DELETE from GameData where user_id = " + str(global.user_id) +  " and id = " + str(slot_id) +";")

func parseMatrix() -> String:
	var parse_matrix: String = ''
	for i in range(matrix_size):
		for j in range(matrix_size):
			parse_matrix += str(matrix[i][j]) + ' '
	return parse_matrix
	

func parseRoomsId() -> String:
	var parse_ids: String = ''
	for id in rooms_alredy_passed:
		parse_ids += str(id) + ' '
	return parse_ids
