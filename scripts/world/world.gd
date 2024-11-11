extends Node2D
var score : int = 0

func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	#print(score)
	pass


func get_player_position() -> Vector2:
	#print(get_node("player").global_position.x, ":", get_node("player").global_position.y)
	return get_node("player").global_position
