extends Node2D
const spawnable_drop = preload("res://scenes/enemy/classic_world/drops/dynamite_drop.tscn")


@onready var animated_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var ship_component  : Node2D           = get_node("ship_component")
@onready var wait_timer      : Timer            = get_node("ship_component/wait_timer")

var parent_score : int
func _ready() -> void:
	parent_score = get_parent().score
	animated_sprite.play("default")
	
	
	ship_component.counter += randi() % (2 + parent_score / 100)
	ship_component.speed += randi() % 30 
	wait_timer.wait_time = randi() % 3 + ship_component.wait_time
