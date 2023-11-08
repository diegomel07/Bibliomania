extends CharacterBody2D

var speed:int = 80

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

@export var inventory: Inventory

var past_direction: Vector2 = Vector2.ZERO

func _process(_delta):
	
	
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction.normalized() * speed
	
	# flipping the character
	if direction.x != 0:
		sprite.flip_h = (direction.x >= -1 and direction.x < 0)
	
	move_and_slide()
	
	if past_direction != direction:
		print(past_direction, direction)
		update_animations(direction, past_direction)
	
	past_direction = direction
	
	mouse_rotation(ap.current_animation)


func update_animations(direction: Vector2, past_direction: Vector2) -> void:
	
	var mouse_coordinates = get_local_mouse_position()
	#print(mouse_coordinates)
	
	# idle
	if direction == Vector2.ZERO:
		if past_direction.y == -1:
			print('idle up')
			ap.play("idle_up")
		else:
			print('idle')
			ap.play("idle")
	
	elif direction.y == -1:
		print('up')
		ap.play("up")
	
	elif direction.y == 1:
		print('down')
		ap.play("down")
	
	else:
		print('run')
		ap.play("run")

func mouse_rotation(current_animation: String) -> void:
	
	var mouse_position = get_local_mouse_position().normalized()
	
	print(mouse_position)
	
	if current_animation == "idle":
		if mouse_position.y < 0:
			ap.play("idle_up") 
	
	elif current_animation == "idle_up":
		if mouse_position.y > 0:
			ap.play("idle")
	
	elif current_animation == "up":
		if mouse_position.y > 0:
			ap.play_backwards("down")
	
	elif current_animation == "down":
		if mouse_position.y < 0:
			ap.play_backwards("up")
			
	elif current_animation == "run":
		#left
		if sprite.flip_h:
			if mouse_position.x > 0:
				sprite.flip_h = false
				ap.play_backwards("run")
		#right
		else:
			if mouse_position.x < 0:
				sprite.flip_h = true
				ap.play_backwards("run")
		



func _on_area_2d_area_entered(area):
	if area.has_method("collect"):
		area.collect()
