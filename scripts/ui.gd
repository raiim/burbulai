extends Control

@export var is_debug: bool = true
var is_entity_spawner_on = false
var entity_spawner_selected = null
@onready var label_fps: Label = $Label
@onready var entity_spawner_list = $ItemList


func _process(_delta):
	if is_debug:
		label_fps.text = "FPS: " + str(Engine.get_frames_per_second())
		handle_entity_spawner()
		
		
func handle_entity_spawner():
	if Input.is_action_pressed("toggle_entity_spawner"):
		is_entity_spawner_on = !is_entity_spawner_on
	if is_entity_spawner_on:
		var entity_spawner_selected = entity_spawner_list.get_selected_items()
		if entity_spawner_selected != null && Input.is_action_just_released("secondary_action"):
			if entity_spawner_selected == [1]:
				pass
				
			
		
