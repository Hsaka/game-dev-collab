extends Node3D

var enemy_scene = preload("res://enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy = enemy_scene.instantiate()
	# enemy.setposition()
	add_child(enemy)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
