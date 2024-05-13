extends Node

@onready var spawner_1 = $Spawner1
@onready var spawner_2 = $Spawner2
@onready var spawner_3 = $Spawner3
@onready var spawner_4 = $Spawner4
@onready var spawner_5 = $Spawner5

@onready var construct = preload("res://Scenes/Enemies/construct.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport_width = get_viewport().size[0]
	var spacing = floor(viewport_width / 6)
	spawner_1.position.x = spacing
	spawner_2.position.x = spacing * 2
	spawner_3.position.x = spacing * 3
	spawner_4.position.x = spacing * 4
	spawner_5.position.x = spacing * 5
	
	spawner_1.add_child(construct.instantiate())
	spawner_2.add_child(construct.instantiate())
	spawner_3.add_child(construct.instantiate())
	spawner_4.add_child(construct.instantiate())
	spawner_5.add_child(construct.instantiate())
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
