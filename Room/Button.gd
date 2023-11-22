
var matrix 
var matrix_size = 7
var start_point
var end_point
var room_scenes = [
	preload("res://Room/Room1.tscn"),
	preload("res://Room/Room2.tscn"),
	preload("res://Room/Room3.tscn"),
	preload("res://Room/Room4.tscn"),
	preload("res://Room/Room5.tscn"),
	preload("res://Room/Room6.tscn"),
	preload("res://Room/Room7.tscn"),
	preload("res://Room/Room8.tscn"),
	preload("res://Room/Room9.tscn"),
	preload("res://Room/Room10.tscn"),
	preload("res://Room/Room11.tscn"),
	preload("res://Room/Room12.tscn"),
	preload("res://Room/Room13.tscn"),
	preload("res://Room/Room14.tscn"),
	preload("res://Room/Room15.tscn"),
	
	# ... continua con las demás escenas de habitaciones
]
func _ready():
	create_matrix()
	for i in range(3):
		# Elegir un punto en el borde al azar
		start_point = choose_border_point()
	# Colocar un "1" en el borde al azar
		matrix[start_point[0].x][start_point[0].y] = 1
	# Elegir otro punto en el borde al azar
		end_point = choose_border_point(start_point[1])
	# Crear un camino de "1"s desde el punto inicial hasta el punto final
		create_path(start_point[0], end_point[0])
	print_matrix()
	print(start_point, end_point)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


	
func create_matrix():
	matrix = []
	# Inicializar la matriz con ceros
	for x in range(matrix_size):
		var row = []
		for y in range(matrix_size):
			row.append(0)
		matrix.append(row)
		
func choose_border_point(selected_size = null):
	# Elegir un punto en el borde al azar
	var side = randi() % 4  # 0: arriba, 1: derecha, 2: abajo, 3: izquierda
	if selected_size != null:
		side = null
	if side == 0 or selected_size == "down":
		return [Vector2(randi() % matrix_size, 0), "up"] # Arriba
	elif side == 1 or selected_size == "left":
		return [Vector2(matrix_size - 1, randi() % matrix_size), "right" ] # Derecha
	elif side == 2 or selected_size == "up":
		return [Vector2(randi() % matrix_size, matrix_size - 1), "down" ] # Abajo
	else:
		return [Vector2(0, randi() % matrix_size), "left"]  # Izquierda
		
func create_path(start_point, end_point):
	# Crear un camino de "1"s desde el punto inicial hasta el punto final
	var current_point = start_point
	while current_point != end_point:
		var next_point = move_towards(current_point, end_point)
		matrix[next_point.x][next_point.y] = 1
		current_point = next_point

func move_towards(current_point, target_point):
	# Mover hacia el punto objetivo horizontal o verticalmente
	var direction = target_point - current_point
	if abs(direction.x) > abs(direction.y):
		return Vector2(current_point.x + sign(direction.x), current_point.y)
	else:
		return Vector2(current_point.x, current_point.y + sign(direction.y))

func sign(value):
	# Devolver el signo de un valor
	return (value > 0) - (value < 0)
	
		
func print_matrix():
	for x in range(matrix_size):
		var row_str = ""
		for y in range(matrix_size):
			row_str += str(matrix[x][y]) + " "
		print(row_str)
