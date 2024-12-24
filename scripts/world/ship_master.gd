extends Node2D
const beast_ship = preload("res://scenes/enemy/mrbeast_ship.tscn")
const chandler_ship = preload("res://scenes/enemy/chandler_ship.tscn")
const raft_ship = preload("res://scenes/enemy/raft_enemy.tscn")
const pirate_ship = preload("res://scenes/enemy/pirate_ship.tscn")
const karl_ship = preload("res://scenes/enemy/karl_ship.tscn")
const orca =      preload("res://scenes/enemy/fish_spawner.tscn")
@export var timer_wait_time : float
@export var max_entities : int = 30
var entities_spawned : int
var score : int
var timer : Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.timer = Timer.new()
	self.timer.wait_time = timer_wait_time
	self.timer.one_shot = true
	self.add_child(timer)
	self.timer.timeout.connect(_on_delete_timer_timeout)
	spawn_new_enemy()
	


func _on_delete_timer_timeout() -> void:
	score = get_parent().score
	var a = timer_wait_time - (score / 30)
	if (a <= 1):
		a = 1
	self.timer.wait_time = a
	if entities_spawned >= max_entities:
		self.timer.start()
		return
	spawn_new_enemy()


# Handles spawning enemies
func spawn_new_enemy() -> void:
	# so we can have ramping difficulty, so its harder enemies the further u go
	
	var c = score / 5
	
	if score % 30 == 0 and score != 0:
		max_entities += 1
	if c > 6:
		c = 6
	if c <= 0:
		c = 1
	var a : int = randi() % c
	var b
	match a:
		0:
			b = chandler_ship.instantiate()
		1:
			b = beast_ship.instantiate()
		2:
			b = raft_ship.instantiate()
		3:
			b = pirate_ship.instantiate()
		4: 
			b = karl_ship.instantiate()
		5:
			b = orca.instantiate()
	b.set_global_scale(Vector2(2,2))
	self.add_child(b)
	self.timer.start()
	self.entities_spawned += 1
