extends Node2D


@onready var background: Sprite2D = $Sprite2D

@export var scroll_speed: float = 200.0  # Background scroll speed
@export var stop_position: float = 4016.0  # Y position where the background stops

func _process(delta):
	# Move the background down
	if position.y < stop_position:
		position.y += scroll_speed * delta
	else:
		# Stop the background when it reaches the stop_position
		position.y = stop_position
