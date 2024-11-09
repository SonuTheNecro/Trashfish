extends Node2D
const spawnable_drop1 = preload("res://scenes/enemy/dynamite_drop.tscn")
const spawnable_drop2 = preload("res://scenes/enemy/honey_drop.tscn")
const spawnable_drop3 = preload("res://scenes/enemy/ice_drop.tscn")
const spawnable_drop4 = preload("res://scenes/enemy/recycle_drop.tscn")
const spawnable_drop5 = preload("res://scenes/enemy/trash_drop.tscn")


func _ready() -> void:
	$AnimatedSprite2D.play("default")
	$ship_component.counter += randi() % 30 #30 Under 30 Congrats Karl!
	$ship_component.speed += randi() % 420
