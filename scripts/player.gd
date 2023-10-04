extends CharacterBody2D

@export var gravity: float = 1600.0
@export var speed: float = 60.0
@export var jump_power: float = 100

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_looking_right: bool = false

func _physics_process(delta: float) -> void:
    if is_on_floor():
        # Reset gravity when player touches the floor
        velocity.y = 0.0
    else:
        # Apply gravity
        velocity.y += gravity * delta

    # Handle movement
    var direction = Input.get_axis("move_left", "move_right")
    velocity.x = direction * speed
    is_looking_right = velocity.x >= 0.0

    # Play the appropriate animation
    play_animation()

    move_and_slide()

func play_animation() -> void:
    # Play walking animation when player walks, Idle when player stops walking
    if is_walking():
        sprite.play("walk")
        sprite.flip_h = is_looking_right
    else:
        sprite.play("idle")

func is_walking() -> bool:
    return velocity.x != 0.0