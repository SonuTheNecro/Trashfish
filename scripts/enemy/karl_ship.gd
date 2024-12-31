extends Node2D
const spawnable_drop1 = preload("res://scenes/enemy/dynamite_drop.tscn")
const spawnable_drop2 = preload("res://scenes/enemy/honey_drop.tscn")
const spawnable_drop3 = preload("res://scenes/enemy/ice_drop.tscn")
const spawnable_drop4 = preload("res://scenes/enemy/recycle_drop.tscn")
const spawnable_drop5 = preload("res://scenes/enemy/trash_drop.tscn")
const spawnable_drop6 = preload("res://scenes/enemy/heart_drop.tscn")

var animated_sprite : AnimatedSprite2D
var ship_component  : Node2D
var wait_timer      : Timer
func _ready() -> void:
	
	animated_sprite = get_node("AnimatedSprite2D")
	ship_component  = get_node("ship_component")
	wait_timer      = get_node("ship_component/wait_timer")
	animated_sprite.play("default")
	ship_component.counter += randi() % 5 #30 Under 30 Congrats Karl!... About that 30, NAHHHHHHH TO MUCH RNG
	ship_component.speed += randi() % 750
	wait_timer .wait_time = randi() % 1 + ship_component.wait_time
