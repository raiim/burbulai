extends CharacterBody2D

@export var max_speed = 300
@export var acceleration = 0.025
@export var rotation_speed = 0.025
@onready var player_sprite = $Sprite2D
@onready var main = get_tree().get_root().get_node("Game")
@onready var projectile = load("res://scenes/projectile.tscn")

@onready var emmiter = get_node("BulletEmmiter")
@onready var harpoon_obj = get_node("Harpoon")
@onready var ui: Control = $"../Ui"

var projectile_return_timer = 3.0
var is_shoot_cooldown = false
var proj_instance

# Offset values for screen bounds
var offset_x = 200
var offset_y = 0  # Allow vertical movement above the screen
var screen_size: Vector2

var player_health: int = 4
var is_on_damage_cooldown: bool = false
var left_screen_timer: float = 2.0
var count = 0


func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size

func _physics_process(_delta: float) -> void:
	if player_is_outside_the_screen() and !is_on_damage_cooldown:
		set_timer()
		take_damage(1)
		
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	var direction_normalized = direction.normalized()	
	var _actual_velocity = sqrt(pow(velocity.x, 2) + pow(velocity.y, 2))
	var _full_player_rotation_deg = rad_to_deg(player_sprite.rotation)
	
	# apply velocity to player by increasing moving speed by 'acceleration'
	if direction != Vector2.ZERO:
		var target_x = direction_normalized.x * max_speed
		var target_y = direction_normalized.y * max_speed
		velocity.x = lerp(velocity.x, target_x, acceleration)
		velocity.y = lerp(velocity.y, target_y, acceleration)
	# decelerate if player not moving
	else:
		velocity.x = lerp(velocity.x, 0.0, acceleration)
		velocity.y = lerp(velocity.y, 0.0, acceleration)
		
	if direction_normalized != Vector2.ZERO:
		# the computed angle is off by 90 degrees so we just add it here
		var target = direction_normalized.angle() + deg_to_rad(90)
		rotation = lerp_angle(rotation, target, rotation_speed)
	
	if Input.is_action_just_released("shoot") && !is_shoot_cooldown:
		shoot()
	
	# TODO: add debug labels
	#print("velocity: ", _actual_velocity)
	#print("rotation: ", _full_player_rotation_deg)
		
	move_and_slide()

	
# TODO: move logic to 'harpoon' entity
func shoot():
	proj_instance = projectile.instantiate()
	proj_instance.spawn_position = emmiter.global_position
	proj_instance.target_position = get_global_mouse_position()
	main.add_child.call_deferred(proj_instance)
	shoot_timer()
	
func shoot_timer():
	is_shoot_cooldown = true	
	await get_tree().create_timer(projectile_return_timer).timeout
	is_shoot_cooldown = false

func take_damage(damage:int):
	player_health -= damage
	ui.health_score = player_health

	if player_health <= 0:
		show_death_panel()

func show_death_panel():
	print("Player is dead!")
	get_tree().paused = true
	ui.get_node("Panel").visible = true

func set_timer():
	is_on_damage_cooldown = true
	await get_tree().create_timer(left_screen_timer).timeout
	is_on_damage_cooldown = false
	
func player_is_outside_the_screen() -> bool:
	# Get the screen size
	var offset: int = 200
	# Check if the player is outside the screen bounds
	if position.x < -offset or position.x > screen_size.x + offset \
	or position.y < -offset or position.y > screen_size.y + offset:
		return true
	return false	
