extends Node2D
@export var timer_length : float
@export var delete_timer_length : float
@export var particle_timer_length : float = 0.01
@export var fall_speed : int
@export var rotation_speed : float

var isActive : bool = true
var active_timer : Timer
var delete_timer: Timer
var particle_timer: Timer
var xDirection : float
var ship_component : Node2D

func _ready() -> void:
	
	ship_component = self.get_parent().get_parent().ship_component
	
	xDirection = cos(randi() % 4)
	active_timer = Timer.new()
	active_timer.wait_time = timer_length
	active_timer.one_shot = true
	self.add_child(active_timer)
	active_timer.timeout.connect(_on_active_timer_timeout)
	active_timer.start()
	
	delete_timer = Timer.new()
	delete_timer .wait_time = delete_timer_length
	delete_timer .one_shot = true
	self.add_child(delete_timer)
	delete_timer .timeout.connect(_on_delete_timer_timeout)
	active_timer.start()
	self.get_parent().global_position.y = get_parent().global_position.y + 50

	if particle_timer_length != 0.01:
		particle_timer = Timer.new()
		particle_timer.wait_time = particle_timer_length
		particle_timer.one_shot = true
		self.add_child(particle_timer)
		particle_timer.timeout.connect(_on_particle_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not isActive:
		return
	self.get_parent().global_position.x += xDirection *(fall_speed / 2) * delta * -1
	self.get_parent().global_position.y += fall_speed * delta
	self.get_parent().rotation_degrees += rotation_speed
	

# On timer timeout, call the parents Event
func _on_active_timer_timeout() -> void:
	# if we have a particle event, this will proc it.  The particle event will then call the delete_timer
	if particle_timer_length != 0.01:
		particle_timer.start()
		#get_parent().particle_event()
	else:
		delete_timer.start()
	isActive = false
	get_parent().timer_timeout_event()


func _on_particle_timer_timeout() -> void:
	delete_timer.start()
func _on_delete_timer_timeout() -> void:

	if get_parent().get_parent() == null:
		self.get_parent().queue_free()
	# Karl Jacobs Check
	if self.ship_component.id == 4:
		self.get_parent().get_parent().animated_sprite.play("default")
	
	ship_component.counter += -1
	ship_component.state = 0
	ship_component.hasWaited = false
	self.get_parent().queue_free()
