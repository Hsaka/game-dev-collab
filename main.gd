extends Node3D

@export var enemy_scene = preload("res://enemy.tscn")
const rows_count = 7
const rows_width = 6.0
@export var spawn_frequency = 1000
@export var spawn_timeout = 2

var rows = []
var enemy
var spawn_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	for index in range(rows_count):
		rows.append((index * rows_width / rows_count) - rows_width/2.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_time += delta
	if(spawn_time > spawn_timeout):
		enemy = enemy_scene.instantiate()
		enemy.position = Vector3(3, 1, rows[randi() % rows_count])
		print(enemy.position.z)
		add_child(enemy)
		spawn_time = 0
