extends Node2D
const spawnable_drop1 = preload("res://scenes/enemy/trash_drop.tscn")
const spawnable_drop2 = preload("res://scenes/enemy/recycle_drop.tscn")


func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$ship_component.counter += randi() % 3
	$ship_component.speed += randi() % 55
	
