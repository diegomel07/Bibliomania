extends Node2D


var matrix 
var matrix_size = global.matrix_size
var start_point
var end_point

func _ready():
	
	create_matrix()
	
	for i in range(6):
		start_point = choose_border_point()
		matrix[start_point[0].x][start_point[0].y]["exists"] = true
		end_point = choose_border_point(start_point[1])
		create_path(start_point[0], end_point[0])
		
	calculate_room_connections()
#	print(start_point, end_point)
#	print_matrix_with_connections()
	print_simplified()
	global.current_point = start_point[0]
	global.end_point = end_point[0]
	global.matrix = matrix
	global.transition_scene = true
	change_scene()
	
	
	
func create_matrix():
	
	matrix = []
	for x in range(matrix_size):
		var row = []
		for y in range(matrix_size):
			row.append({"exists": false, "room": null})
		matrix.append(row)
		
func calculate_room_connections():
	
	for x in range(matrix_size):
		for y in range(matrix_size):
			if matrix[x][y]["exists"] == true:
				var connection_array = []
				if y + 1 < matrix_size and matrix[x][y + 1]["exists"] == true:
					connection_array.append("right")
				if y - 1 >= 0 and matrix[x][y - 1]["exists"] == true:
					connection_array.append("left")
				if x - 1 >= 0 and matrix[x - 1][y]["exists"] == true:
					connection_array.append("up")
				if x + 1 < matrix_size and matrix[x + 1][y]["exists"] == true:
					connection_array.append("down")
				# aca podriamos llamar a una funcion que retorne el tipo (square, rectangle, etc) xd
				matrix[x][y]["type"] = "res://Room/Room" + "Square" + ".tscn"
				matrix[x][y]["connections"] = connection_array

func choose_border_point(selected_size = null):
	
	var side = randi() % 4  
	
	if selected_size != null:
		side = null
	if side == 0 or selected_size == "down":
		return [Vector2(randi() % matrix_size, 0), "up"] 
	elif side == 1 or selected_size == "left":
		return [Vector2(matrix_size - 1, randi() % matrix_size), "right" ] 
	elif side == 2 or selected_size == "up":
		return [Vector2(randi() % matrix_size, matrix_size - 1), "down" ] 
	else:
		return [Vector2(0, randi() % matrix_size), "left"]  
		
func create_path(start, end):

	var current_point = start
	while current_point != end:
		var next_point = move_towards(current_point, end)
		matrix[next_point.x][next_point.y]["exists"] = true
		current_point = next_point

func move_towards(current_point, target_point):

	var direction = target_point - current_point
	
	if abs(direction.x) > abs(direction.y):
		return Vector2(current_point.x + sign(direction.x), current_point.y)
	else:
		return Vector2(current_point.x, current_point.y + sign(direction.y))

func sign(value):
	
	return (value > 0) - (value < 0)

func print_matrix_with_connections():
	
	for x in range(matrix_size):
		var row_str = ""
		for y in range(matrix_size):
			row_str += "[" + str(matrix[x][y]["exists"]) + ", " + str(matrix[x][y]["room"]) + "] "
		print(row_str)

func print_simplified():
	for x in range(matrix_size):
		var row_str = ""
		for y in range(matrix_size):
			row_str += str(int(matrix[x][y]["exists"])) + " "
		print(row_str)

func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "initialize":
			global.change_room()
			global.finish_changedscenes()
