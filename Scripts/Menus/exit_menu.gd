extends Control

@onready var space = $"../"

func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")

func _on_resume_button_pressed():
	space.game_paused()
