extends CharacterBody2D


@export var speed : float = 400
@export var deceleration : float = 0.018
@export var rotation_speed : float = 0.02
@export var timer_value: float = 3.0

@onready var player = $"../Player"

var is_move: bool = false

var spawn_position : Vector2
var target_position : Vector2

func _ready() -> void:
	print(player)
	is_move = true
	pass

func _process(_delta: float) -> void:
	look_at(player.position)
	rotation += deg_to_rad(90)
	
	if is_move:
		velocity = Vector2(0, -1).rotated(rotation) * speed
		move_timer()
	else:
		velocity = lerp(velocity, Vector2.ZERO, deceleration)
	move_and_slide()
	
	
func move_timer():
	is_move = false
	await get_tree().create_timer(2.0).timeout
	is_move = true
	
