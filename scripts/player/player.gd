extends CharacterBody2D
var speed : int = 200
const acceleration : int = 20
@export var health : int = 6

const trash_can = preload("res://scenes/player/trash_can.tscn")
var isAttacking : bool = false
var isDead : bool = false
var isHoneyd : bool = false
var isIced : bool = false
var drop

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$debuff_master/honey.play("default")
	$debuff_master/ice.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (Input.is_action_just_pressed("restart")):
		get_tree().change_scene_to_file("res://scenes/world/world.tscn")
	if (Input.is_action_just_pressed("revive")):
		self.set_health(10)
	if isDead:
		return
	if Input.is_action_just_pressed("attack") and not isAttacking:
		self.attack()
	
	if self.health == 0:
		player_death()
		return
	handle_player_input(delta)
	handle_player_animation()
	move_and_slide()
# Handles basic player movement
func handle_player_input(delta):
	var direction : Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	self.velocity.x = lerp(velocity.x, speed * direction.x, acceleration * delta)
	self.velocity.y = lerp(velocity.y, speed * direction.y, acceleration * delta)
# Handles basic player animations using bools/state machine
func handle_player_animation():
	if abs(velocity.x) > 0.001:
		flip(velocity.x < 0)
	if isDead:
		$body.play("death")
		return
	$debuff_master/honey.visible = isHoneyd
	$debuff_master/ice.visible = isIced
	match isAttacking:
		true:
			$head.play("attack")
		false:
			$head.play("idle")
	$body.play("idle")
	
# Flip the animations and hitboxes
func flip(value: bool):
	if value != $body.flip_h:
		$body.flip_h = value
		$head.flip_h = value
		$attack_hitbox/CollisionShape2D.position.x *= -1
		$debuff_master/honey.flip_h = value
		$debuff_master/ice.flip_h = value
# Variables to mess with player health
func set_health(change : int):
	self.health = change

func decrease_health() :
	print(health)
	self.health -= 1;
	self.flash_body();

func increase_health():
	self.health += 1;
	if health > 10:
		health = health
func player_death():
	self.isDead = true
	$body.play("death")
	$head.visible = false
	drop = trash_can.instantiate()
	self.add_child(drop)
	
# If we attack, then we should turn on attack hitboxes
func attack():
	#print("just_attacked!")
	get_node("attack_hitbox/CollisionShape2D").set_deferred("disabled", false)
	isAttacking = true
	#$AnimatedSprite2D.play("attack")
	$attack_hitbox/attack_timer.start()
	
# Sets the player's debuff 
func set_debuff(debuff : String) -> void:
	match debuff:
		"honey":
			if isHoneyd:
				$debuff_master/honey_timer.start()
				return
			isHoneyd = true
			self.speed /= 2
			$debuff_master/honey_timer.start()
		"ice":
			if isIced:
				$debuff_master/ice_timer.start()
				return
			isIced = true
			self.speed /= 4
			$debuff_master/ice_timer.start()

# Flashes the player body when damaged
func flash_body():
	$body.material.set_shader_parameter("flash_modifer", 0.7)
	$head.material.set_shader_parameter("flash_modifer", 0.7)
	$body/flash_timer.start()


# When the attack timer resets (CD), we should turn off hitboxes
func _on_attack_timer_timeout() -> void:
	get_node("attack_hitbox/CollisionShape2D").set_deferred("disabled", true)
	isAttacking = false


func _on_attack_hitbox_body_entered(body: Node2D) -> void:
	#print(body)
	if body.is_in_group("player"):
		return
	if body.is_in_group("drop"):
		self.increase_health()
		body.get_parent().attacked()
		


func _on_honey_timer_timeout() -> void:
	self.speed = speed * 2
	isHoneyd = false


func _on_ice_timer_timeout() -> void:
	self.speed = speed * 4
	isIced = false


func _on_flash_timer_timeout() -> void:
	$body.material.set_shader_parameter("flash_modifer", 0)
	$head.material.set_shader_parameter("flash_modifer", 0)
