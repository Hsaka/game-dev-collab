extends Node3D

@export var gen:int = 0:
	set(i):
		if(bool(i)and not active):
			$Area3D.visible = true
			gen = i
		else:$Area3D.visible = false
	get:return gen
			
var active:bool = false

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
		print(gen)
		$defense.add_child(defenses[gen-1].instantiate())
		get_parent().hide.emit()
