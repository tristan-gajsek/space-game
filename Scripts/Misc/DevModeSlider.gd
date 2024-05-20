extends VSlider

@export
var bus_name: String
var bus_index: int
@onready var game = $"../"
@onready var music = $"../AudioStreamPlayer2D"
var music_speed
var engine_speed

func _ready() -> void:
	# bus_index = AudioServer.get_bus_index(bus_name)
	# value_changed.connect(_on_value_changed)
	value = db_to_linear(1)

func _on_value_changed(value: int) -> void:
	Engine.time_scale = value
	music.pitch_scale = value
