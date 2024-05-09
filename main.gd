extends Node

@export var falling_scene: PackedScene

func _on_falling_timer_timeout():
	var falling = falling_scene.instantiate()

	falling.position.x = randf_range(-6.0, 6.0)
	falling.position.z = randf_range(-6.0, 6.0)
	falling.position.y = 4
	add_child(falling)
