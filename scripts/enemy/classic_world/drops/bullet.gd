extends Node2D
var speed : int = 200
var direction : Vector2
func _ready() -> void:
	self.speed += randi() % 55
	self.set_rotation(get_parent().gun.get_rotation())
	self.global_position = get_parent().gun.get_global_position()
	get_parent().get_node("shoot_timer").start(10)
	direction = Vector2(cos(self.get_rotation()), sin(self.get_rotation())) * speed

func _process(delta : float) -> void:
	self.global_position +=  direction * delta
	if abs(global_position.x) > 3000 or abs(global_position.y) > 3000:
		self.queue_free()
		self.queue_free()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.decrease_health()
