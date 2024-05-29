extends Control

const WIDTH = 960
const HEIGHT = 540
@onready var star = preload("res://Scenes/Background/star.tscn")

@onready var lava_lamp_anim = $AnimatedSprite2D

func _ready():
	lava_lamp_anim.play()
	populate_background()

func _on_back_btn_pressed():
	AudioPlayer.button()
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")


func _on_level_1_btn_pressed():
	AudioPlayer.button()
	get_tree().change_scene_to_file("res://Scenes/Areas/space.tscn")

func populate_background():
	# Separate the screen into a rectangular grid of sections and put stars_per_section stars into each section
	var size = Vector2(WIDTH, HEIGHT)
	const section_count = 10
	const stars_per_section = 10
	var section_width = int(size.x / section_count)
	var section_height = int(size.y / section_count)
	
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
