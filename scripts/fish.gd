extends CharacterBody2D

# lamp jumpy
#@export var speed : float = 700
#@export var acceleration : float = 0.009
#@export var rotation_speed : float = 0.025
#@export var timer_value: float = 2.0

@export var speed : float = 300
@export var acceleration : float = 0.009
@export var rotation_speed : float = 0.9
@export var timer_value: float = 3.0
@onready var player = $"../Player"

var is_move: bool = true
var deletion_offset = 100
var is_swim_jumpy = false

func _process(_delta: float) -> void:
	# target should be player or point	
	var target = (player.position - global_position).angle() + deg_to_rad(90)
	#swim_jumpy(target)
	swim_regular(target)
	handle_cleanup()
	print(sqrt(pow(velocity.x, 2) + pow(velocity.y, 2)))
	move_and_slide()
	
func swim_regular(target: float) -> void:
	var acceleration_angle = target - deg_to_rad(90)
	var direction = Vector2(cos(acceleration_angle), sin(acceleration_angle))
	rotation = lerp_angle(rotation, target, rotation_speed)
	if is_move:
		velocity = lerp(velocity, direction * speed, acceleration)
		#velocity = Vector2(0, -1).rotated(rotation) * speed
		#velocity.x = lerp(velocity.x, speed, acceleration)
		#velocity.y = lerp(velocity.y, speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, acceleration)
	
func swim_jumpy(target: float) -> void:
	rotation = lerp_angle(rotation, target, rotation_speed)
	if is_move:
		velocity = Vector2(0, -1).rotated(rotation) * speed
		move_timer()
	else:
		velocity = lerp(velocity, Vector2.ZERO, acceleration)
	
func move_timer():
	is_move = false
	await get_tree().create_timer(timer_value).timeout
	is_move = true
	
func handle_cleanup():
	var width = get_viewport_rect().size.x
	var height = get_viewport_rect().size.y
	var deletion_offset = 300
	if position.x > width + deletion_offset or position.x < -deletion_offset:
		print("deleted!")
		queue_free()
	elif position.y > height + deletion_offset or position.y < -deletion_offset:
		print("deleted!")
		queue_free()
