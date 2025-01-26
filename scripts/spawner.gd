extends Marker2D

@export var monster_sound: AudioStreamPlayer2D


# fishrang regular
#@export var health: int = 5
#@export var speed : float = 200
#@export var acceleration : float = .003
#@export var rotation_speed : float = 0.009
#@export var move_timer_value: float = 3.0
#@export var attack_timer_value: float = 3.0
#@export var stun_timer_value: float = 0
#@export var is_swim_jumpy = false

# fishlamp jumpy
#@export var health: int = 2
#@export var speed : float = 700
#@export var acceleration : float = 0.009
#@export var rotation_speed : float = 0.03
#@export var move_timer_value: float = 3.0
#@export var attack_timer_value: float = 3.0
#@export var stun_timer_value: float = 1.0
#@export var is_swim_jumpy = true


# fishball regular
#@export var health: int = 2
#@export var speed : float = 300
#@export var acceleration : float = 0.009
#@export var rotation_speed : float = 0.9
#@export var move_timer_value: float = 3.0
#@export var attack_timer_value: float = 3.0
#@export var stun_timer_value: float = 1.0
#@export var is_swim_jumpy = false

# fishball
# health: 1-2
# speed: 300
# acceleration: 0.009
# rotation_speed: 0.9
# move_timer_value: 3.0
# attack_timer_value: 3.0
# stun_timer_value: 1.0

# skin1
# skin2

# attribute intervals
var skin_min = [0, 0, 0]
var skin_max = [0, 1, 3]
var health_min = [2, 2, 4]
var health_max = [3, 4, 7]
var speed = [300, 700, 200]
var acceleration = [0.009, 0.009, 0.009]
var rotation_speed = [0.9, 0.9, 0.009]
var move_timer_value = 3.0
var attack_timer_value = 3.0
var stun_timer_value = [1.0, 1.0, 0]
@export var items:Array[PackedScene] = []
var is_on_cooldown = false
var cooldown_timer_value_min = [4, 3, 3]
var cooldown_timer_value_max = [10, 8, 6]
var cooldown_timer_value: float
var max_fish = [3, 5, 5]
var spawn_offset = 150


func _process(delta: float) -> void:
	if is_on_cooldown or Globals.total_fish_count == max_fish[Globals.current_stage]:
		return
		
	cooldown_timer_value = randf_range(cooldown_timer_value_min[Globals.current_stage], cooldown_timer_value_max[Globals.current_stage])
	spawn_fish()
	
func timer_cooldown():
	is_on_cooldown = true
	await get_tree().create_timer(cooldown_timer_value).timeout
	monster_sound.play()
	is_on_cooldown = false

func spawn_fish():
	var current_skin = floor(randf_range(skin_min[Globals.current_stage], skin_max[Globals.current_stage]))
	var width = get_viewport_rect().size.x
	var height = get_viewport_rect().size.y
	var fish_scene = items[current_skin]
	var fish = fish_scene.instantiate()
	fish.health = floor(randf_range(health_min[current_skin], health_min[current_skin]))
	fish.speed = speed[current_skin]
	fish.move_timer_value = move_timer_value
	fish.attack_timer_value = attack_timer_value
	fish.rotation_speed = rotation_speed[current_skin]
	fish.stun_timer_value = stun_timer_value[current_skin]
	var min_dist = 50
	var x = randf_range(-spawn_offset, width + spawn_offset)
	var y = -spawn_offset
	print(x)
	if x < 0 - min_dist or x > width + min_dist:
		y = randf_range(-spawn_offset, height + spawn_offset)
	fish.set_position(Vector2(x, y))
	get_tree().get_root().get_node("Game").add_child(fish)
	timer_cooldown()
	
