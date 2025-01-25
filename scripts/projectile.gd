extends CharacterBody2D

@export var speed = 500
@export var gravity = 100

var spawn_position : Vector2
var target_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = spawn_position
	rotation = get_angle_to(target_position) + deg_to_rad(90)
	print("global: ", global_position)
	print("target: ", target_position)
	print("rot_to_target", rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity = Vector2(0, -1).rotated(rotation) * speed
	move_and_slide()
