extends CharacterBody2D

@onready var laser_1 = $"Laser 1"
@onready var laser_2 = $"Laser 2"

func _physics_process(delta):
	position.x = get_global_mouse_position().x

func _process(delta):
	if laser_1.is_colliding() or laser_2.is_colliding():
		print("Hit!")
