extends VSlider

@onready var game = $"../"
@onready var music = $"../AudioStreamPlayer2D"

@export
var music_speed: int
var engine_speed: int

func _ready() -> void:
	value = db_to_linear(1)

func _on_value_changed(value: int) -> void:
	Engine.time_scale = value
	music.pitch_scale = value
