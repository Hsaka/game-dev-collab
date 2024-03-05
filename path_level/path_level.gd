extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$enemy_paths/enemy_path_left.set('defense_lines', 7)
	$far_cam.current = true

@export var camera_view = true
const camera_speed = 0.005
@export var direction = 0

var pause = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$camera_path/close_up_view.progress_ratio += direction*camera_speed
	$camera/camera_path/camera_follow.progress_ratio += direction*camera_speed
	
	# move camera target
	#for path in get_node("enemy_paths").get_children():
		#path.get_child(0).progress_ratio += direction*camera_speed

func _on_left_button_down():direction += 1
func _on_left_button_up():direction -= 1
func _on_right_button_down():direction -= 1
func _on_right_button_up():direction += 1

func toggle_view(mode):
	$far_cam.current = mode
	$close_cam.current = !mode
	$camera_path/view_move.visible = !mode
	$camera_path/view_move.set_process(!mode)
	
func _on_texture_button_pressed():
	if($close_cam.current):toggle_view(true)
	else:toggle_view(false)

func _on_defense_menu_view_pressed():
	if($defenses.visible):
		$defenses.visible = false
		$defense_menu_view.position.y += 100
	else:
		$defenses.visible = true
		$defense_menu_view.position.y -= 100


func _on_defense_menu_view_2_pressed():
	if($defenses.visible):
		$defenses.visible = false
		$defense_menu_view.position.y += 100
	else:
		$defenses.visible = true
		$defense_menu_view.position.y -= 100

func pause_button():get_tree().paused = !get_tree().paused

func remove_button():
	print('remove pressed')
