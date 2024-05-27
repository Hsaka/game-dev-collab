extends Node3D

var active:bool = false
@export var row = 0
@export var col = 0
@export var path_number = 0
@export var health = 10:
	set(x):
		health=x
		if(health<=0):
			get_parent().remove.emit(row, path_number, self)
			$defense.visible = false
@export var gen:int = 0:
	set(i):
		if(bool(i)and not active):
			$Area3D.visible = true
			gen = i
		else:$Area3D.visible = false
	get:return gen

@export var defenses = [
preload("res://level/defenses/1.tscn"),
preload("res://level/defenses/2.tscn"),
preload("res://level/defenses/3.tscn"),
preload("res://level/defenses/4.tscn"),
preload("res://level/defenses/5.tscn"),
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		$defense.add_child(defenses[gen-1].instantiate())
		get_parent().hide.emit(row, col, path_number, self)
