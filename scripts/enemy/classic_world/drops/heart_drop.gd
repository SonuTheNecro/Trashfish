extends Node2D

func _ready() -> void:
	$drop_component.timer_length += randi() % 10
	$drop_component.fall_speed += randi() % 200

func timer_timeout_event():
	pass


# When the player attacks this object
func attacked():
	#     Ship       Ship master   world
	self.get_parent().get_parent().get_parent().score += 1
	self.get_parent().get_parent().get_parent().heal_player()
	$drop_component._on_delete_timer_timeout()
