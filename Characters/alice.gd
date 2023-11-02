extends CharacterBody2D

var speed:int = 80

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

var past_direction: Vector2 = Vector2.ZERO

func _process(_delta):
	
	# input
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	
	# flipping the character
	if direction.x != 0:
		sprite.flip_h = (direction.x >= -1 and direction.x < 0)
		
	move_and_slide()
	
	if past_direction != direction:
		print(past_direction, direction)
		update_animations(direction, past_direction)
	
	past_direction = direction
	
	# rotate
	# look_at(get_global_mouse_position())

func update_animations(direction, past_direction):
	
	# idle
	if direction == Vector2.ZERO and past_direction.y != -1 :
		ap.play("idle")
	
	# idle up
	elif past_direction.y == -1 and direction.y == 0:
		ap.play("idle_up") 
	
	# up
	elif direction.y == -1:
		ap.play("up")
	
	# down
	elif direction.y == 1:
		ap.play("down")
	
	# run
	else:
		ap.play("run")
