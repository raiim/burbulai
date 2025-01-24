extends CharacterBody2D


@export var max_speed = 300
@export var acceleration = 20
@export var deceleration = 100
@export var damping = .95
@onready var player_skin: Sprite2D = $Sprite2D

func _physics_process(_delta: float) -> void:
		
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	
	var direction_normalized = direction.normalized()
	
	# TODO: rotate to the direction the player is moving to
	if Input.is_action_pressed("move_right"):
		player_skin.scale.x = 1
	elif Input.is_action_pressed("move_left"):
		player_skin.scale.x = -1
		
	if Input.is_action_pressed("move_up"):
		player_skin.scale.y = 1
	elif Input.is_action_pressed("move_down"):
		player_skin.scale.y = -1
	
	print(direction)
	
	
	if direction != Vector2.ZERO:
		print("moving!")
		velocity += direction_normalized * acceleration
		velocity = velocity.clamp(Vector2(-1 * max_speed, -1 * max_speed), Vector2(max_speed, max_speed))
	else:
		velocity *= damping
		
	move_and_slide()
