extends CharacterBody2D

@export var max_speed = 300
@export var acceleration = 0.025
@export var rotation_speed = 0.025
@onready var player_sprite: Sprite2D = $Sprite2D
@onready var main = get_tree().get_root().get_node("Game")
@onready var projectile = load("res://scenes/projectile.tscn")
@onready var emmiter = get_node("BulletEmmiter")

func _physics_process(_delta: float) -> void:
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	var direction_normalized = direction.normalized()	
	var _actual_velocity = sqrt(pow(velocity.x, 2) + pow(velocity.y, 2))
	var _full_player_rotation_deg = rad_to_deg(player_sprite.rotation)
	
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
		rotation = lerp_angle(rotation, target, rotation_speed)
	
	if Input.is_action_just_released("shoot"):
		shoot()
	
	#if Input.is_action_just_pressed("move_left"):
		#player_sprite.scale.x = -.6
	#if Input.is_action_just_pressed("move_right"):
		#player_sprite.scale.x = .6
	
	# TODO: add debug labels
	#print("velocity: ", _actual_velocity)
	#print("rotation: ", _full_player_rotation_deg)
		
	move_and_slide()
	
# TODO: move logic to 'harpoon' entity
func shoot():
	var instance = projectile.instantiate()
	instance.spawn_position = emmiter.global_position
	instance.target_position = get_global_mouse_position()
	main.add_child.call_deferred(instance)
	
