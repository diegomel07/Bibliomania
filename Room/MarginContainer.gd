extends MarginContainer

var map = false
var black_square = Rect2(115, 45, 90, 90) # Tamaño del cuadrado negro
const rect_size = 10 # Tamaño de cada rectángulo blanco
var vertical_spacing = 3.32  # Espaciado vertical entre rectángulos blancos
var horizontal_spacing = 3.32  # Espaciado horizontal entre rectángulos blancoss


func _ready():
	print_matrix()

func _process(delta):
	queue_redraw()
	
func _input(event):
	if event.is_action_pressed("Map"):
		if map == true:
			$"../DirectionalLight2D".energy = 0
			$"..".visible = false
			map = false
		else:
			$"../DirectionalLight2D".energy = 0.6
			$"..".visible = true
			map = true


func print_matrix():
	for line in global.matrix:
		for room in line:
			print(room)
			print()

func _draw():
	if map:
		draw_rect(black_square, Color.BLACK)
		
		var current_id
		
		for x in range(global.matrix_size):
			for y in range(global.matrix_size):
				if int(global.matrix[x][y]["exists"]) == 1:
					# Calcula las coordenadas del rectángulo blanco
					var rect_x = black_square.position.x + (rect_size + horizontal_spacing) * y
					var rect_y = black_square.position.y + (rect_size + vertical_spacing) * x

					# Verifica que el rectángulo blanco no se salga del cuadrado negro
					if (checkWhiteBox(rect_x, rect_y)):
						# Dibuja el rectángulo blanco
						if Vector2(x,y) == global.current_point or global.matrix[x][y]["id"] == current_id:
							findFigure(global.matrix[x][y]["id"])
							current_id = global.matrix[x][y]["id"]
							#global.rooms_alredy_passed.append(current_id)
						else:
							if global.matrix[x][y]["id"] in global.rooms_alredy_passed:
								draw_rect(Rect2(rect_x, rect_y, rect_size, rect_size), Color(1, 1, 1, 0.3))
							else:
								draw_rect(Rect2(rect_x, rect_y, rect_size, rect_size), Color.WHITE)

func findFigure(id):
	for i in range(global.matrix_size):
			for j in range(global.matrix_size):
				if int(global.matrix[i][j]["exists"]) == 1:
					# Calcula las coordenadas del rectángulo blanco
					var rect_i = black_square.position.x + (rect_size + horizontal_spacing) * j
					var rect_j = black_square.position.y + (rect_size + vertical_spacing) * i
					
					# Verifica que el rectángulo no se salga del cuadrado negro
					if (checkWhiteBox(rect_i, rect_j)):
						# Dibuja el rectángulo rojo
						if global.matrix[i][j]["id"] == id:
							draw_rect(Rect2(rect_i, rect_j, rect_size, rect_size), Color.RED)

func checkWhiteBox(x, y):
	if (
		x >= black_square.position.x
		and x + rect_size <= black_square.position.x + black_square.size.x
		and y >= black_square.position.y
		and y + rect_size <= black_square.position.y + black_square.size.y
	):
		return true
	return false
