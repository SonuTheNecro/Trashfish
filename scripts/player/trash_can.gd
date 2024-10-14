extends Node2D
@export var rotation_speed : int = 0
@export var timer_start : float = 0
@export var fall_speed : int = 0
var timer : Timer
var delete_timer : Timer
func _ready() -> void:
	# Creating this as a child to the player node
	self.global_position.x = -1000
	timer = Timer.new()
	timer.wait_time = timer_start
	timer.one_shot = true
	self.add_child(timer)
	timer.timeout.connect(_on_active_timer_timeout)
	timer.start()


func _process(delta: float) -> void:
	self.rotation_degrees += rotation_speed
	self.global_position.y += fall_speed * delta

func _on_active_timer_timeout() -> void:
	self.global_position = get_parent().global_position
	
