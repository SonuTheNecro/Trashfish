extends Node2D
const spawnable_drop = preload("res://scenes/enemy/dynamite_drop.tscn")


func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$ship_component.counter += randi() % 2 
	$ship_component.speed += randi() % 30 
	$ship_component/wait_timer.wait_time = randi() % 3 + $ship_component.wait_time
