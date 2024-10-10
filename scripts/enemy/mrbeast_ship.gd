extends Node2D
const spawnable_drop = preload("res://scenes/enemy/dynamite_drop.tscn")


func _ready() -> void:
	$AnimatedSprite2D.play("idle")
