extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const camera_speed = 0.005
@export var direction = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$camera_path/PathFollow3D.progress_ratio += direction*camera_speed
	$enemy_path/camera_follow.progress_ratio += direction*camera_speed

func _on_left_button_down():
	direction += 1

func _on_left_button_up():
	direction -= 1

func _on_right_button_down():
	direction -= 1

func _on_right_button_up():
	direction += 1
