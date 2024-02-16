extends Node3D

@export var enemy_scene = preload("res://enemy.tscn")
@export var defense_scene = preload("res://defense.tscn")
@export var rows_count = 7
@export var rows_thickness = 6.0
@export var columns_count = 8
@export var columns_thickness = 6.0
@export var spawn_timeout = 2.0
@export var scatter = 0.125
@export var x_offset = 0.0
@export var z_offset = 0.0

var rows = []
var enemy
var defense
var spawn_time = 0.0
var dist_tracker = []
var z_selector = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for index in range(rows_count):
		rows.append((index * rows_thickness / rows_count) - rows_thickness/2.0)
		dist_tracker.append(0)
		
	for z in range(rows_count):
		for x in range(columns_count):
			defense = defense_scene.instantiate()
			defense.position = Vector3(
				x*columns_thickness/columns_count - (columns_thickness/2.0),
				-0.14,
				z*rows_thickness/rows_count - (rows_thickness/2.0)
				)
			add_child(defense)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_time += delta
	if(spawn_time > spawn_timeout):
		while(dist_tracker[z_selector] != 0):
			z_selector = randi() % rows_count
			
		for i in range(rows_count):
			if(dist_tracker[i] != 0):
				dist_tracker[i] -= 1
		dist_tracker[z_selector] = 3
				
		enemy = enemy_scene.instantiate()
		enemy.position = Vector3(3, 1, rows[z_selector] + randf()*scatter - scatter)
		print(enemy.position.z)
		add_child(enemy)
		spawn_time = 0
