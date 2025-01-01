extends Control
var go_to_level : int = 1

func _ready():
	$VBoxContainer/start_button.grab_focus()
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/world/world.tscn")
	
func _on_controls_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/controls.tscn")

func _on_quit_button_pressed():
	get_tree().quit()


func _on_h_scroll_bar_value_changed(value: int) -> void:
	go_to_level = value
