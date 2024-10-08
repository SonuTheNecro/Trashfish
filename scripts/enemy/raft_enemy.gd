extends Node2D
@onready var raft = $raft
@onready var gun = $gun
@onready var shoot_timer = $shoot_timer
const play_slot_scene = preload("res://scenes/enemy/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	raft.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#if shoot_timer.wait_time > 0.01:
	gun.set_gun_rotation()

# After timer ends, have the gun fire a bullet towards the player and restart the timer
func _on_shoot_timer_timeout() -> void:
	$gun.play("fire")
	var bullet = play_slot_scene.instantiate()
	get_parent().add_child(bullet)
