extends Node2D

@export var speed : int = 150
var endPos : Vector2
var angle : float
var direction : Vector2
func _ready():
	endPos.y =  randi() % 700 + 100
	endPos.x = 2000

	global_position.y =  randi() % 700 + 100
	global_position.x = -100
	
	angle = global_position.angle_to_point(endPos)
	direction = Vector2(cos(angle), sin(angle)) 
	speed += randi() % 50
	$AnimatedSprite2D.play("default")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.global_position += direction * speed * delta
	
	if global_position.x > 2000:
		self.get_parent().fish_returned += 1
		self.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.minus_health(5)
