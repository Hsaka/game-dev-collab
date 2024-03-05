#@tool
extends Path3D

@export var path_seed = 0
@export var wander_scale = 0.5
@export var row_count = 4
@export var road_width = 1.0
@export var spawn_period = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(curve.get_baked_points())
	pass # Replace with function body.

var x = 0.0
var rand = 0.0
var spawn_index = 0
var spawn_time = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (spawn_time > 1.0):
		spawn_time = 0.0
		var enemy_controller = PathFollow3D.new()
		var enemy = preload('res://path_level/enemy.tscn').instantiate()
		enemy_controller.add_child(enemy)
		spawn_index += 1
		enemy_controller.get_child(0).set('row', spawn_index)
		add_child(enemy_controller)
	else:spawn_time+=delta
	
	for e in get_children():
		e.progress += delta*1.0
		
		var seed = int(e.get_child(0).get('row'))
		rand = (seed % row_count)/2.0 - 1.0 + (road_width/row_count)
		x = e.progress + e.get_child(0).get('row')**2
		e.get_child(0).position = Vector3(rand + (wander_scale*
			sin(x)/10 +
			sin(2.77*x)/18),
			-0.20, 0)
		
		e.get_child(0).rotation_degrees = Vector3(0,
			((cos(x)/10) + (2.77*cos(2.77*x)/18))*-114.59*wander_scale,
			0)
			
		if(e.progress > 23):e.queue_free()
