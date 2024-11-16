extends Node2D

func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	$drop_component.timer_length += randi() % 12
	$drop_component.fall_speed += randi() % 230

func timer_timeout_event():
	self.rotation_degrees = 0
	get_node("explosion_hitbox/CollisionShape2D").set_deferred("disabled", false)
	$AnimatedSprite2D.play("explosion")


func _on_explosion_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_debuff("honey")

# When the player attacks this object
func attacked():
	self.get_parent().get_parent().get_parent().score += 1
	$drop_component.delete_timer.start()
	$drop_component.isActive = false
	$StaticBody2D.set_deferred("disable_mode",true)
	$StaticBody2D/CollisionShape2D.set_deferred("disabled",true)
	self.timer_timeout_event()
	
