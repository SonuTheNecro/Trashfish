extends Node2D
var score : int = 0
var high_score : int = 0
var config : ConfigFile
func _ready() -> void:
	config = ConfigFile.new()
	$starve_bar.max_value = get_node("player").max_starve
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
	$starve_bar.value = get_player_starvation()
	$Panel/score.text = "Score: %d" % score
	$Panel/high_score.text = "High Score: %d" % high_score
	$Panel/health.text = "X %d" % $player.get_health()
	
# heals player from world node to save some brain power
func heal_player():
	get_node("player").increase_health()

# world has access to player pos so comps can access whenever
func get_player_position() -> Vector2:
	return get_node("player").global_position
# world has access to player starvation
func get_player_starvation() -> int:
	return get_node("player").starve

# Final hud update when dead
func update_hud_when_dead():
	$Panel/score.text = "Score: %d" % score
	$Panel/health.text = "X %d" % $player.get_health()
	config.set_value("player", "classic_high_score", high_score)
	config.save("user://savedata.cfg")
	
	
