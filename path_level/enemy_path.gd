@tool
extends Path3D

@export var path_seed = 0
@export var wander_scale = 0.5
@export var row_x_value = 0.0
@export var row_count = 4
@export var road_width = 1.0
var enemies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var x = 0.0
var rand = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta, row_x_value = row_x_value, road_width=road_width, row_count=row_count):
	for e in range(len(enemies)):
		enemies[e].progress += delta
		
		row_count = 4
		road_width = 1.0
		
		rand = ((1+e) % row_count)/2.0 - 1.0
		x = enemies[e].progress + e**2
		enemies[e].get_child(0).position = Vector3(rand + (wander_scale*
			sin(x)/10 +
			sin(3.5*x)/20),
			0, 0)
		
		enemies[e].get_child(0).rotation_degrees = Vector3(0,
			((cos(x)/10) + (3.5*cos(3.5*x)/20))*-114.59*wander_scale,
			0)


func _on_enemy_pressed():
	var enemy_controller = PathFollow3D.new()
	var enemy = preload('res://path_level/enemy.tscn').instantiate()
	enemy_controller.add_child(enemy)
	add_child(enemy_controller)
	enemies.append(enemy_controller)
