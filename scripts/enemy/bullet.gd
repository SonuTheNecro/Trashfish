extends Node2D
const speed : int = 200
var direction : Vector2
func _ready() -> void:
	self.set_rotation(get_parent().get_node("gun").get_rotation())
	self.global_position = get_parent().get_node("gun").get_global_position()
	get_parent().get_node("shoot_timer").start(10)
	direction = Vector2(cos(self.get_rotation()), sin(self.get_rotation())) * speed

func _process(delta : float) -> void:
	self.global_position +=  direction * delta
	if abs(global_position.x) > 3000 or abs(global_position.y) > 3000:
		self.queue_free()
		#print(previous_location, ":", get_parent().get_node("gun").global_position )
		self.queue_free()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_health(0)
