extends CharacterBody2D

@export var speed : float = 400
@export var deceleration : float = 0.009
@export var rotation_speed : float = 0.025
@export var timer_value: float = 3.0

@onready var player = $"../Player"

var is_move: bool = false

func _ready() -> void:
	print(player)
	is_move = true
	pass

func _process(_delta: float) -> void:
	var target = (player.position - global_position).angle() + deg_to_rad(90)
	swim_jumpy(target)
	move_and_slide()
	
func swim_jumpy(target: float) -> void:
	rotation = lerp_angle(rotation, target, rotation_speed)
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
	
