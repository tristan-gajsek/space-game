extends Control


func _on_play_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/Areas/space.tscn")


func _on_options_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menus/options_menu.tscn")


func _on_quit_btn_pressed():
	get_tree().quit()
