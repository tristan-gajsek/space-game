extends Node2D

const SPEED = 1.0
const MOVEMENT = Vector2(0, 1)

func _process(delta):
	position += MOVEMENT * SPEED * delta
