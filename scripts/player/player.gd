extends CharacterBody2D
const speed : int = 200
const acceleration : int = 20
@export var health : int = 6


var isAttacking : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("attack") and not isAttacking:
		self.attack()
	
	if self.health == 0:
		player_death()
		return
	handle_player_input(delta)
	handle_player_animation()
	move_and_slide()
func handle_player_input(delta):
	var direction : Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	self.velocity.x = lerp(velocity.x, speed * direction.x, acceleration * delta)
	self.velocity.y = lerp(velocity.y, speed * direction.y, acceleration * delta)

func handle_player_animation():
	if abs(velocity.x) > 0.001:
		flip(velocity.x < 0)
# Flip the animations and hitboxes
func flip(value: bool):
	if value != $AnimatedSprite2D.flip_h:
		$AnimatedSprite2D.flip_h = value
		$attack_hitbox/CollisionShape2D.global_position.x *= -1

func set_health(change : int):
	self.health = change

func decrease_health() :
	self.health -= 1;

func increase_health():
	self.health += 1;
	if health > 10:
		health = health
func player_death():
	print("ded")
	
func attack():
	#print("just_attacked!")
	get_node("attack_hitbox/CollisionShape2D").set_deferred("disabled", false)
	isAttacking = true
	#$AnimatedSprite2D.play("attack")
	$attack_hitbox/attack_timer.start()
	



func _on_attack_timer_timeout() -> void:
	get_node("attack_hitbox/CollisionShape2D").set_deferred("disabled", true)
	isAttacking = false
