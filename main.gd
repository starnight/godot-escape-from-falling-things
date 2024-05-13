extends Node

@export var falling_scene: PackedScene

var elapsed_time = 0
var life = 3

func reset_game():
	elapsed_time = 0
	life = 3
	$UserInterface/TimeLabel.text = "Elapsed Time: %ds" % elapsed_time
	$UserInterface/LifeLabel.text = "Life: %d" % life
	$UserInterface/Retry.hide()
	$Timers/GameDurationTimer.start(0)
	$UserInterface/ElapsedTimer.start(0)
	$Timers/FallingTimer.start(0)

func _process(delta):
	if Input.is_action_pressed("enter_game") and $UserInterface/Retry.visible:
		reset_game()

func _on_falling_timer_timeout():
	var falling = falling_scene.instantiate()

	falling.position.x = randf_range(-6.0, 6.0)
	falling.position.z = randf_range(-6.0, 6.0)
	falling.position.y = 4
	add_child(falling)

func _on_elapsed_timer_timeout():
	elapsed_time += 1
	$UserInterface/TimeLabel.text = "Elapsed Time: %ds" % elapsed_time

func stop_game():
	$Timers/FallingTimer.stop()
	$UserInterface/ElapsedTimer.stop()
	$UserInterface/Retry/Label.text = "Press Enter to retry."
	$UserInterface/Retry.show()

func _on_game_duration_timer_timeout():
	stop_game()

func _on_player_hit():
	life -= 1
	$UserInterface/LifeLabel.text = "Life: %d" % life
	if life <= 0:
		stop_game()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		# This restarts the current scene.
		get_tree().reload_current_scene()


func _on_shake_timer_timeout():
	%ShakeTimer.start(3.0 + 3.0 * randf())  # between 3 and 6 seconds
	%Camera3D.add_stress(0.2 + 0.2 * randf())  # between 0.2 and 0.4
