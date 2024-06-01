extends Node

const WIDTH = 960
const HEIGHT = 540

@onready var hud_anim = $HUD
@onready var victory_screen = $victory

# Game over variables
@onready var game_over_screen = $game_over
var over = false

# Pause menu variables
@onready var pause_menu = $PauseMenu
var paused = false
var music_paused_at

# var music_speed = 1
# var engine_speed = 1

@onready var spawner_1 = $Spawner1
@onready var spawner_2 = $Spawner2
@onready var spawner_3 = $Spawner3
@onready var spawner_4 = $Spawner4
@onready var spawner_5 = $Spawner5

@onready var construct = preload("res://Scenes/Enemies/construct.tscn")
@onready var drifter = preload("res://Scenes/Enemies/drifter.tscn")
@onready var asteroid = preload("res://Scenes/Enemies/asteroid.tscn")
@onready var asteroid_2 = preload("res://Scenes/Enemies/asteroid_2.tscn")
@onready var asteroid_2_r = preload("res://Scenes/Enemies/asteroid_2_right.tscn")
@onready var star = preload("res://Scenes/Background/star.tscn")
@onready var planet_fiery = preload("res://Scenes/Background/Planet/fiery.tscn")
@onready var planet_home = preload("res://Scenes/Background/Planet/home.tscn")
@onready var planet_shattered = preload("res://Scenes/Background/Planet/shattered.tscn")
@onready var planet_sandy = preload("res://Scenes/Background/Planet/sandy.tscn")
@onready var black_hole = preload("res://Scenes/Background/Planet/black_hole.tscn")
@onready var health_kit = preload("res://Scenes/Misc/health_kit.tscn")

@onready var audio_player = $AudioStreamPlayer2D
@onready var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	populate_background()
	hud_anim.play("3hp")
	# spawn_alt()
	spawn()
	# Engine.time_scale = 1
	# audio_player.pitch_scale = 1
	
func _on_player_hp_at_1():
	hud_anim.play("1hp")

func _on_player_hp_at_2():
	hud_anim.play("2hp")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		game_paused()

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
	
	# Add planets
	for i in range(5):
		var planet
		match i:
			0: planet = planet_fiery.instantiate()
			1: planet = planet_home.instantiate()
			2: planet = planet_shattered.instantiate()
			3: planet = planet_sandy.instantiate()
			_: planet = black_hole.instantiate()
		
		var planet_size: Vector2
		if i == 4:
			planet_size = Vector2(50, 50)
		else:
			planet_size = planet.get_node("Sprite2D").get_rect().size
			
		planet.position = Vector2(
			rng.randi_range(0 + planet_size.x, size.x - planet_size.x),
			rng.randi_range(0 + planet_size.y, size.y - planet_size.y - WIDTH / 4),
		)
		
		add_child(planet)

func level_complete():
	if !over:
		over = true
		audio_player.stop()
		victory_screen.show()

func game_paused():
	if paused:
		pause_menu.hide()
		get_tree().paused = false
		Engine.time_scale = 1
		audio_player.play()
		audio_player.seek(music_paused_at)
	else:
		pause_menu.show()
		get_tree().paused = true
		Engine.time_scale = 0
		music_paused_at= audio_player.get_playback_position( )
		audio_player.stop()
	
	paused = !paused

func _on_player_death():
	over = true
	audio_player.stop()
	game_over_screen.show()
	# get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")

func _on_quit():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")

