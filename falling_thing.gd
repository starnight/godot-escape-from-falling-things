extends RigidBody3D

var triggered = false

func _process(delta):
	if position.y < 2.0 and linear_velocity.y < 0.03 and !triggered:
		triggered = true
		$Timer.start(0)

func _on_timer_timeout():
	queue_free()

func trigger_vanish_timer():
	$Timer.start(0)
