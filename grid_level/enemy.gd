extends CharacterBody3D

@export var SPEED = .3
@export var gravity = 0.005

func attack(area):
	SPEED = 0
	print("attacking")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var area = $Area3D
	area.connect("area_shape_entered", attack, 0)

func _physics_process(delta):
	velocity.x = -SPEED
	if not is_on_floor():
		velocity.y -= gravity + delta
		
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
