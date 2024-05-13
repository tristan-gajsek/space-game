extends CharacterBody2D

@onready var player_anim = $AnimatedSprite2D

const SPEED = 100.0
const MOVEMENT = Vector2(0, 1)


func _physics_process(delta):
	position += MOVEMENT * SPEED * delta

func _ready():
	player_anim.play("default")

func destroy():
	queue_free()
