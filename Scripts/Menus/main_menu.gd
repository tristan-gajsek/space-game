extends Control

const WIDTH = 960
const HEIGHT = 540

@onready var star = preload("res://Scenes/Background/star.tscn")

func _ready():
	populate_background()

func _on_play_btn_pressed():
	AudioPlayer.button()
	get_tree().change_scene_to_file("res://Scenes/Menus/lore_menu.tscn")


func _on_options_btn_pressed():
	AudioPlayer.button()
	get_tree().change_scene_to_file("res://Scenes/Menus/options_menu.tscn")


func _on_info_btn_pressed():
	AudioPlayer.button()
	get_tree().change_scene_to_file("res://Scenes/Menus/information_menu.tscn")

func _on_quit_btn_pressed():
	AudioPlayer.button()
	get_tree().quit()
	
func populate_background():
	# Separate the screen into a rectangular grid of sections and put stars_per_section stars into each section
	var win_size = Vector2(WIDTH, HEIGHT)
	const section_count = 10
	const stars_per_section = 5
	var section_width = int(win_size.x / section_count)
	var section_height = int(win_size.y / section_count)
	
	for x in section_count:
		for y in section_count:
			for i in stars_per_section:
				var star_instance = star.instantiate()
				star_instance.set_random_position(
					x * section_width,
					y * section_height,
					x * section_width + section_width,
					y * section_height + section_height
				)
				add_child(star_instance)
