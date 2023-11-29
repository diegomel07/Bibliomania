extends Node2D

var matrix 
var matrix_size = global.matrix_size
var start_point
var end_point
var current_room

var path

func _ready():
	path = []
	create_matrix()

	start_point = choose_border_point()
	matrix[start_point[0].x][start_point[0].y]["exists"] = true
	matrix[start_point[0].x][start_point[0].y]["type"] = "res://Room/Room" + "Square" + ".tscn"
	matrix[start_point[0].x][start_point[0].y]["figure"] = "Square"
	matrix[start_point[0].x][start_point[0].y]["id"] = randi()
	end_point = choose_border_point(start_point[1])
	matrix[end_point[0].x][end_point[0].y]["exists"] = true
	matrix[end_point[0].x][end_point[0].y]["type"] = "res://Room/Room" + "Square" + ".tscn"
	matrix[end_point[0].x][end_point[0].y]["figure"] = "Square"
	matrix[end_point[0].x][end_point[0].y]["id"] = randi()
	
	create_path(start_point[0], end_point[0], true)

	create_paths()
	#print_simplified()

	calculate_room_connections()
	#print_matrix_with_connections()
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
				matrix[x][y]["connections"] = connection_array
				validate_figure(x, y, connection_array)
				
func validate_figure(x,y, connections):
	var positions = {}
	if matrix[x][y].has("figure"):
		return
	if "down" in connections:
		if !matrix[x + 1][y].has("figure"):
			positions["down"] = Vector2(x + 1, y)
	if "right" in connections:
		if !matrix[x][y + 1].has("figure"):
			positions["right"] = Vector2(x, y + 1)
	if x + 1 < matrix_size and y + 1 < matrix_size and matrix[x + 1][y + 1]["exists"] == true:
		if !matrix[x + 1][y + 1].has("figure"):
			positions["bottom right"] = Vector2(x + 1, y + 1)
	selected_figure(positions, x, y)
		
