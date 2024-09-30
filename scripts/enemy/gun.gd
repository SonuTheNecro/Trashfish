extends AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_gun_rotation():
	print(get_angle_to_player())
	self.set_rotation_degrees(get_angle_to_player())


# Gets the angle to the player from the gun
func get_angle_to_player() -> int:
	return int(self.get_angle_to(get_parent().get_parent().get_player_position())  * (180 / PI))
