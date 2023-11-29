extends CharacterBody2D

signal item_droped(item: Area2D)
var speed:int = 80
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var player_alive = true
var attack_in_progress = false


@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

@export var inventory: Inventory
var current_inventory: Array
var past_direction: Vector2 = Vector2.ZERO
var can_collect: bool = true
var on_door: bool = false
var on_serpent: bool = false
var first_interaction: bool = true
var snake_position : Vector2 = Vector2(120,23) 

func _ready():
	inventory.droped.connect(drop_item)

func _process(_delta):
	enemy_attack()
	attack()
	if global.health <= 0:
		player_alive = false
		global.health = 0
		print("game over")
		get_tree().change_scene_to_file("res://Levels/base.tscn")
		global.health = 10000
		global.current_scene = "base"
		#game over
		
	
	dialogue()
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction.normalized() * speed
	# flipping the character
	if direction.x != 0:
		sprite.flip_h = (direction.x >= -1 and direction.x < 0)
	move_and_slide()
	
	
	if past_direction != direction:
		update_animations(direction)
	past_direction = direction
	mouse_rotation(ap.current_animation)


func update_animations(direction: Vector2) -> void:
	
	# idle
	if direction == Vector2.ZERO:
		if past_direction.y == -1:
			if attack_in_progress == false:
				ap.play("idle_up")
		else:
			if attack_in_progress == false:
				ap.play("idle")
	
	elif direction.y == -1:
			ap.play("up")
	
	elif direction.y == 1:
			ap.play("down")
	
	else:
		ap.play("run")

func mouse_rotation(current_animation: String) -> void:
	
	var mouse_position = get_local_mouse_position().normalized()
	
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
	if area.has_method("collect") and can_collect:
		if area not in current_inventory:
			current_inventory.append(area.duplicate())
			area.collect(inventory)
	
func print_inventory():
	for i in current_inventory:
		print(i)
	print()

func drop_item(item: InventoryItem):
	var pos
	can_collect = false
	$CollectTimer.start()
	for i in range(current_inventory.size()):
		# si encuentra el objeto dentro del inventario
		if current_inventory[i].itemRes == item:
			item_droped.emit(current_inventory[i])
			pos = i
	current_inventory.erase(current_inventory[pos])
	
func dialogue():
		
	if on_door and first_interaction == false and Input.is_action_pressed("accept"):
		DialogueManager.show_dialogue_balloon(load("res://Dialogues/main.dialogue"),"discussion")
		get_tree().change_scene_to_file("res://Room/Initialize.tscn")
		global.current_scene = "initialize"
		global.finish_changedscenes()
		
	elif Input.is_action_pressed("accept") and (on_door or on_serpent) :
		if $"../Snake".position != snake_position:
			$"../Snake".position =  snake_position
			$"../Snake02".position = snake_position
		ap.play("idle")
		first_interaction = false
		DialogueManager.show_dialogue_balloon(load("res://Dialogues/main.dialogue"),"start")	



func _on_collect_timer_timeout() -> void:
	can_collect = true

#switch to active event in samurai_(enemy)
func player() -> void:
	pass
	
func _on_hitbox_area_body_entered(body) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = true


func _on_hitbox_area_body_exited(body) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = false

func enemy_attack() -> void:
	if enemy_inattack_range and enemy_attack_cooldown == true:
		global.health -= global.damage
		enemy_attack_cooldown = false
		$attackCooldown.start()
		print("alice health", global.health)

func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true

func attack() -> void:
	var direction:Vector2 = get_local_mouse_position().normalized()
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_in_progress = true
		if direction.y < -0.5:
			ap.play("attackUp")
			$dealAttackDamage.start()
		elif direction.y > 0.5:
			ap.play("attackDown")
			$dealAttackDamage.start()
	
		elif direction.x < 0:
			$sword.flip_h = true
			ap.play("attackSide")
			$dealAttackDamage.start()
			
		elif direction.x > 0:
			$sword.flip_h = false
			ap.play("attackSide")
			$dealAttackDamage.start()

func _on_deal_attack_damage_timeout() -> void:
	$dealAttackDamage.stop()
	global.player_current_attack = false
	attack_in_progress = false

func _on_area_2d_body_entered(body):
	if body.has_method("openDoor"):
		on_door = true
		print("ondoor")
		
	elif body.has_method("onSerpent"):
		on_serpent = true
		print("onSerpent")
		
func _on_area_2d_body_exited(body):
	if body.has_method("openDoor"):
		on_door = false
		print("exiteDoor")
		
	elif body.has_method("onSerpent"):
		on_serpent = false
		print("exitSerpent")
