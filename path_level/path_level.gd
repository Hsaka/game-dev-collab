extends Node3D

@onready var enemy_path = $enemy_path

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@export var camera_view = true
const camera_speed = 0.005
@export var direction = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$camera_path/close_up_view.progress_ratio += direction*camera_speed
	$enemy_path/camera_follow.progress_ratio += direction*camera_speed

func _on_left_button_down():
	direction += 1

func _on_left_button_up():
	direction -= 1

func _on_right_button_down():
	direction -= 1

func _on_right_button_up():
	direction += 1

func _on_toggle_view_pressed():
	#if(camera_view):
		#var camera = $camera_path/close_up_view/camera
		#camera.look_at_Mode('None')
		#camera.get_parent().remove_child(camera)
		#$top_view.add_child(camera)
		#$camera_path/camera_move.visible = false
	#else:
		#var camera = $camera_path/close_up_view/camera
		#camera.get_parent().remove_child(camera)
		#$camera_path/close_up_view/camera.add_child(camera)
		#$camera_path/camera_move.visible = true
	#camera_view = !camera_view
	pass