func selected_figure(positions, x , y):
	var id = randi()
	var figures = []
	var figure 
	figures.append("square")
	if positions.has("down"):
		figures.append("vertical rectangle")
	if positions.has("right"):
		figures.append("horizontal rectangle")
	if positions.has("down") and positions.has("bottom right"):
		figures.append("L")
	if positions.has("down") and positions.has("right"):
		figures.append("inverted L")
	if positions.has("down") and positions.has("bottom right") and positions.has("right"):
		figures.append("Big square")
	figure = figures[randi() % figures.size()]	
	
	var id_figure
	
	match figure:
		"square":
			matrix[x][y]["figure"] = "square"
			matrix[x][y]["id"] = id
			matrix[x][y]["type"] = "res://Room/Room" + "Square" + ".tscn"
			
		"vertical rectangle":
			matrix[x][y]["figure"] = "rectangle top"
			matrix[x][y]["id"] = id
			matrix[x][y]["type"] = "res://Room/Room" + "VerticalRectangle" + ".tscn"
			
			matrix[positions["down"].x][positions["down"].y]["figure"] = "rectangle bottom"
			matrix[positions["down"].x][positions["down"].y]["id"] = id
			matrix[positions["down"].x][positions["down"].y]["type"] = "res://Room/Room" + "VerticalRectangle" + ".tscn"
			
		"horizontal rectangle":
			matrix[x][y]["figure"] = "rectangle left"
			matrix[x][y]["id"] = id
			matrix[x][y]["type"] = "res://Room/Room" + "HorizontalRectangle" + ".tscn"
			
			matrix[positions["right"].x][positions["right"].y]["figure"] = "rectangle right"
			matrix[positions["right"].x][positions["right"].y]["id"] = id
			matrix[positions["right"].x][positions["right"].y]["type"] = "res://Room/Room" + "HorizontalRectangle" + ".tscn"
			
		"L":
			matrix[x][y]["figure"] = "L top"
			matrix[x][y]["id"] = id
			matrix[x][y]["type"] = "res://Room/Room" + "L" + ".tscn"
			
			matrix[positions["down"].x][positions["down"].y]["figure"] = "L bot"
			matrix[positions["down"].x][positions["down"].y]["id"] = id
			matrix[positions["down"].x][positions["down"].y]["type"] = "res://Room/Room" + "L" + ".tscn"
			
			matrix[positions["bottom right"].x][positions["bottom right"].y]["figure"] = "L bottom right"
			matrix[positions["bottom right"].x][positions["bottom right"].y]["id"] = id
			matrix[positions["bottom right"].x][positions["bottom right"].y]["type"] = "res://Room/Room" + "L" + ".tscn"
			
			
		"inverted L":
			matrix[x][y]["figure"] = "inverted L top"
			matrix[x][y]["id"] = id
			matrix[x][y]["type"] = "res://Room/Room" + "InvertedL" + ".tscn"
			
			matrix[positions["down"].x][positions["down"].y]["figure"] = "inverted L bot"
			matrix[positions["down"].x][positions["down"].y]["id"] = id
			matrix[positions["down"].x][positions["down"].y]["type"] = "res://Room/Room" + "InvertedL" + ".tscn"
			
			matrix[positions["right"].x][positions["right"].y]["figure"] = "inverted L right"
			matrix[positions["right"].x][positions["right"].y]["id"] = id
			matrix[positions["right"].x][positions["right"].y]["type"] = "res://Room/Room" + "InvertedL" + ".tscn"
			
		"Big square":
			matrix[x][y]["figure"] = "square top left"
			matrix[x][y]["id"] = id
			matrix[x][y]["type"] = "res://Room/Room" + "BigSquare" + ".tscn"

			matrix[positions["down"].x][positions["down"].y]["figure"] = "square left bot"
			matrix[positions["down"].x][positions["down"].y]["id"] = id
			matrix[positions["down"].x][positions["down"].y]["type"] = "res://Room/Room" + "BigSquare" + ".tscn"

			matrix[positions["right"].x][positions["right"].y]["figure"] = "square top right"
			matrix[positions["right"].x][positions["right"].y]["id"] = id
			matrix[positions["right"].x][positions["right"].y]["type"] = "res://Room/Room" + "BigSquare" + ".tscn"

			matrix[positions["bottom right"].x][positions["bottom right"].y]["figure"] = "square bottom right"
			matrix[positions["bottom right"].x][positions["bottom right"].y]["id"] = id
			matrix[positions["bottom right"].x][positions["bottom right"].y]["type"] = "res://Room/Room" + "BigSquare" + ".tscn"

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

func create_paths():
	for i in range(path.size()):
		var current_point = path[i]
		if randf() < 0.7:  
			var random_point = unique_random_point()
			create_path(current_point, random_point, false)
	
func choose_random_point():
	var random_row = randi() % matrix_size
	var random_column = randi() % matrix_size
	return Vector2(random_row, random_column)
	
func unique_random_point():
	var random_point = choose_random_point()
	while path.find(random_point) != -1:
		random_point = choose_random_point()
	return random_point		
	
func create_path(start, end, save):	
	var current_point = start
	while current_point != end:
		var next_point = move_towards(current_point, end)
		if save == true:
			path.append(next_point)
		matrix[next_point.x][next_point.y]["exists"] = true
		current_point = next_point
	if save == true:	
		path.append(end)
	
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
			if matrix[x][y].has("figure"):
				row_str += "[" + str(matrix[x][y]["figure"]) + "] "
			else:
				row_str += "      0      "
		
func print_simplified():
	
	for x in range(matrix_size):
		var row_str = ""
		for y in range(matrix_size):
			row_str += str(int(matrix[x][y]["exists"])) + " "
				
func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "initialize":
			global.change_room()
			global.finish_changedscenes()


