extends CharacterBody2D

var speed:int = 80

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

func _process(_delta):
	
	# input
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	
	# flipping the character
	if direction.x != 0:
		sprite.flip_h = (direction.x == -1)
	
	move_and_slide()
	
	update_animations(direction)
	
	# rotate
	# look_at(get_global_mouse_position())

func update_animations(direction):
	if direction.x == 0:
		ap.play("idle")
	else:
		ap.play("run")
	
