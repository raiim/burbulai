extends Node

@onready var ui = $Ui

var is_time_stopped = false

func _ready() -> void:
	Globals.time_elapsed = 0.0
	$audio_bubles.playing = true
	$audio_heart_beat.playing = true

func _process(delta: float) -> void:
	if !is_time_stopped:
		Globals.time_elapsed += delta
		if Globals.time_elapsed < 45:
			Globals.current_stage = 0
		elif Globals.time_elapsed < 100:
			Globals.current_stage = 1
		else:
			Globals.current_stage = 2
			
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit_game"):
		get_tree().paused = true
		ui.get_node("Panel").visible = true
		
	if event.is_action_pressed("restart_game"):
		Globals.total_fish_count = 0
		get_tree().reload_current_scene()
		
