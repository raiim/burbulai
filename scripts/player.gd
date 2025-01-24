extends CharacterBody2D


@export var speed = 300
@onready var player_skin: Sprite2D = $Sprite2D


func _physics_process(_delta: float) -> void:
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	
	
	if Input.is_action_pressed("move_right"):
		player_skin.scale.x = -1
	elif Input.is_action_pressed("move_left"):
		player_skin.scale.x = 1

		
	var direction_normalized = direction.normalized()
	
	velocity = direction_normalized * speed
	move_and_slide()
	
	
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("move_left", "move_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
