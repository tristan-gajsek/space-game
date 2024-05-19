extends CharacterBody2D

@onready var player_anim = $AnimatedSprite2D

func _process(_delta):
	pass

# Idle animation upon entering the scene
func _ready():
	player_anim.play("idle")
