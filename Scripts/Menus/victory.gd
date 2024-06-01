extends Control

@onready var anim = $"AnimationPlayer"
signal quit

func _on_quit_button_pressed():
	emit_signal("quit")

func _ready():
	anim.play("victory_anim")
