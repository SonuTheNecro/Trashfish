extends Node2D
const spawnable_drop = preload("res://scenes/enemy/dynamite_drop.tscn")

var parent_score : int
func _ready() -> void:
	parent_score = get_parent().score
	$AnimatedSprite2D.play("default")
	$ship_component.counter += randi() % (2 + parent_score / 100)
	$ship_component.speed += randi() % 30 
	$ship_component/wait_timer.wait_time = randi() % 3 + $ship_component.wait_time
