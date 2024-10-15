extends Node2D
const beast_ship = preload("res://scenes/enemy/mrbeast_ship.tscn")
const chandler_ship = preload("res://scenes/enemy/chandler_ship.tscn")
@export var timer_wait_time : float
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
	self.timer.start()
	


func _on_delete_timer_timeout() -> void:
	var a : int = randi() % 2
	var b
	match a:
		0:
			b = beast_ship.instantiate()
		1:
			b = chandler_ship.instantiate()
	b.set_global_scale(Vector2(2,2))
	self.add_child(b)
	self.timer.start()
