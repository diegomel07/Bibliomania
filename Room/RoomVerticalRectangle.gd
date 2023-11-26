extends Node2D
var entrance 
func _ready():
	
	entrance = global.matrix[global.current_point.x][global.current_point.y]["figure"]
	
	var door_down_Asset = $Doors/DownDoor/LevelDoor.sprite
	var door_right_Asset = $Doors/RigthDoor/LevelDoor2.sprite
	var door_left_Asset = $Doors/LeftDoor/LevelDoor3.sprite
	var door_up_Asset = $Doors/UpDoor/LevelDoor4.sprite
	
	var door_left_Asset2 = $Doors/LeftDoor2/LevelDoor3.sprite
	var door_right_Asset2 = $Doors/RigthDoor2/LevelDoor2.sprite	
	
	var door_down_collision = $Doors/DownDoor/DoorCollision.collision
	var door_up_collision = $Doors/UpDoor/DoorCollision.collision
	var door_left_collision = $Doors/LeftDoor/DoorCollision.collision
	var door_rigth_collision = $Doors/RigthDoor/DoorCollision.collision
	
	var door_left_collision2 = $Doors/LeftDoor2/DoorCollision.collision
	var door_rigth_collision2 = $Doors/RigthDoor2/DoorCollision.collision
	
	match entrance:
			"rectangle top":
				if "right" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
						door_right_Asset.visible = true
						door_rigth_collision.disabled = true
				else:
					door_right_Asset.visible = false
					door_rigth_collision.disabled = false
						
				if "right" in global.matrix[global.current_point.x + 1][global.current_point.y]["connections"]:
					door_right_Asset2.visible = true
					door_rigth_collision2.disabled = true
				else:
					door_right_Asset2.visible = false
					door_rigth_collision2.disabled = false
						
				if "left" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
					door_left_Asset.visible = true
					door_left_collision.disabled = true
				else:
					door_left_Asset.visible = false
					door_left_collision.disabled = false
						
				if "left" in global.matrix[global.current_point.x + 1][global.current_point.y]["connections"]:
					door_left_Asset2.visible = true
					door_left_collision2.disabled = true
				else:
					door_left_Asset2.visible = false
					door_left_collision2.disabled = false
					
				if "up" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
					door_up_Asset.visible = true
					door_up_collision.disabled = true
				else:
					door_up_Asset.visible = false
					door_up_collision.disabled = false
					
				if "down" in global.matrix[global.current_point.x + 1][global.current_point.y]["connections"]:
					door_down_Asset.visible = true
					door_down_collision.disabled = true
				else:
					door_down_Asset.visible = false
					door_down_collision.disabled = false

				if global.player_position == "down":
					$Alice.position.x = $Doors/UpDoor/LevelDoor4.position.x
					$Alice.position.y = $Doors/UpDoor/LevelDoor4.position.y + 20
				if global.player_position == "left":
					$Alice.position.x = $Doors/RigthDoor/LevelDoor2.position.x - 20
					$Alice.position.y = $Doors/RigthDoor/LevelDoor2.position.y
				if global.player_position == "right":
					$Alice.position.x = $Doors/LeftDoor/LevelDoor3.position.x + 20
					$Alice.position.y = $Doors/LeftDoor/LevelDoor3.position.y
					
			"rectangle bottom":
				if "right" in global.matrix[global.current_point.x - 1][global.current_point.y]["connections"]:
						door_right_Asset.visible = true
						door_rigth_collision.disabled = true
				else:
					door_right_Asset.visible = false
					door_rigth_collision.disabled = false
						
				if "right" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
					door_right_Asset2.visible = true
					door_rigth_collision2.disabled = true
				else:
					door_right_Asset2.visible = false
					door_rigth_collision2.disabled = false
						
				if "left" in global.matrix[global.current_point.x - 1][global.current_point.y]["connections"]:
					door_left_Asset.visible = true
					door_left_collision.disabled = true
				else:
					door_left_Asset.visible = false
					door_left_collision.disabled = false
						
				if "left" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
					door_left_Asset2.visible = true
					door_left_collision2.disabled = true
				else:
					door_left_Asset2.visible = false
					door_left_collision2.disabled = false
					
				if "up" in global.matrix[global.current_point.x - 1][global.current_point.y]["connections"]:
					door_up_Asset.visible = true
					door_up_collision.disabled = true
				else:
					door_up_Asset.visible = false
					door_up_collision.disabled = false
					
				if "down" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
					door_down_Asset.visible = true
					door_down_collision.disabled = true
				else:
					door_down_Asset.visible = false
					door_down_collision.disabled = false
				if global.player_position == "left":
					$Alice.position.x = $Doors/RigthDoor2/LevelDoor2.position.x - 20
					$Alice.position.y = $Doors/RigthDoor2/LevelDoor2.position.y
				if global.player_position == "right":
					$Alice.position.x = $Doors/LeftDoor2/LevelDoor3.position.x + 20
					$Alice.position.y = $Doors/LeftDoor2/LevelDoor3.position.y
				if global.player_position == "up":
					$Alice.position.x = $Doors/DownDoor/LevelDoor.position.x
					$Alice.position.y = $Doors/DownDoor/LevelDoor.position.y - 20
		
