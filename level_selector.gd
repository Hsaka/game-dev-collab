extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	var level = preload("res://path_level/path_level.tscn").instantiate()
	$level.add_child(level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
