extends Node2D

var map = false

func _process(delta):
	queue_redraw()
	
func _input(event):
	if event.is_action_pressed("Draw"):
		map = true

func _draw():
	if map:
		# Tamaño del cuadrado negro
		var black_square = Rect2(50, 20, 150, 100)
		draw_rect(black_square, Color.BLACK)

		# Tamaño de cada rectángulo blanco
		var rect_size = 5

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
						draw_rect(Rect2(rect_x, rect_y, rect_size, rect_size), Color.WHITE)


	#draw_line(Vector2(50,20), Vector2(200,20), Color.SNOW, 8)
