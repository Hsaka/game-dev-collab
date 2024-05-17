extends Node3D

@export var defenses = [1, 2, 3, 4, 5]
@export var row_count = 4
@export var column_count = 36

func spawn_defense(type):
	for defense in $enemy_paths/defenses.get_children():
		defense.set('gen', type)

# Called when the node enters the scene tree for the first time.
func _ready():
	$far_cam.current = true
	for defense in defenses:
		var button = TextureButton.new()
		button.texture_normal = load('res://Assets/UI_Icon/T'+str(defense)+'.png')
		button.pressed.connect(func():spawn_defense(defense))
		$defense_picker.add_child(button)
		
	for path in range(1, len($enemy_paths.get_children())):
		$enemy_paths.get_child(path).set('path_number', path)

@export var camera_view = true
const camera_speed = 0.005
@export var direction = 0

var pause = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$camera_path/close_up_view.progress_ratio += direction*camera_speed    # move camera
	$camera/camera_path/camera_follow.progress_ratio += direction*camera_speed    # move camera's target

func _on_left_button_down():direction += 1
func _on_left_button_up():direction -= 1
func _on_right_button_down():direction -= 1
func _on_right_button_up():direction += 1

func toggle_view(mode):
	$far_cam.current = mode
	$camera_path/close_up_view/camera/Camera3D.current = !mode
	$camera_path/view_move.visible = !mode
	$camera_path/view_move.set_process(!mode)
	
func _on_texture_button_pressed():
	if($camera_path/close_up_view/camera/Camera3D.current):toggle_view(true)
	else:toggle_view(false)

func _on_defense_menu_view_2_pressed():
	if($defense_picker.visible):
		$defense_picker.visible = false
		$defense_menu_view.position.y += 100
	else:
		$defense_picker.visible = true
		$defense_menu_view.position.y -= 100

func pause_button():get_tree().paused = !get_tree().paused

func remove_button():
	print('remove pressed')
