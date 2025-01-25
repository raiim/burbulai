extends Marker2D


@export var spawn_interval_min: float = 2
@export var spawn_interval_max: float = 3
@export var items:Array[PackedScene] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_fishes()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawn_fishes():
	var fish_scene = items.pick_random()
	var new_fish = fish_scene.instantiate()
	
	add_child(new_fish)
	
	#get_tree().create_timer(randf_range(spawn_interval_min, spawn_interval_max)).timeout.connect(spawn_fishes())
