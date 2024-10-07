extends Node2D
@export var counter : int = 3
@export var speed : int = 200
@export var id : int
var isMoving : bool = true
var isBusy : bool = false
var nextX : float
var direction : bool = false

const play_slot_scene = preload("res://scenes/enemy/trash_1")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.global_position.x = 0 
	self.global_position.y = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# IF we aren't moving and we aren't dropping items, then we should find a new spot to go
	if not isMoving and not isBusy:
		nextX = randi() % 1100
		isMoving = true
		direction = true if global_position.x - nextX >= 0 else false # Go Left if we are to the right, otherwise go right
		return
	# We have a spot to go to but we aren't there yet
	if isMoving and not isBusy:
		self.global_position.x += int(direction) * speed * delta
		if self.global_position.x == int(nextX):
			isBusy = true
		return
	# We have arrived at our spot but we haven't dropped an item yet
	if isMoving and isBusy:
		var trash = play_slot_scene.instantiate()
		trash.add_child(trash)
		isMoving = false
		return
	if not isMoving and isBusy:
		pass
	
	
	
		
