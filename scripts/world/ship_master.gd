extends Node2D
const beast_ship = preload("res://scenes/enemy/mrbeast_ship.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var a = beast_ship.instantiate()
	a.set_global_scale(Vector2(4,4))
	self.add_child(a)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
