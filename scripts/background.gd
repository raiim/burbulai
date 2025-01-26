extends Node2D


@onready var background: Sprite2D = $Sprite2D

@export var scroll_speed: float = 200.0  # Background scroll speed
@export var start_position: float = -248  #4016.0  # Y position where the background stops
@export var stop_position: float = 1330  


func _process(delta):
	# Move the background down
	if position.y < stop_position:
		position.y += scroll_speed * delta
	else:
		# Stop the background when it reaches the stop_position
		position.y = start_position
