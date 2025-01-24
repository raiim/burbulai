extends CharacterBody2D

@export var max_speed = 300
@export var acceleration = 0.025
@export var rotation_speed = 0.025
@onready var player_sprite: Sprite2D = $Sprite2D

func _physics_process(_delta: float) -> void:
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	var direction_normalized = direction.normalized()	
	var actual_velocity = sqrt(pow(velocity.x, 2) + pow(velocity.y, 2))
	
	# apply velocity to player by increasing moving speed by 'acceleration'
	if direction != Vector2.ZERO:
		var target_x = direction_normalized.x * max_speed
		var target_y = direction_normalized.y * max_speed
		velocity.x = lerp(velocity.x, target_x, acceleration)
		velocity.y = lerp(velocity.y, target_y, acceleration)
	# decelerate if player not moving
	else:
		velocity.x = lerp(velocity.x, 0.0, acceleration)
		velocity.y = lerp(velocity.y, 0.0, acceleration)
		
	if direction_normalized != Vector2.ZERO:
		# the computed angle is off by 90 degrees so we just add it here
		var target = direction_normalized.angle() + deg_to_rad(90)
		player_sprite.rotation = lerp_angle(player_sprite.rotation, target, rotation_speed)
		
	# TODO: add debug label for velocity
	print("velocity: ", actual_velocity)
		
	move_and_slide()
