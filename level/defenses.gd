extends Node3D
signal hide

# Called when the node enters the scene tree for the first time.
func _ready():
	# hide all spawners when signal is detected
	hide.connect(func():for s in get_children():s.set('gen', 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
