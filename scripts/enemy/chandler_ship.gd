extends Node2D
const spawnable_drop1 = preload("res://scenes/enemy/trash_drop.tscn")
const spawnable_drop2 = preload("res://scenes/enemy/recycle_drop.tscn")
#const spawnable_drop2 = preload("res://scenes/enemy/heart_drop.tscn")

var parent_score : int
func _ready() -> void:
	
	parent_score = get_parent().score
	# as the game goes on, the chandler ship will drop less and less point trash, this is counteracted since there will be more of them
	match parent_score / 20:
		0:
			$ship_component.counter += randi() % 6
		1:
			$ship_component.counter += randi() % 5
		2:
			$ship_component.counter += randi() % 4
		3:
			$ship_component.counter += randi() % 3
		_: 
			$ship_component.counter += randi() % 2
	
	$AnimatedSprite2D.play("default")
	$ship_component.speed += randi() % 55
	$ship_component/wait_timer.wait_time = randi() % 2 + $ship_component.wait_time
