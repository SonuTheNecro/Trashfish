extends Node2D

# Preload drop scenes as uppercase constants for clarity
const SPAWNABLE_DROP_1 = preload("res://scenes/enemy/classic_world/drops/honey_drop.tscn")
const SPAWNABLE_DROP_2 = preload("res://scenes/enemy/classic_world/drops/ice_drop.tscn")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ship_component: Node2D           = $ship_component
@onready var wait_timer: Timer                = $ship_component/wait_timer

func _ready() -> void:
    # Randomize the global seed so each session has unique random numbers
    randomize()

    # Start the default animation
    animated_sprite.play("default")

    # Adjust the ship component's counter by up to 2
    # ( i.e., "randi() % 3" yields a random integer from 0..2)
    ship_component.counter += randi() % 3

    # Increase the ship speed by up to 249
    ship_component.speed += randi() % 250

    # Adjust wait_time by 0 or 1 plus the base wait_time from the ship
    wait_timer.wait_time = float(randi() % 2) + ship_component.wait_time

    # Example: Optionally spawn a random drop right away
    # spawn_random_drop()


# Spawns either a honey drop or an ice drop near this node's position.
func spawn_random_drop() -> void:
    var pick: int = randi() % 2
    var drop_scene = pick == 0 ? SPAWNABLE_DROP_1 : SPAWNABLE_DROP_2

    var drop_instance: Node2D = drop_scene.instantiate()
    # Give the drop a small random offset for variety
    drop_instance.position = position + Vector2((randi() % 64) - 32, (randi() % 64) - 32)

    # Add drop as a sibling (or child) to this node's parent
    get_parent().add_child(drop_instance)
