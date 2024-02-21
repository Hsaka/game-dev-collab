extends Node3D



func _on_grid_level_button_down():
	var current_level = $level/path_level
	current_level.queue_free()
	var grid_type = preload("res://grid_level/grid_level.tscn").instantiate()
	$level.add_child(grid_type)

func _on_path_level_2_button_down():
	var current_level = $level/grid_level
	current_level.queue_free()
	var path_type = preload("res://path_level/path_level.tscn").instantiate()
	$level.add_child(path_type)

# Called when the node enters the scene tree for the first time.
func _ready():
	var level = preload("res://path_level/path_level.tscn").instantiate()
	$level.add_child(level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
