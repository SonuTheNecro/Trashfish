extends Node2D
#const spawnable_drop = preload("res://scenes/enemy/trash_drop.tscn")
const spawnable_drop = preload("res://scenes/enemy/recycle_drop.tscn")


func _ready() -> void:
	$AnimatedSprite2D.play("default")
