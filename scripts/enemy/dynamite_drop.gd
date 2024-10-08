extends Node2D


func timer_timeout_event():
	get_node("explosion_hitbox/CollisionShape2D").set_deferred("disabled", false)
	$AnimatedSprite2D.play("explosion")
	self.queue_free()
