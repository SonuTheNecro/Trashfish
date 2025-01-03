extends Node2D

var animated_sprite : AnimatedSprite2D
var drop_component : Node2D
func _ready() -> void:
	animated_sprite = get_node("AnimatedSprite2D")
	drop_component = get_node("drop_component")
	animated_sprite.play("idle")
	drop_component.timer_length += randi() % 20
	drop_component.fall_speed += randi() % 150

func timer_timeout_event():
	self.rotation_degrees = 0
	get_node("explosion_hitbox/CollisionPolygon2D").set_deferred("disabled", false)
	animated_sprite.play("explosion")
	get_node("StaticBody2D/CollisionPolygon2D").set_deferred("disabled", true)
	$CPUParticles2D.emitting = true

func _on_explosion_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_debuff("ice")

# When the player attacks this object
func attacked():
	self.get_parent().get_parent().get_parent().score += 1
	drop_component.delete_timer.start()
	drop_component.isActive = false #freezes the object
	$StaticBody2D.set_deferred("disable_mode",true) # disables the eating hitboxes
	$StaticBody2D/CollisionPolygon2D.set_deferred("disabled",true)
	drop_component.active_timer.stop()
	drop_component.active_timer.emit_signal("timeout")
