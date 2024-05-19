extends Control

@onready var space = $"../"
signal quit

func _on_quit_button_pressed():
	emit_signal("quit")

func _on_resume_button_pressed():
	space.game_paused()
