extends Path3D

@export var row_count = 4
@export var road_width = 1.0
@export_range(1, 20) var defense_lines = 10:
	set (value):
		defense_lines = value
		spawn_defense_spots()
	get:
		return defense_lines

func spawn_defense_spots():
	for line in get_children():
		line.free()
		
	for line in range(defense_lines):
		for row in range(row_count):
			var defense_spot = preload("res://path_level/defense_spawner.tscn").instantiate()
			defense_spot.position = Vector3(line*5, 0, row*2)
			add_child(defense_spot)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_defense_spots()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
