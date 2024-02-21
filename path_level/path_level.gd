extends Node3D

@onready var enemy_path = $enemy_path

# Called when the node enters the scene tree for the first time.
func _ready():
	$game/far_cam.current = true

@export var camera_view = true
const camera_speed = 0.005
@export var direction = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$game/camera_path/close_up_view.progress_ratio += direction*camera_speed
	$game/enemy_path/camera_follow.progress_ratio += direction*camera_speed

func _on_left_button_down():direction += 1
func _on_left_button_up():direction -= 1
func _on_right_button_down():direction -= 1
func _on_right_button_up():direction += 1

func _on_pause_pressed():$game.get_tree().paused = !$game.get_tree().paused

func toggle_view(mode):
	$game/far_cam.current = mode
	$game/close_cam.current = !mode
	$game/camera_path/view_move.visible = !mode
	$game/camera_path/view_move.set_process(!mode)

func _on_view_pressed():
	if($game/close_cam.current):toggle_view(true)
	else:toggle_view(false)


func _on_defense_menu_view_pressed():
	if($game/defenses.visible):
		$game/defenses.visible = false
		$game/defense_menu_view.position.y += 100
	else:
		$game/defenses.visible = true
		$game/defense_menu_view.position.y -= 100
