extends Node3D
signal hide

var defenses = []
@export var row_count:int = 4
@export var column_count:int = 36

# Called when the node enters the scene tree for the first time.
func _ready():
	row_count = get_parent().get_parent().get('row_count')
	column_count = get_parent().get_parent().get('column_count')
	
	for path in range(len(get_parent().get_children())-1):
		defenses.append([])
		for row in range(row_count):defenses[path].append([])
	
	# hide all spawners when signal is detected
	hide.connect(func(row, col, path_number):
		get_parent().get_child(path_number).set('defenses', [row, col])
		defenses[path_number-1][row].append(col)
		defenses[path_number-1][row].sort()
		for s in get_children():s.set('gen', 0)
		)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
