extends Node

@onready var spawner_1 = $Spawner1
@onready var spawner_2 = $Spawner2
@onready var spawner_3 = $Spawner3
@onready var spawner_4 = $Spawner4
@onready var spawner_5 = $Spawner5

@onready var construct = preload("res://Scenes/Enemies/construct.tscn")
@onready var asteroid = preload("res://Scenes/Enemies/asteroid.tscn")

@onready var audio_player = $AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	audio_player.play()
	
	spawn()
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

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
