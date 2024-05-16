extends CharacterBody2D

const LEFT_BORDER = 150
const RIGHT_BORDER = 810

@onready var laser_1 = $"Laser 1"
@onready var laser_2 = $"Laser 2"

@onready var player_anim = $AnimatedSprite2D

# Basic movement
func _physics_process(_delta):
	var mouse_pos = get_global_mouse_position().x
	if mouse_pos > LEFT_BORDER and mouse_pos < RIGHT_BORDER:
		position.x = get_global_mouse_position().x
	elif abs(mouse_pos - LEFT_BORDER) < abs(mouse_pos - RIGHT_BORDER):
		position.x = LEFT_BORDER
	else:
		position.x = RIGHT_BORDER
		

func _process(_delta):
	pass

# Idle animation upon entering the scene
func _ready():
	player_anim.play("idle")

