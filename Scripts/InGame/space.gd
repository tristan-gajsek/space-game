extends Node

@onready var spawner_1 = $Spawner1
@onready var spawner_2 = $Spawner2
@onready var spawner_3 = $Spawner3
@onready var spawner_4 = $Spawner4
@onready var spawner_5 = $Spawner5

@onready var construct = preload("res://Scenes/Enemies/construct.tscn")
@onready var asteroid = preload("res://Scenes/Enemies/asteroid.tscn")
@onready var asteroid_2 = preload("res://Scenes/Enemies/asteroid_2.tscn")
@onready var asteroid_2_r = preload("res://Scenes/Enemies/asteroid_2_right.tscn")
@onready var star = preload("res://Scenes/Background/star.tscn")

@onready var audio_player = $AudioStreamPlayer2D
@onready var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_player.play()
	
	populate_background()
	spawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func populate_background():
	# Separate the screen into a rectangular grid of sections and put stars_per_section stars into each section
	var size = get_viewport().size
	const section_count = 10
	const stars_per_section = 25
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

func spawn():
	spawner_1.add_child(asteroid.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_3.add_child(asteroid.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(asteroid.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_2.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_1.add_child(asteroid.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_3.add_child(asteroid.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(asteroid.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_2.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(1.5).timeout
	
	spawner_1.add_child(asteroid.instantiate())
	spawner_5.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.3).timeout
	spawner_1.add_child(asteroid.instantiate())
	spawner_5.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.3).timeout
	spawner_1.add_child(asteroid.instantiate())
	spawner_5.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.4).timeout
	
	spawner_3.add_child(asteroid.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_2.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_1.add_child(asteroid.instantiate())
	spawner_5.add_child(asteroid.instantiate())
	await get_tree().create_timer(1.5).timeout
	
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(2.8).timeout
	
	# Maybe you can pitch this sound, maybe you can feeeeeel it!
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(1.1).timeout
	
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(4).timeout
	
	#SCREAM
	spawner_3.add_child(asteroid_2.instantiate())
	spawner_3.add_child(asteroid_2_r.instantiate())
	spawner_3.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_2.add_child(asteroid.instantiate())
	spawner_3.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_1.add_child(asteroid.instantiate())
	spawner_2.add_child(asteroid.instantiate())
	spawner_3.add_child(asteroid.instantiate())
	spawner_5.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_1.add_child(asteroid.instantiate())
	spawner_2.add_child(asteroid.instantiate())
	spawner_3.add_child(asteroid.instantiate())
	spawner_5.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_1.add_child(asteroid.instantiate())
	spawner_2.add_child(asteroid.instantiate())
	spawner_3.add_child(asteroid.instantiate())
	spawner_5.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.5).timeout
