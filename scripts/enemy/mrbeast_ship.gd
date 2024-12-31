extends Node2D
const spawnable_drop = preload("res://scenes/enemy/dynamite_drop.tscn")


var animated_sprite : AnimatedSprite2D
var ship_component  : Node2D
var wait_timer      : Timer

var parent_score : int
func _ready() -> void:
	animated_sprite = get_node("AnimatedSprite2D")
	ship_component  = get_node("ship_component")
	wait_timer      = get_node("ship_component/wait_timer")
	parent_score = get_parent().score
	animated_sprite.play("default")
	
	
	ship_component.counter += randi() % (2 + parent_score / 100)
	ship_component.speed += randi() % 30 
	wait_timer.wait_time = randi() % 3 + ship_component.wait_time
