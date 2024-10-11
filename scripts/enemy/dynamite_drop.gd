extends Node2D

func _ready() -> void:
	$AnimatedSprite2D.play("idle")

func timer_timeout_event():
	get_node("explosion_hitbox/CollisionShape2D").set_deferred("disabled", false)
	$AnimatedSprite2D.play("explosion")
	self.get_parent().rotation_degrees = 0
	
	#self.queue_free()


func _on_explosion_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_health(0)
