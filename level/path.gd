extends Path3D

@export var wander_scale:float = 0.5
@export var row_count:int = 4
@export var column_count:int = 36
@export var defense_row_gap:float = 1.0
@export var defense_col_spacing:float = 1.0
@export var road_width:float = 1.0
@export var spawn_period:float = 2.0
@export var enemy_speed:float = 0.5
@export var process_count = 0

var x = 0.0
var rand = 0.0
var spawn_time = 0.0
var spawn_index = 0
var row_dist = []
var dino_rows = []

@export var defenses = [[],[],[],[]]:
	set(position):
		defense_update(position)

func defense_update(position):
	defenses[position[0]].append(position[1])
	defenses[position[0]].sort()

@export var path_number = 0:
	set(n):
		path_number = n
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
				defense.set('row', row)
				defense.set('col', column)
				defense.set('path_number', path_number)
				get_parent().get_child(0).add_child(defense)
			
		get_child(0).free()

# Called when the node enters the scene tree for the first time.
func _ready():
	row_count = get_parent().get_parent().get('row_count')
	column_count = get_parent().get_parent().get('column_count')
	defense_col_spacing = 1.0/column_count
	for i in range(row_count):
		row_dist.append(0)
		dino_rows.append([])

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
	if not bool(index % 25):return 1
	elif not bool(index % 4):return 2
	else:return 0

var dino_index = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_count += 1
	if (spawn_time > 1.0):
		spawn_time = 0.0
		var enemy_controller = PathFollow3D.new()
		var enemy = preload('res://level/dino.tscn').instantiate()
		var row = dino_select(dino_index)
		enemy.set('dino', row)
		dino_index += 1
		enemy.scale = Vector3(0.3, 0.3, 0.3)
		enemy_controller.add_child(enemy)
		enemy_controller.get_child(0).set('row', row_selector())
		enemy_controller.get_child(0).set('spawn_index', dino_index)
		add_child(enemy_controller)
		dino_rows[row].append(enemy_controller)
	else:spawn_time+=delta
	
	for e in get_children():
		var dino = e.get_child(0)
		e.progress += delta*dino.get('speed')
		var defenses = get_parent().get_child(0).get('defenses')[path_number-1]
		var dino_row = (dino.get('row')+1) % row_count
		
		if(dino.get('obstacle_index') < len(defenses[dino_row]) and e.progress_ratio >=
			float(defenses[dino_row][dino.get('obstacle_index')].get('col')-dino.get('front')) / float(column_count)):
				if(e.progress_ratio >
					float(defenses[dino_row][dino.get('obstacle_index')].get('col')) / float(column_count)):
						dino.set('obstacle_index', dino.get('obstacle_index')+1)
				elif(dino.get('speed') == 0):
					if(process_count % dino.get('attack_period')):
						var obstacle = defenses[dino_row][dino.get('obstacle_index')]
						obstacle.set('health', obstacle.get('health')-dino.get('attack_damage'))
				else:dino.set('speed', 0)
		else:dino.set('speed', dino.get('walk_speed'))
		
		var seed = int(dino.get('row'))
		rand = (seed % row_count)/2.0 - 1.0 + (road_width/row_count)
		x = e.progress + dino.get('row')**2
		dino.position = Vector3(rand + (wander_scale*
			sin(x)/10 +
			sin(2.77*x)/18),
			-0.20, 0)
		
		dino.rotation_degrees = Vector3(0,
			((cos(x)/10) + (2.77*cos(2.77*x)/18))*-114.59*wander_scale,
			0)
			
		if(e.progress_ratio >= 1.0):e.queue_free()
