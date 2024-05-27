extends Node3D
signal hide
signal remove

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
	hide.connect(func(row, col, path_number, defense):
		get_parent().get_child(path_number).set('defenses', [row, col])
		defenses[path_number-1][row].append(defense)
		defenses[path_number-1][row].sort_custom(func(a, b):
			return a.get('col')<b.get('col'))
		for s in get_children():s.set('gen', 0)
		)
	
	remove.connect(func(row, path_number, defense):
		var column = defenses[path_number-1][row]
		print(defenses[path_number-1][row])
		for d in range(column.size()):
			if(column[d].get('col')==defense.get('col')):
				defenses[path_number-1][row].remove_at(d)
				break
		)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
