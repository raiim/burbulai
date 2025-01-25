extends CharacterBody2D

@export var speed: float = 200

func _physics_process(delta: float) -> void:
	fish_movement(delta)
	

func fish_movement(_delta):
	velocity = Vector2(0, speed)
	move_and_slide()
	
	## If the fish is out of bounds, remove it
	if position.y > (get_viewport_rect().size.y + 300):
		queue_free()
		
