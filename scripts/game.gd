extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$audio_bubles.playing = true
	$audio_heart_beat.playing = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Input.is_action_pressed("quit_game"):
		get_tree().quit()
		
	if Input.is_action_pressed("restart_game"):
		get_tree().reload_current_scene()
		
