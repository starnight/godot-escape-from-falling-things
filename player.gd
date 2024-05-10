extends CharacterBody3D

signal hit

# How fast the player moves in meters per second.
@export var speed = 2
var target_velocity = Vector3.ZERO
var invincible = false

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
	
	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Moving the Character
	velocity = target_velocity
	move_and_slide()

	if _is_hit():
		get_hit()

func _is_hit():
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		# If the collision is with ground
		if collision.get_collider() == null:
			continue

		# If the collider is with a falling
		if collision.get_collider().is_in_group("fallings"):
			var col = collision.get_normal()
			if Vector3.UP.dot(col) < -0.1 and !invincible:
				invincible = true
				$InvincibleTimer.start(0)
				var falling = collision.get_collider()
				falling.trigger_vanish_timer()
				return true
			else:
				return false
	return false

func get_hit():
	hit.emit()

func _on_invincible_timer_timeout():
	invincible = false
