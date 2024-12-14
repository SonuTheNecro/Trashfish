extends Node2D



func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func attacked():
	get_tree().change_scene_to_file("res://scenes/world/world.tscn")
	
