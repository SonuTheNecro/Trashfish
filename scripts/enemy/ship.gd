extends Node2D
@export var counter : int = 3
@export var speed : int = 200
@export var id : int
var isMoving : bool = false
var isBusy : bool = false
var nextX : float
var direction : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.get_parent().global_position.x = 0
	self.get_parent().global_position.y = 255


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(get_parent().global_position.x, ":",get_parent().global_position.y)
	# IF we aren't moving and we aren't dropping items, then we should find a new spot to go
	if not isMoving and not isBusy:
		#nextX = randi() % 1100
		nextX = 550
		isMoving = true
		direction = 1 if get_parent().global_position.x - nextX  <= 0 else -1 # Go Left if we are to the right, otherwise go right
		return
	# We have a spot to go to but we aren't there yet
	if isMoving and not isBusy:
		self.get_parent().global_position.x += direction * speed * delta
		if int(self.get_parent().global_position.x) == nextX:
			isBusy = true
		return
	# We have arrived at our spot but we haven't dropped an item yet
	if isMoving and isBusy:
		var drop = get_spawnable_drop()
		self.add_child(drop)
		isMoving = false
		return
	if not isMoving and isBusy:
		pass
	
# Gets what type of drop we need to drop from the parent then we can pass it to this component
func get_spawnable_drop():
	get_parent().spawnable_drop.instantiate()
	
		
