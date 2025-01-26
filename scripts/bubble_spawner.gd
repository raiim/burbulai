extends Marker2D

@onready var bubbles_obj = load("res://scenes/bubbles.tscn")

var is_on_cooldown = false
var cooldown_timer_value = .5

func _process(delta: float) -> void:
	if is_on_cooldown:
		return
		
	spawn_bubbles()
	
func timer_cooldown():
	is_on_cooldown = true
	await get_tree().create_timer(cooldown_timer_value).timeout
	is_on_cooldown = false

func spawn_bubbles():
	print("spawning bubbles")
	var width = get_viewport_rect().size.x
	var height = get_viewport_rect().size.y
	var bubbles = bubbles_obj.instantiate()
	var x = randf_range(0, width)
	var y = randf_range(0, height)
	print([x, y])
	bubbles.set_position(Vector2(x, y))
	get_tree().get_root().get_node("Game").add_child(bubbles)
	timer_cooldown()
	
