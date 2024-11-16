extends Node2D
const spawnable_drop1 = preload("res://scenes/enemy/honey_drop.tscn")
const spawnable_drop2 = preload("res://scenes/enemy/ice_drop.tscn")


func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$ship_component.counter += randi() % 3
	$ship_component.speed += randi() % 250 
	$ship_component/wait_timer.wait_time = randi() % 1 + $ship_component.wait_time
