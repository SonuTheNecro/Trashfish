extends Node2D
const spawnable_drop1 = preload("res://scenes/enemy/trash_drop.tscn")
const spawnable_drop2 = preload("res://scenes/enemy/recycle_drop.tscn")
#const spawnable_drop2 = preload("res://scenes/enemy/heart_drop.tscn")
var animated_sprite : AnimatedSprite2D
var ship_component  : Node2D
var wait_timer      : Timer
var parent_score : int
func _ready() -> void:
	animated_sprite = get_node("AnimatedSprite2D")
	ship_component  = get_node("ship_component")
	wait_timer      = get_node("ship_component/wait_timer")
	parent_score = get_parent().score
	# as the game goes on, the chandler ship will drop less and less point trash, this is counteracted since there will be more of them
	match parent_score / 20:
		0:
			ship_component.counter += randi() % 6
		1:
			ship_component.counter += randi() % 5
		2:
			ship_component.counter += randi() % 4
		3:
			ship_component.counter += randi() % 3
		_: 
			ship_component.counter += randi() % 2
	
	animated_sprite.play("default")
	ship_component.speed += randi() % 55
	wait_timer.wait_time = randi() % 2 + ship_component.wait_time
