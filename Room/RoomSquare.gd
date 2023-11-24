extends Node2D

func _ready():
	
	var door_down_Asset = $Doors/LevelDoor.sprite
	var door_right_Asset = $Doors/LevelDoor2.sprite
	var door_left_Asset = $Doors/LevelDoor3.sprite
	var door_up_Asset = $Doors/LevelDoor4.sprite
#	var door_down_Collision = $Doors/Ddown
#	var door_right_Collision = $Doors/Dright
#	var door_left_Collision = $Doors/Dleft
#	var door_up_Collision = $Doors/Dup
	
	if "down" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
		door_down_Asset.visible = true
		#door_down_Collision.disabled = true
	else:
		door_down_Asset.visible = false
		#door_down_Collision.disabled = false
		
	if "right" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
		door_right_Asset.visible = true
		#door_right_Collision.disabled = true
	else:
		door_right_Asset.visible = false
		#door_right_Collision = false
		
	if "left" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
		door_left_Asset.visible = true
		#door_left_Collision.disabled = true
	else:
		door_left_Asset.visible = false
		#door_left_Collision.disabled = false
		
	if "up" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
		door_up_Asset.visible = true
		#door_up_Collision.disabled = true
	else:
		door_up_Asset.visible = false
		#door_up_Collision.disabled = false
		
	if global.player_position == "down":
		$Alice.position.x = 160
		$Alice.position.y = 30
	if global.player_position == "left":
		$Alice.position.x = 280
		$Alice.position.y = 88
	if global.player_position == "right":
		$Alice.position.x = 40
		$Alice.position.y = 88
	if global.player_position == "up":
		$Alice.position.x =160
		$Alice.position.y = 128
	if global.player_position == "start":
		$Alice.position.x = 160
		$Alice.position.y = 88
		
		
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("CloseDoors"):
		$Doors/LevelDoor.ap.play("AboutToClose")
		$Doors/LevelDoor2.ap.play("AboutToClose")
		$Doors/LevelDoor3.ap.play("AboutToClose")
		$Doors/LevelDoor4.ap.play("AboutToClose")
		
		$Timer.start()
		await $Timer.timeout
		
		$Doors/LevelDoor.ap.play("Close")
		$Doors/LevelDoor2.ap.play("Close")
		$Doors/LevelDoor3.ap.play("Close")
		$Doors/LevelDoor4.ap.play("Close")
		
	if event.is_action_pressed("OpenDoors"):
		$Doors/LevelDoor.ap.play("AboutToOpen")
		$Doors/LevelDoor2.ap.play("AboutToOpen")
		$Doors/LevelDoor3.ap.play("AboutToOpen")
		$Doors/LevelDoor4.ap.play("AboutToOpen")
		
		$Timer.start()
		await $Timer.timeout
		
		$Doors/LevelDoor.ap.play("Open")
		$Doors/LevelDoor2.ap.play("Open")
		$Doors/LevelDoor3.ap.play("Open")
		$Doors/LevelDoor4.ap.play("Open")

func _on_level_door_4_body_entered(body):
	if body.has_method("player"): 
		if "up" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
			global.next_room("up")
			global.player_position = "up"


func _on_level_door_3_body_entered(body):
	if body.has_method("player"):
		if "left" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
			global.next_room("left")
			global.player_position = "left"


func _on_level_door_2_body_entered(body):
	if body.has_method("player"):
		if "right" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
			global.next_room("right")
			global.player_position = "right"


func _on_level_door_body_entered(body):
	if body.has_method("player"):
		if "down" in global.matrix[global.current_point.x][global.current_point.y]["connections"]:
			global.next_room("down")
			global.player_position = "down"
