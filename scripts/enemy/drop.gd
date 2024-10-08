extends Node2D
@export var timer_length : int
@export var fall_speed : int
@export var rotation_speed : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$timer.start(timer_length)
	self.global_position = get_parent().global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position.y += fall_speed * delta
	self.rotation_degrees += rotation_speed
	

# On timer timeout, call the parents Event
func _on_timer_timeout() -> void:
	get_parent().timer_timeout_event()
