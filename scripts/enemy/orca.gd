extends Node2D

@export var speed : int = 150
var endPos : Vector2
var angle : float
var direction : Vector2
var parentX : int
func _ready():
	
	parentX = get_parent().global_position.x
	speed += randi() % 50
	if parentX == 50:
		endPos.x = 2000
		endPos.y =  randi() % 700 + 100
		global_position.x = -100
		global_position.y =  randi() % 800 + 300
	else:
		endPos.x = -100
		endPos.y =  randi() % 700 + 100
		global_position.x = 2000
		global_position.y =  randi() % 800 + 300
		$AnimatedSprite2D.flip_h = true
	
	angle = global_position.angle_to_point(endPos)
	direction = Vector2(cos(angle), sin(angle)) 
	
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
