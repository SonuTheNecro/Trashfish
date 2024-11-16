extends Node2D
var score : int = 0

func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	if $player.isDead:
		return
	$Panel/score.text = "Score: %d" % score
	$Panel/health.text = "Health: %d" % $player.get_health()


func get_player_position() -> Vector2:
	#print(get_node("player").global_position.x, ":", get_node("player").global_position.y)
	return get_node("player").global_position

# Final hud update when dead
func update_hud_when_dead():
	$Panel/score.text = "Score: %d" % score
	$Panel/health.text = "Health: %d" % $player.get_health()
