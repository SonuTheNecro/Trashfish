extends CollisionPolygon2D
var polygon_2D = Polygon2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(polygon_2D)
	polygon_2D.set_polygon(polygon)
	polygon_2D.set_color(Color(0,1,1,0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
