extends CharacterBody2D


@export var max_speed = 300
@export var acceleration = 0.025
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

	
	if direction != Vector2.ZERO:
		velocity.x = lerp(velocity.x, direction_normalized.x * max_speed, acceleration)
		velocity.y = lerp(velocity.y, direction_normalized.y * max_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, acceleration)
		velocity.y = lerp(velocity.y, 0.0, acceleration)
		
	print(velocity)
		
	move_and_slide()
