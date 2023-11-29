extends CharacterBody2D

#Stats of element and variable
var speed = 40
var player_chase = false
var player = null
var health = 40
var damage = 20
var player_inattack_zone = false
var take_damage = true

func _ready():
	$AnimatedSprite2D.play("stay")
	
func _physics_process(delta):
	deal_with_damage()
	if player_chase:
		position += (player.position - position) / speed
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("stay")
#code of detection area
func _on_dectetion_area_body_entered(body):
		player = body
		player_chase = true

func _on_dectetion_area_body_exited(body):
	player = null
	player_chase = false
#switch to active event in player (alice)
func enemy():
	pass


func _on_hitbox_area_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_hitbox_area_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if take_damage == true:
			health -= damage
			$takeDamageCooldown.start()
			take_damage = false
			print("samurai health =", health)
			if health <= 0:
				global.death_count += 1
				self.queue_free()
		
func _on_take_damage_cooldown_timeout():
	take_damage = true
