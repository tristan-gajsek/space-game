extends CharacterBody2D

func _physics_process(delta):
	position.x = get_global_mouse_position().x
