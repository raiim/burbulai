extends Control

@export var is_debug: bool = true
@export var health_score: int = 4
@export var audio_heart_beat: AudioStreamPlayer2D
@export var audio_glass_crack: AudioStreamPlayer2D
@export var audio_air_release: AudioStreamPlayer2D

@onready var label_fps: Label = $Label
@onready var entity_spawner_list = $ItemList


@onready var health_full: AnimatedSprite2D = $Control/health_full
@onready var health_medium: AnimatedSprite2D = $Control/health_medium
@onready var health_low: AnimatedSprite2D = $Control/health_low

@onready var vignete_full: Sprite2D = $vignete_new
@onready var vignete_medium: Sprite2D = $vignete_medium
@onready var vignete_damaged: Sprite2D = $vignete_damaged

@onready var low_health: Sprite2D = $low_health

@onready var show_bandages: Sprite2D = $bandages
@onready var show_darkness: Sprite2D = $darkness

var count_sound: int = 0
var is_entity_spawner_on = false
var entity_spawner_selected = null

func _ready():
	show_darkness.visible = true
	show_bandages.visible = false
	health_medium.visible = false
	health_low.visible = false
	vignete_damaged.visible = false
	vignete_medium.visible = false
	
func _process(_delta):
	if is_debug:
		label_fps.text = "FPS: " + str(Engine.get_frames_per_second())
		handle_entity_spawner()

	apply_bandages()
	play_grass_crack_sound()
	update_health_status()
	
func apply_bandages():
	if Input.is_action_just_pressed("apply_bandages"):
		show_bandages.visible = true

func play_grass_crack_sound():
	if health_score == 3 and count_sound == 0:
		audio_glass_crack.play()
		count_sound += 1
	elif health_score == 2 and count_sound == 1:
		audio_glass_crack.play()
		count_sound += 1
	elif health_score == 1 and count_sound == 1:
		audio_air_release.play()
		count_sound += 1
		
func update_health_status():	
	if health_score == 3:
		health_full.visible = false
		health_medium.visible = true
		health_low.visible = false
		
		vignete_full.visible = false
		vignete_medium.visible = true
		vignete_damaged.visible = false
		
		low_health.visible = false
		audio_heart_beat.pitch_scale = 1.37
		audio_heart_beat.volume_db = 5
	
		
	elif health_score == 2:
		health_full.visible = false
		health_medium.visible = false
		health_low.visible = true
		
		vignete_full.visible = false
		vignete_medium.visible = false
		vignete_damaged.visible = true
		
		low_health.visible = false
		audio_heart_beat.pitch_scale = 1.45
		audio_heart_beat.volume_db = 8
		
	elif health_score == 1:
		health_full.visible = false
		health_medium.visible = false
		health_low.visible = true
		
		vignete_full.visible = false
		vignete_medium.visible = false
		vignete_damaged.visible = true
		
		low_health.visible = true
		audio_heart_beat.pitch_scale = 1.45
		audio_heart_beat.volume_db = 10
		
	else:
		health_full.visible = true
		health_medium.visible = false
		health_low.visible = false
		
		vignete_full.visible = true
		vignete_damaged.visible = false
		vignete_medium.visible = false
		
		low_health.visible = false
		audio_heart_beat.pitch_scale = 0.97

func handle_entity_spawner():
	if Input.is_action_pressed("toggle_entity_spawner"):
		is_entity_spawner_on = !is_entity_spawner_on
	if is_entity_spawner_on:
		entity_spawner_selected = entity_spawner_list.get_selected_items()
		if entity_spawner_selected != null && Input.is_action_just_released("secondary_action"):
			if entity_spawner_selected == [1]:
				pass
				
