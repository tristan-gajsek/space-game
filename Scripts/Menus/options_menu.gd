extends Control


func _on_back_pressed():
	AudioPlayer.button()
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
