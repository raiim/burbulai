extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.is_action_pressed("quit_game"):
		get_tree().quit()
		
	if Input.is_action_pressed("restart_game"):
		get_tree().reload_current_scene()
		
