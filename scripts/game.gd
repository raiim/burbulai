extends Node

@onready var ui = $Ui

var time_elapsed = 0.0
var is_stopped = false

func _ready() -> void:
	time_elapsed = 0.0
	$audio_bubles.playing = true
	$audio_heart_beat.playing = true

func _process(delta: float) -> void:
	if !is_stopped:
		time_elapsed += delta
		print("time: ", time_elapsed)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit_game"):
		get_tree().paused = true
		ui.get_node("Panel").visible = true
		
	if event.is_action_pressed("restart_game"):
		Globals.total_fish_count = 0
		get_tree().reload_current_scene()
		
