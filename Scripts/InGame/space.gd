extends Node

@onready var player_anim = $Player/AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player_anim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
