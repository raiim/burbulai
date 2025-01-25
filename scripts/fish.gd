extends CharacterBody2D

@export var speed: float = 200

func _physics_process(delta: float) -> void:
	velocity = Vector2(0, speed)
	move_and_slide()

	## If the fish is out of bounds, remove it
	#if position.y > get_viewport_rect().size.y:
		#queue_free()
