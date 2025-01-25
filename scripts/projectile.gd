extends CharacterBody2D

@export var speed : float = 700
@export var deceleration : float = .0015
@export var rotation_speed : float = 0.02

var spawn_position : Vector2
var target_position : Vector2

func _ready() -> void:
	global_position = Vector2(spawn_position)
	rotation = get_angle_to(target_position) + deg_to_rad(90)
	velocity = Vector2(0, -1).rotated(rotation) * speed

func _process(delta: float) -> void:
	velocity = lerp(velocity, Vector2.ZERO, deceleration)
	velocity.y = lerp(velocity.y, speed, deceleration)
	var target_rotation = velocity.angle() + deg_to_rad(90)
	global_rotation = lerp_angle(global_rotation, target_rotation, rotation_speed)
	move_and_slide()
