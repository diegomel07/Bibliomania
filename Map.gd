extends Node2D

var map = false

func _ready():
	print_matrix()

func _process(delta):
	queue_redraw()
	
func _input(event):
	if event.is_action_pressed("Map"):
		if map == true:
			map = false
		else:
			map = true


func print_matrix():
	for line in global.matrix:
		for room in line:
			print(room)
			print()

func _draw():
	if map:
		# Tamaño del cuadrado negro
		var black_square = Rect2(50, 20, 150, 100)
		draw_rect(black_square, Color.BLACK)

		# Tamaño de cada rectángulo blanco
		var rect_size = 5
		var current_id

		# Espaciado vertical entre rectángulos blancos
		var vertical_spacing = 2  # Puedes ajustar este valor según tus necesidades

		# Espaciado horizontal entre rectángulos blancos
		var horizontal_spacing = 0.5  # Puedes ajustar este valor según tus necesidades
		
		for x in range(global.matrix_size):
			for y in range(global.matrix_size):
				if int(global.matrix[x][y]["exists"]) == 1:
					# Calcula las coordenadas del rectángulo blanco
					var rect_x = black_square.position.x + (rect_size + horizontal_spacing) * y
					var rect_y = black_square.position.y + (rect_size + vertical_spacing) * x

					# Verifica que el rectángulo blanco no se salga del cuadrado negro
					if (
						rect_x >= black_square.position.x
						and rect_x + rect_size <= black_square.position.x + black_square.size.x
						and rect_y >= black_square.position.y
						and rect_y + rect_size <= black_square.position.y + black_square.size.y
					):
						# Dibuja el rectángulo blanco
						if Vector2(x,y) == global.current_point or global.matrix[x][y]["id"] == current_id:
							findFigure(global.matrix[x][y]["id"])
							current_id = global.matrix[x][y]["id"]
						else:
							draw_rect(Rect2(rect_x, rect_y, rect_size, rect_size), Color.WHITE)

func findFigure(id):
	
	# Tamaño del cuadrado negro
	var black_square = Rect2(50, 20, 150, 100)

	# Tamaño de cada rectángulo blanco
	var rect_size = 5

	# Espaciado vertical entre rectángulos blancos
	var vertical_spacing = 2  # Puedes ajustar este valor según tus necesidades

	# Espaciado horizontal entre rectángulos blancos
	var horizontal_spacing = 0.5  # Puedes ajustar este valor según tus necesidades
	for i in range(global.matrix_size):
			for j in range(global.matrix_size):
				if int(global.matrix[i][j]["exists"]) == 1:
					# Calcula las coordenadas del rectángulo blanco
					var rect_i = black_square.position.x + (rect_size + horizontal_spacing) * j
					var rect_j = black_square.position.y + (rect_size + vertical_spacing) * i

					# Verifica que el rectángulo blanco no se salga del cuadrado negro
					if (
						rect_i >= black_square.position.x
						and rect_i + rect_size <= black_square.position.x + black_square.size.x
						and rect_j >= black_square.position.y
						and rect_j + rect_size <= black_square.position.y + black_square.size.y
					):
						# Dibuja el rectángulo blanco
						if global.matrix[i][j]["id"] == id:
							draw_rect(Rect2(rect_i, rect_j, rect_size, rect_size), Color.RED)
