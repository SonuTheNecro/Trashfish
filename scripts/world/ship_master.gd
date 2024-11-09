extends Node2D
const beast_ship = preload("res://scenes/enemy/mrbeast_ship.tscn")
const chandler_ship = preload("res://scenes/enemy/chandler_ship.tscn")
const raft_ship = preload("res://scenes/enemy/raft_enemy.tscn")
const kris_ship = preload("res://scenes/enemy/kris_ship.tscn")
const karl_ship = preload("res://scenes/enemy/karl_ship.tscn")
@export var timer_wait_time : float
@export var max_entities : int = 30
var entities_spawned : int

var timer : Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.timer = Timer.new()
	self.timer.wait_time = timer_wait_time
	self.timer.one_shot = true
	self.add_child(timer)
	self.timer.timeout.connect(_on_delete_timer_timeout)
	#var a = chandler_ship.instantiate()
	#a.set_global_scale(Vector2(4,4))
	#self.add_child(a)
	spawn_new_enemy()
	


func _on_delete_timer_timeout() -> void:
	if entities_spawned >= max_entities:
		self.timer.start()
		return
	spawn_new_enemy()

	
func spawn_new_enemy() -> void:
	var a : int = randi() % 5
	var b
	match a:
		0:
			b = beast_ship.instantiate()
		1:
			b = chandler_ship.instantiate()
		2:
			b = raft_ship.instantiate()
		3:
			b = kris_ship.instantiate()
		4: 
			b = karl_ship.instantiate()
	#b = kris_ship.instantiate()
	b.set_global_scale(Vector2(2,2))
	self.add_child(b)
	self.timer.start()
	self.entities_spawned += 1
