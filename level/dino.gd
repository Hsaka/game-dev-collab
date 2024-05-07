extends Node3D

@export var row:int = 0:
	set(value):
		row = value
	get:return row
	
@export var dino:int = 0:
	set(dino):
		dino = dino
		get_children()[dino].visible = true
	get:return dino

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#get_child(0).


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
