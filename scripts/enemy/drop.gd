extends Node2D
@export var timer_length : int
@export var fall_speed : int
@export var rotation_speed : float
var isActive : bool = true
var active_timer : Timer
var delete_timer: Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	active_timer = Timer.new()
	active_timer.wait_time = timer_length
	active_timer.one_shot = true
	self.add_child(active_timer)
	active_timer.timeout.connect(_on_active_timer_timeout)
	active_timer.start()
	
	delete_timer = Timer.new()
	delete_timer .wait_time = 3
	delete_timer .one_shot = true
	self.add_child(delete_timer)
	delete_timer .timeout.connect(_on_delete_timer_timeout)
	active_timer.start()
	self.get_parent().global_position.y = get_parent().global_position.y + 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not isActive:
		return
	self.get_parent().global_position.y += fall_speed * delta
	self.get_parent().rotation_degrees += rotation_speed
	

# On timer timeout, call the parents Event
func _on_active_timer_timeout() -> void:
	delete_timer.start()
	isActive = false
	self.get_parent().rotation_degrees = 0
	get_parent().timer_timeout_event()

func _on_delete_timer_timeout() -> void:
	#self.get_node("active_timer").queue_free()
	#self.get_node("delete_timer").queue_free()
	self.get_parent().get_parent().get_node("ship_component").counter += -1
	self.get_parent().get_parent().get_node("ship_component").isBusy = false
	self.get_parent().get_parent().get_node("ship_component").isMoving = false
	self.get_parent().queue_free()
