extends Marker2D

# speed chart
# lamp - 400

# deceleration chart
# lamp - 0.009

# rotation_speed chart
# lamp - 0.025

# timer_value chart
# lamp - 3.0

var spawn_interval_min: float = 0
var spawn_interval_max: float = 0
@export var items:Array[PackedScene] = []
# stage 1 (5-10) max 3
# stage 2 (x-x)
# stage 3 (x-x)
var is_on_cooldown = false
var cooldown_timer_value: float = 1
var spawn_offset = 200
		

func _process(delta: float) -> void:
	if is_on_cooldown:
		return
		
	cooldown_timer_value = randf_range(5, 10)
	spawn_fish()
	
	
func timer_cooldown():
	is_on_cooldown = true
	await get_tree().create_timer(cooldown_timer_value).timeout
	is_on_cooldown = false


func spawn_fish():
	var width = get_viewport_rect().size.x
	var height = get_viewport_rect().size.y
	var fish_scene = items.pick_random()
	var fish = fish_scene.instantiate()
	var min_dist = 50
	var x = randf_range(-spawn_offset, width + spawn_offset)
	var y = -spawn_offset
	if x < 0 - min_dist or x > width + min_dist:
		y = randf_range(-spawn_offset, height + spawn_offset)
	fish.set_position(Vector2(x, y))
	get_tree().get_root().get_node("Game").add_child(fish)
	timer_cooldown()
	
