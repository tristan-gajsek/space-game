extends CharacterBody2D

@onready var laser_1 = $"Laser 1"
@onready var laser_2 = $"Laser 2"

@onready var player_anim = $AnimatedSprite2D

# Basic movement
func _physics_process(_delta):
	position.x = get_global_mouse_position().x

func _process(_delta):
	pass

# Idle animation upon entering the scene
func _ready():
	player_anim.play("idle")

