extends Node2D
var score : int = 0
var high_score : int = 0
var config : ConfigFile
func _ready() -> void:
	config = ConfigFile.new()
	
	var error = config.load("user://savedata.cfg")
	if error != OK:
		print("error")
		high_score = 0
	else:
		high_score = config.get_value("player", "classic_high_score", 0)
	
func _process(_delta: float) -> void:
	if $player.isDead:
		return
	if score > high_score:
		high_score = score
		config.set_value("player", "classic_high_score", high_score)
		config.save("user://savedata.cfg")
	
	$Panel/score.text = "Score: %d" % score
	$Panel/high_score.text = "High Score: %d" % high_score
	$Panel/health.text = "X %d" % $player.get_health()
	


func get_player_position() -> Vector2:
	#print(get_node("player").global_position.x, ":", get_node("player").global_position.y)
	return get_node("player").global_position

# Final hud update when dead
func update_hud_when_dead():
	$Panel/score.text = "Score: %d" % score
	$Panel/health.text = "X %d" % $player.get_health()
	config.set_value("player", "classic_high_score", high_score)
	config.save("user://savedata.cfg")
	
