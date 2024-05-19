extends CharacterBody2D

@onready var enemy_anim = $AnimatedSprite2D
const VALID_HIT_AREA = preload("res://Scenes/Misc/valid_hit_area.tscn")

const SPEED = 100.0
const MOVEMENT = Vector2(0, 1)

func _physics_process(delta):
	position += MOVEMENT * SPEED * delta

func _ready():
	enemy_anim.play("default")

func destroy():
	print("Construct destroyed")
	queue_free()

func _on_tree_exited():
	# TODO --- Detect if the hit is well timed
	pass
