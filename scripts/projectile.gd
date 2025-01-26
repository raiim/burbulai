extends CharacterBody2D

@export var speed : float = 700
@export var deceleration : float = .0015
@export var rotation_speed : float = 0.02
@onready var player = $"../Player"

var spawn_position : Vector2
var target_position : Vector2
var is_returning = false
var is_stuck = false

func _ready() -> void:
	global_position = Vector2(spawn_position)
	rotation = get_angle_to(target_position) + deg_to_rad(90)
	velocity = Vector2(0, -1).rotated(rotation) * speed

func _process(_delta: float) -> void:
	handle_cleanup()
	if is_stuck:
		velocity = Vector2.ZERO
		return
		
	velocity = lerp(velocity, Vector2.ZERO, deceleration)
	velocity.y = lerp(velocity.y, speed, deceleration)
	var target_rotation = velocity.angle() + deg_to_rad(90)
	rotation = lerp_angle(global_rotation, target_rotation, rotation_speed)
	move_and_slide()
	fish_hit()

func fish_hit():
	var collision_count = get_slide_collision_count()
	for i in collision_count:
		if i:
			var collition_info = get_slide_collision(i)
			var collider = collition_info.get_collider()
			if collider:
				
				#var harpoon_sprite = Sprite2D.new()
				#harpoon_sprite.texture = load("res://assets/textures/projectile.png")
				#harpoon_sprite.rotation = rotation
				#harpoon_sprite.scale = scale
				#harpoon_sprite.position = position
				#harpoon_sprite.global_transform = global_transform
				self.reparent(collider)
								
				#collider.add_child(harpoon_sprite)
				is_stuck = true
				collider.hurt()
				#queue_free()
				return
				
func return_to_player():
	is_returning = true
	rotation = get_angle_to(player.position) + deg_to_rad(90)
	velocity = Vector2(0, -1).rotated(rotation) * speed

func delete():
	print("deleted projectile!")
	queue_free()

func handle_cleanup():
	var width = get_viewport_rect().size.x
	var height = get_viewport_rect().size.y
	var deletion_offset = 300
	if position.x > width + deletion_offset or position.x < -deletion_offset:
		print("deleted projectile!")
		queue_free()
	elif position.y > height + deletion_offset or position.y < -deletion_offset:
		print("deleted projectile!")
		queue_free()
