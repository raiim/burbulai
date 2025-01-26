extends CharacterBody2D

var timer_value = 2.0

func start_lifetime():
	await get_tree().create_timer(timer_value).timeout
	queue_free()

func _ready() -> void:
	start_lifetime()
