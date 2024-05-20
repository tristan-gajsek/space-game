extends Node2D

const SPEED = 200.0
const MOVEMENT = Vector2(0, 1)

func _physics_process(delta):
	position += MOVEMENT * SPEED * delta

func destroy():
	print("Health kit destroyed")
	queue_free()
