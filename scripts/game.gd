extends Node

@onready var ui = $Ui


func _ready() -> void:
	$audio_bubles.playing = true
	$audio_heart_beat.playing = true

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit_game"):
		get_tree().paused = true
		ui.get_node("Panel").visible = true
		
	if event.is_action_pressed("restart_game"):
		get_tree().reload_current_scene()
		
