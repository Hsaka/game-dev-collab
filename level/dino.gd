extends Node3D

@export var spawn_index = 0
@export var health:int = 10
@export var obstacle_index = 0:
	set(i):obstacle_index = i
@export var row:int = 0
@export var path_number = 0
@export var attack_period = 1
@export var attack_damage = 0

var walk_speed = 0
var speed = 0
var front = 0

@export var dino:int = 0:
	set(dino):
		dino = dino
		walk_speed = [0.5, 0.25, 1.0][dino]
		front = [0.8, 1.8, 0.5][dino]
		attack_period = [20, 40, 10][dino]
		attack_damage = [1, 4, 0.2][dino]
		health = [10, 30, 5][dino]
		speed = walk_speed
		get_children()[dino].visible = true
	get:return dino

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