func _process(delta):
	pass

func _input(event):
	
	if event.is_action_pressed("CloseDoors"):
		
		for door in $Doors.get_children():
			door.get_children()[1].collision.disabled = false
			door.get_children()[0].ap.play("AboutToClose")
		
		$Timer.start()
		await $Timer.timeout
		
		for door in $Doors.get_children():
			door.get_children()[0].ap.play("Close")
		
	if event.is_action_pressed("OpenDoors"):
		
		for door in $Doors.get_children():
			door.get_children()[1].collision.disabled = true
			door.get_children()[0].ap.play("AboutToOpen")
		
		$Timer.start()
		await $Timer.timeout
		
		for door in $Doors.get_children():
			door.get_children()[0].ap.play("Open")

func _on_level_door_4_body_entered(body):
	if body.has_method("player"):
		match entrance:
			"rectangle top":
				if "up" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
					global.next_room("up")
					global.player_position = "up"
			"rectangle bottom":
				if "up" in global.matrix[global.current_point.x - 1][global.current_point.y]["connections"]:
					global.current_point.x -= 1
					global.next_room("up")
					global.player_position = "up"

func _on_level_door_3_body_entered(body):
	if body.has_method("player"):
		match entrance:
			"rectangle top":
				if "left" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
					global.next_room("left")
					global.player_position = "left"
			"rectangle bottom":
				if "left" in global.matrix[global.current_point.x - 1][global.current_point.y]["connections"]:
					global.current_point.x -= 1
					global.next_room("left")
					global.player_position = "left"

func _on_level_door_3_body_entered_2(body):
	if body.has_method("player"):
		match entrance:
			"rectangle top":
				if "left" in global.matrix[global.current_point.x + 1][global.current_point.y]["connections"]:
					global.current_point.x += 1
					global.next_room("left")
					global.player_position = "left"
			"rectangle bottom":
				if "left" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
					global.next_room("left")
					global.player_position = "left"
					
func _on_level_door_2_body_entered(body):
	if body.has_method("player"):
		match entrance:
			"rectangle top":
				if "right" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
					global.next_room("right")
					global.player_position = "right"
			"rectangle bottom":
				if "right" in global.matrix[global.current_point.x - 1][global.current_point.y]["connections"]:
					global.current_point.x -= 1
					global.next_room("right")
					global.player_position = "right"

func _on_level_door_2_body_entered_2(body):
	if body.has_method("player"):
		match entrance:
			"rectangle top":
				if "right" in global.matrix[global.current_point.x + 1][global.current_point.y]["connections"]:
					global.current_point.x += 1
					global.next_room("right")
					global.player_position = "right"
			"rectangle bottom":
				if "right" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
					global.next_room("right")
					global.player_position = "right"
	
func _on_level_door_body_entered(body):
	if body.has_method("player"):
		match entrance:
			"rectangle top":
				if "down" in global.matrix[global.current_point.x + 1][global.current_point.y]["connections"]:
					global.current_point.x += 1
					global.next_room("down")
					global.player_position = "down"
			"rectangle bottom":
				if "down" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
					global.next_room("down")
					global.player_position = "down"
