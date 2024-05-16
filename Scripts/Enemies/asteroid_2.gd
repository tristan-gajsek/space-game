extends CharacterBody2D

const SPEED = 150.0
const ROTATION_SPEED = 1.0

var movement = Vector2(-1, 1)

func _physics_process(delta):
	position += movement * SPEED * delta
	rotation += ROTATION_SPEED * delta

func bounce():
	movement = Vector2(movement[0]*-1, 1)

func destroy():
	print("Asteroid 2 destroyed")
	queue_free()
