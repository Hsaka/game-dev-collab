extends Path3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var x = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$PathFollow3D2.progress += delta
	x = $PathFollow3D2.progress
	$PathFollow3D2/Node3D.position = Vector3(
		sin(x)/10 +
		sin(3.5*x)/20,
		0, 0)
	$PathFollow3D2/Node3D/MeshInstance3D.rotation_degrees = Vector3(0,
		((cos(x)/10) + (3.5*cos(3.5*x)/20))*-130,
		0)
