extends Node2D

# Use uppercase constant naming for clarity
const SPAWNABLE_DROP_1 = preload("res://scenes/enemy/classic_world/drops/recycle_drop.tscn")
const SPAWNABLE_DROP_2 = preload("res://scenes/enemy/classic_world/drops/trash_drop.tscn")
# Example alternative drop: const SPAWNABLE_DROP_ALT = preload("res://scenes/enemy/heart_drop.tscn")

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ship_component: Node2D = $ship_component
@onready var wait_timer: Timer      = $ship_component/wait_timer

var parent_score: int

func _ready() -> void:
    # Randomize the engine's global seed to ensure more varied results at runtime.
    # If the rest of your game already calls randomize(), you can remove this line.
    randomize()

    # Retrieve the parent node's "score". If it's a script with a 'score' property,
    # ensure that property is accessible.
    parent_score = get_parent().score

    # Example logic: As the game progresses (score grows), the ship drops fewer points.
    # We use match to clamp ship_component.counter increments.
    match int(parent_score / 20):
        0:
            ship_component.counter += randi() % 6
        1:
            ship_component.counter += randi() % 5
        2:
            ship_component.counter += randi() % 4
        3:
            ship_component.counter += randi() % 3
        _:
            ship_component.counter += randi() % 2

    # Start the default animation for the sprite
    animated_sprite.play("default")

    # Increase the ship's speed by a random offset up to 54
    ship_component.speed += randi() % 55

    # Adjust the timer's wait_time by a random factor
    wait_timer.wait_time = (randi() % 2) + ship_component.wait_time

    # Optionally, you could spawn a random drop on start for testing:
    # spawn_drop_random()

# Example function: spawn a random drop from the preloaded scenes
func spawn_drop_random() -> void:
    var use_alternate_drop: bool = bool(randi() % 2)
    var drop_scene: PackedScene = use_alternate_drop ? SPAWNABLE_DROP_2 : SPAWNABLE_DROP_1

    var drop_instance: Node2D = drop_scene.instantiate()
    drop_instance.position = position + Vector2(randi() % 32 - 16, randi() % 32 - 16)
    get_parent().add_child(drop_instance)
