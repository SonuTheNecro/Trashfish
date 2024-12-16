extends Node2D
@export var enemies_left : int = 1
var state : int = 0
var fish
func _ready():
	# change these values later
	self.global_position.x = 50
	self.global_position.y = randi() % 600 + 400
	$start_timer.start(5)
	$flash_timer.start()


func _process(delta):
	match state:
		# We are still starting here
		0:
			return
		# Spawn the fish we need to
		1:
			pass


# Handles the flashing effect of the spawner
func _on_flash_timer_timeout():
	$Sprite2D.visible = !$Sprite2D.visible
	# Handles cases for if this timer goes after we swap states
	if state == 0:
		$flash_timer.start()
	else:
		$Sprite2D.visible = false

# Handles swapping to State 1
func _on_start_timer_timeout():
	self.state = 1
	$Sprite2D.visible = false