func spawn_alt():
	var spawners = [spawner_1, spawner_2, spawner_3, spawner_4, spawner_5]
	var enemies = [asteroid, asteroid_2, asteroid_2_r, construct, drifter]
	
	var spawner_seq = [0, 2, 4, 1, 3, 0, 2, 4, 1, 3, 0, 4, 0, 4, 0, 4, 2, 1, 
	3, 0, 4, 2, 2, 2, 1, 1, 3, 3, 2, 1, 0, 2, 3, 4, 1, 3, 2, 1, 2, 3, 2, 2, 2, 
	0, 0, 0, 4, 4, 4, 2, 3, 1, 4, 0, 2, 0, 4, 0, 4, 0, 4, 0, 4, 2, 2, 2, 4, 3, 
	2, 2, 2, 0, 1, 2, 2, 2, 1, 2, 3, 0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 0, 1, 2, 3, 
	4, 2, 2, 2, 1, 2, 3, 0, 2, 2, 4, 2, 0, 1, 2, 3, 4, 0, 1, 2, 2, 3, 4, 2, 0, 
	1, 0, 0, 1, 3, 4, 1, 3, 0, 4, 3, 4, 3, 0, 4, 1, 3, 2, 2, 4, 0, 2, 2, 2, 2, 
	1, 2, 3, 2, 0, 1, 2, 3, 4, 4, 3, 2, 2, 1, 0, 0, 1, 2, 3, 0, 4, 1, 3, 2, 1, 
	3, 0, 4, 1, 2, 0, 3, 0, 4, 1, 3, 2, 1, 3, 1, 3, 1, 2, 4, 2, 3, 1, 1, 2, 2, 
	2, 3, 3, 3, 2, 2, 2, 1, 1, 3, 2, 2, 0, 1, 2, 4, 3, 2, 1, 2, 3, 1, 2, 3, 0, 
	1, 2, 4, 3, 2, 0, 2, 4, 1, 3]
	
	var enemy_seq = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
	1, 2, 0, 1, 2, 0, 1, 1, 2, 2, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 0, 3, 3, 
	3, 3, 0, 0, 3, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 1, 2, 4, 1, 2, 4, 3, 
	3, 3, 4, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 2, 2, 4, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 3, 3, 3, 3, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 1, 1, 1, 2, 2, 2, 1, 1, 1, 2, 2, 
	2, 1, 1, 1, 0, 0, 0, 0, 0]
	
	var timer_seq = [1, 1, 1, 0, 1, 1, 1, 1, 0, 1.5, 0, 0.3, 0, 0.3, 0, 0.3, 0, 
	0.4, 1, 0, 1, 0, 1.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 0.5, 0.5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2.8, 1, 1, 1, 
	1, 1, 1, 1, 1.1, 0.5, 0.5, 1, 1, 1, 0.5, 0.5, 1, 1, 4, 0, 0, 0.5, 0, 0, 0.5, 
	0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 5.5, 0, 0, 0.5, 0, 0, 0,5, 0, 
	0, 0, 0, 0.5, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0, 3.5, 0.3, 0.3, 1.7, 0.2, 0, 
	0.8, 0.2, 0, 0.8, 1, 1, 0.5, 0.5, 0.5, 1, 1, 1, 0, 4, 2, 0, 2, 2, 0, 2, 1, 1,
	1, 1, 5, 1, 1, 1, 1, 0.5, 1.5, 2, 0.5, 1.5, 2, 0.5, 6, 0.5, 0.5, 1, 0, 0.2, 
	0, 0.2, 0.2, 0, 0.2, 0, 1, 0.5, 0, 0.5, 1, 0, 0.2, 0, 0.2, 0.2, 0, 0.2, 0, 
	0.7, 0, 1, 3, 0, 2, 0.5, 1, 0.3, 0.3, 1.4, 1, 0.5, 0.8, 0.3, 0.3, 1.6, 5, 1, 
	1, 1, 2, 0, 0, 0.5, 0, 0, 0.5, 0, 0, 0.5, 0, 0, 0.5, 0, 0, 0.5, 0, 0, 0.5, 0,
	0, 0.5, 0.2]
	
	audio_player.play()
	
	for i in range(spawner_seq.size()):
		if over:
			return
		spawners[spawner_seq[i]].add_child(enemies[enemy_seq[i]].instantiate())
		if timer_seq[i] != 0:
			await get_tree().create_timer(timer_seq[i]).timeout
	
	level_complete()

