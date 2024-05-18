extends CharacterBody2D

const SPEED = 200.0
const MOVEMENT = Vector2(0, 1)
const ROTATION_SPEED = 1.0


func _physics_process(delta):
	position += MOVEMENT * SPEED * delta
	rotation += ROTATION_SPEED * delta

func destroy():
	print("Asteroid destroyed")
	queue_free()
