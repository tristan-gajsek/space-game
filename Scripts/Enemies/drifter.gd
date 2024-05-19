extends CharacterBody2D

@onready var enemy_anim = $AnimatedSprite2D
@onready var l = $BackL
@onready var r = $BackR
@onready var m = $BackM
@onready var face = $Face

const MOVEMENT = Vector2(0, 1)

var speed = 50.0

func _physics_process(delta):
	position += MOVEMENT * speed * delta

func _ready():
	enemy_anim.play("default")
	await get_tree().create_timer(4).timeout
	wake()

func destroy():
	print("Drifter destroyed")
	queue_free()

func wake():
	AudioPlayer.drift()
	enemy_anim.play("drift")
	speed = speed * 3
	l.show()
	r.show()
	m.show()
	face.show()
