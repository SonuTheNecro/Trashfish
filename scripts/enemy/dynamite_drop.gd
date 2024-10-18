extends Node2D

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	$drop_component.timer_length = randi() % 5 + 8
	$drop_component.fall_speed = randi() % 50 + 70

func timer_timeout_event():
	self.rotation_degrees = 0
	get_node("explosion_hitbox/CollisionShape2D").set_deferred("disabled", false)
	$AnimatedSprite2D.play("explosion")
	
	
	#self.queue_free()


func _on_explosion_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_health(0)

# When the player attacks this object
func attacked():
	$drop_component.delete_timer.start()
	$drop_component.isActive = false
	self.timer_timeout_event()
	