func spawn():
	audio_player.play()
	
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
	
	# spawner_1.add_child(health_kit.instantiate())
	
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
	
	# spawner_5.add_child(health_kit.instantiate())
	
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
	await get_tree().create_timer(5.5).timeout
	
	# spawner_1.add_child(health_kit.instantiate())
	
	#SCREAM 2
	spawner_3.add_child(asteroid_2.instantiate())
	spawner_3.add_child(asteroid_2_r.instantiate())
	spawner_3.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_2.add_child(asteroid_2.instantiate())
	spawner_4.add_child(asteroid_2_r.instantiate())
	spawner_3.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_1.add_child(asteroid_2.instantiate())
	spawner_3.add_child(asteroid_2.instantiate())
	spawner_3.add_child(asteroid_2_r.instantiate())
	spawner_5.add_child(asteroid_2_r.instantiate())
	spawner_3.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_1.add_child(asteroid.instantiate())
	spawner_2.add_child(asteroid.instantiate())
	spawner_3.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	spawner_5.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_1.add_child(asteroid_2.instantiate())
	spawner_2.add_child(asteroid_2.instantiate())
	spawner_3.add_child(asteroid_2.instantiate())
	spawner_3.add_child(asteroid_2_r.instantiate())
	spawner_4.add_child(asteroid_2_r.instantiate())
	spawner_5.add_child(asteroid_2_r.instantiate())
	spawner_3.add_child(asteroid.instantiate())
	await get_tree().create_timer(3.5).timeout
	
	# If I leave I want you with bologne
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(0.3).timeout
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(0.3).timeout
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(1.7).timeout
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(0.2).timeout
	spawner_2.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.8).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(0.2).timeout
	spawner_2.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.8).timeout
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_4.add_child(construct.instantiate())
	spawner_3.add_child(drifter.instantiate())
	await get_tree().create_timer(4).timeout
	spawner_3.add_child(drifter.instantiate())
	await get_tree().create_timer(2).timeout
	spawner_5.add_child(asteroid_2.instantiate())
	spawner_1.add_child(asteroid_2_r.instantiate())
	await get_tree().create_timer(2).timeout
	spawner_3.add_child(drifter.instantiate())
	await get_tree().create_timer(2).timeout
	spawner_3.add_child(asteroid_2.instantiate())
	spawner_3.add_child(asteroid_2_r.instantiate())
	await get_tree().create_timer(2).timeout
	spawner_3.add_child(drifter.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_3.add_child(drifter.instantiate())
	await get_tree().create_timer(5).timeout
	
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_5.add_child(construct.instantiate())
	await get_tree().create_timer(1.5).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(2).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(1.5).timeout
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(2).timeout
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_1.add_child(construct.instantiate())
	await get_tree().create_timer(6).timeout
	
	# spawner_3.add_child(health_kit.instantiate())
	
	spawner_2.add_child(asteroid_2.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_3.add_child(asteroid_2.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_4.add_child(asteroid_2.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_1.add_child(asteroid.instantiate())
	spawner_5.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.2).timeout
	spawner_2.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.2).timeout
	spawner_3.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.2).timeout
	spawner_2.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.2).timeout
	spawner_1.add_child(asteroid.instantiate())
	spawner_5.add_child(asteroid.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_2.add_child(asteroid_2_r.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_3.add_child(asteroid_2_r.instantiate())
	spawner_1.add_child(drifter.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_4.add_child(asteroid_2_r.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_1.add_child(asteroid.instantiate())
	spawner_5.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.2).timeout
	spawner_2.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.2).timeout
	spawner_3.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.2).timeout
	spawner_2.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.2).timeout
	spawner_2.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.7).timeout
	spawner_2.add_child(asteroid.instantiate())
	spawner_3.add_child(asteroid.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_5.add_child(drifter.instantiate())
	await get_tree().create_timer(3).timeout
	spawner_3.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(2).timeout
	
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(0.3).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(0.3).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(1.4).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(0.8).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(0.3).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(0.3).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(1.6).timeout
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(5).timeout
	
	spawner_2.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_4.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(1).timeout
	spawner_3.add_child(construct.instantiate())
	await get_tree().create_timer(2).timeout
	
	spawner_1.add_child(asteroid_2_r.instantiate())
	spawner_2.add_child(asteroid_2_r.instantiate())
	spawner_3.add_child(asteroid_2_r.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_5.add_child(asteroid_2.instantiate())
	spawner_4.add_child(asteroid_2.instantiate())
	spawner_3.add_child(asteroid_2.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_2.add_child(asteroid_2_r.instantiate())
	spawner_3.add_child(asteroid_2_r.instantiate())
	spawner_4.add_child(asteroid_2_r.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_2.add_child(asteroid_2.instantiate())
	spawner_3.add_child(asteroid_2.instantiate())
	spawner_4.add_child(asteroid_2.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_1.add_child(asteroid_2_r.instantiate())
	spawner_2.add_child(asteroid_2_r.instantiate())
	spawner_3.add_child(asteroid_2_r.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_5.add_child(asteroid_2.instantiate())
	spawner_4.add_child(asteroid_2.instantiate())
	spawner_3.add_child(asteroid_2.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_1.add_child(asteroid.instantiate())
	spawner_3.add_child(asteroid.instantiate())
	spawner_5.add_child(asteroid.instantiate())
	await get_tree().create_timer(0.5).timeout
	spawner_2.add_child(asteroid.instantiate())
	spawner_4.add_child(asteroid.instantiate())
	await get_tree().create_timer(2).timeout

	level_complete()
