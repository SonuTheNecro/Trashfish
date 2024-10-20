extends Node2D
@onready var raft = $raft
@onready var gun = $gun
@onready var shoot_timer = $shoot_timer
@onready var state = 0
var nextX : float
var direction : int
var bullets_left : int = 5
@export var speed : int = 100
const play_slot_scene = preload("res://scenes/enemy/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$raft.play("idle")
	var spot_on_screen_to_spawn_at : int = randi() % 2
	match spot_on_screen_to_spawn_at:
		0:
			self.global_position.x = 0
		1:
			self.global_position.x = 1900


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if shoot_timer.wait_time > 0.01:
	gun.set_gun_rotation()
	match state:
		0:
			nextX = randi() % 800 + 200
			state = 1
			direction = 1 if self.global_position.x - nextX  <= 0 else -1 # Go Left if we are to the right, otherwise go right
			self.flip()
			return
		# We have a spot to go to but we aren't there yet
		1:
			self.global_position.x += direction * speed * delta
			#print(int(self.get_parent().global_position.x),":",nextX)
			if check_in_range(self.global_position.x,nextX, speed * delta):
				state = 2
			return
		# We have arrived at our spot fire!
		2:
			if bullets_left <= 0:
				state = 3
			if shoot_timer.time_left >= 0.01:
				return
			$shoot_timer.start()
			return
		3:
			self.state = 4
			nextX = randi() % 2
			nextX = 0 if nextX == 0 else 1900
			direction = 1 if self.global_position.x - nextX  <= 0 else -1 # Go Left if we are to the right, otherwise go right
		4:
			self.global_position.x += direction * speed * delta
			#print(int(self.get_parent().global_position.x),":",nextX)
			if check_in_range(self.global_position.x,nextX, speed * delta):
				state = 5
			self.flip()
			return
		# We are at our despawn position, so despawn
		5:
			self.get_parent().entities_spawned -= 1
			self.queue_free()

# After timer ends, have the gun fire a bullet towards the player and restart the timer
func _on_shoot_timer_timeout() -> void:
	$gun.play("fire")
	bullets_left -= 1
	var bullet = play_slot_scene.instantiate()
	get_parent().add_child(bullet)
	
# Checks if value a/b are in range of each other
func check_in_range(a : float, b : float , range : int ) -> bool:
	if a > b:
		if a - b < range:
			return true
	if a < b:
		if b - a < range:
			return true
	return false

# Flips the ship and gun around
func flip():
	var old_direction = get_node("raft").flip_h
	get_node("raft").flip_h = true if direction == 1 else false
	if old_direction != get_node("raft").flip_h:
		$gun.position.x *= -1
