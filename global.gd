extends Node

var matrix 
var matrix_size = 7
var current_point
var end_point
var current_scene = "base"
var transition_scene = false

var player_position = "start"

func finish_changedscenes():
	if transition_scene == true:
		transition_scene = false

func change_room():
	current_scene = "level1"
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
