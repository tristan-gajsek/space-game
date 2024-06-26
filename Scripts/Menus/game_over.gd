extends Control

@onready var anim = $"AnimationPlayer"
signal quit

func _on_quit_button_pressed():
	emit_signal("quit")

func _on_retry_button_pressed():
	get_tree().reload_current_scene()

func _ready():
	anim.play("game_over_anim")
