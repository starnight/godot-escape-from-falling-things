extends Marker3D

@export var camera_speed = 0.1

func _process(delta):
	if Input.is_action_pressed("camera_left"):
		rotation.y -= 1 * camera_speed
	if Input.is_action_pressed("cemera_right"):
		rotation.y += 1 * camera_speed
	if Input.is_action_pressed("camera_down"):
		rotation.x += 1 * camera_speed / 2
	if Input.is_action_pressed("camera_up"):
		rotation.x -= 1 * camera_speed / 2
