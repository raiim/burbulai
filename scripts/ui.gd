extends Control

@export var is_debug: bool = true
@onready var label_fps: Label = $Label

func _process(_delta):
	if is_debug:
		label_fps.text = "FPS: " + str(Engine.get_frames_per_second())
