extends Control

const WIDTH = 960
const HEIGHT = 540
@onready var star = preload("res://Scenes/Background/star.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	populate_background()

func _process(_delta):
	if Input.is_action_just_pressed("Skip"):
		get_tree().change_scene_to_file("res://Scenes/Menus/level_select_menu.tscn")

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
