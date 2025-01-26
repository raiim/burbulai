extends CharacterBody2D

@export var health: int = 2
@export var speed : float = 300
@export var acceleration : float = 0.009
@export var rotation_speed : float = 0.9
@export var move_timer_value: float = 3.0
@export var attack_timer_value: float = 3.0
@export var stun_timer_value: float = 1.0
@export var is_swim_jumpy = false

@onready var player = $"../Player"
@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D

var is_stunned: bool = false
var can_move: bool = true
var can_attack: bool = true
var deletion_offset = 300
var is_alive = true
var count: int = 0

func _ready() -> void:
	Globals.total_fish_count += 1
	var target = (player.position - global_position).angle() + deg_to_rad(90)
	rotation = target

func _process(_delta: float) -> void:
	# ensure one time evaluation
	if health == 0:
		is_alive = false
		Globals.total_fish_count -= 1
		health -= 1
	
	if !is_alive:
		sprite.stop()
		collision_shape.disabled = true
		
	player_takes_damage()
	# target should be player or point	
	var target = (player.position - global_position).angle() + deg_to_rad(90)
	if is_swim_jumpy:
		swim_jumpy(target)
	else:
		swim_regular(target)
	handle_cleanup()
	move_and_slide()

func timer_move():
	can_move = false
	await get_tree().create_timer(move_timer_value).timeout
	can_move = true
	
func timer_stun():
	is_stunned = true
	await get_tree().create_timer(stun_timer_value).timeout
	is_stunned = false
	
func timer_attack():
	can_attack = false
	await get_tree().create_timer(attack_timer_value).timeout
	can_attack = true

func hurt():
	health -= 1
	timer_stun()
	
func player_takes_damage():
	if !can_attack or !is_alive:
		return
		
	var collision_count = get_slide_collision_count()
	for i in collision_count:
		if i:
			var collition_info = get_slide_collision(i)
			var collider = collition_info.get_collider()

			if count <= 4 and collider.has_method("take_damage"):
				#if get_actual_velocity() >= attack_min_speed:
				collider.take_damage(1)
				count += 1

				timer_attack()
				timer_stun()
				return
	
func swim_regular(target: float) -> void:
	if !is_alive:
		velocity = lerp(velocity, Vector2(0, speed), acceleration / 4)
		var target_rotation = velocity.angle() + deg_to_rad(90)
		rotation = lerp_angle(rotation, target_rotation, rotation_speed)
		return
		
	# slow down and sluggish rotation on stun
	if is_stunned:
		velocity = lerp(velocity, Vector2.ZERO, acceleration)
		rotation = lerp_angle(rotation, target, rotation_speed / 10)
		return
		
	var acceleration_angle = target - deg_to_rad(90)
	var direction = Vector2(cos(acceleration_angle), sin(acceleration_angle))
	rotation = lerp_angle(rotation, target, rotation_speed)
	if can_move:
		velocity = lerp(velocity, direction * speed, acceleration)
		#velocity = Vector2(0, -1).rotated(rotation) * speed
		#velocity.x = lerp(velocity.x, speed, acceleration)
		#velocity.y = lerp(velocity.y, speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, acceleration)
	
func swim_jumpy(target: float) -> void:
	if !is_alive:
		velocity = lerp(velocity, Vector2(0, speed), acceleration / 4)
		var target_rotation = velocity.angle() + deg_to_rad(90)
		rotation = lerp_angle(rotation, target_rotation, rotation_speed)
		return
		
	if is_stunned:
		velocity = lerp(velocity, Vector2.ZERO, acceleration)
		rotation = lerp_angle(rotation, target, rotation_speed / 10)
		return
		
	rotation = lerp_angle(rotation, target, rotation_speed)
	if can_move:
		velocity = Vector2(0, -1).rotated(rotation) * speed
		timer_move()
	else:
		velocity = lerp(velocity, Vector2.ZERO, acceleration)

func handle_cleanup():
	var width = get_viewport_rect().size.x
	var height = get_viewport_rect().size.y

	if position.x > width + deletion_offset or position.x < -deletion_offset:
		#print("deleted!")
		queue_free()
	elif position.y > height + deletion_offset or position.y < -deletion_offset:
		#print("deleted!")
		queue_free()

func get_actual_velocity() -> float:
	return sqrt(pow(velocity.x, 2) + pow(velocity.y, 2)) 
