extends Path3D

@export var wander_scale:float = 0.5
@export var row_count:int = 4
@export var column_count:int = 36
@export var defense_row_gap:float = 1.0
@export var defense_col_spacing:float = 0.028
@export var road_width:float = 1.0
@export var spawn_period:float = 2.0
@export var enemy_speed:float = 0.5

var x = 0.0
var rand = 0.0
var spawn_time = 0.0
var spawn_index = 0
var row_dist = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(row_count):row_dist.append(0)
	
	var path_slider = PathFollow3D.new()
	var cursor = Node3D.new()
	path_slider.add_child(cursor)
	add_child(path_slider)
	path_slider.get_child(0).position.y -= 0.2
	
	for column in range(column_count):
		for row in range(row_count):
			path_slider.progress_ratio = column*defense_col_spacing
			var defense = preload('res://level/defense_spawner.tscn').instantiate()
			defense.position = get_child(0).get_child(0).global_position
			path_slider.get_child(0).position.x = \
			(row*(road_width+defense_row_gap)/row_count) - (((road_width+defense_row_gap)/2) - (defense_row_gap/row_count))
			defense.rotation = get_child(0).get_child(0).global_rotation
			get_parent().get_child(0).add_child(defense)
		
	get_child(0).free()

func row_selector():
	# randomly pick a row
	var selected_row = randi() % row_count
	# update row_dist to show how long ago each row spawned an enemy
	for row in range(row_count):if(row_dist[row] != 0):row_dist[row] -= 1

	# if row previously spawned an enemy, pick another one
	while(row_dist[selected_row] != 0): selected_row =  randi() % row_count
	# update row_dist and return the new selected row
	row_dist[selected_row] = row_count/2
	return selected_row

func dino_select(index):
	if not bool(index % 9):return 2
	elif not bool(index % 4):return 1
	else:return 0

var dino_index = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (spawn_time > 1.0):
		spawn_time = 0.0
		var enemy_controller = PathFollow3D.new()
		var enemy = preload('res://level/dino.tscn').instantiate()
		enemy.set('dino', dino_select(dino_index))
		dino_index += 1		
		enemy.scale = Vector3(0.3, 0.3, 0.3)
		enemy_controller.add_child(enemy)
		enemy_controller.get_child(0).set('row', row_selector())
		add_child(enemy_controller)
	else:spawn_time+=delta
	
	for e in get_children():
		e.progress += delta*enemy_speed
		
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
