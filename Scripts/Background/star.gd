extends Node2D

@onready var anim = $AnimatedSprite2D
var rng = RandomNumberGenerator.new()

func _process(_delta):
	if not rng.randi() % 50:
		anim.play()

func _ready():
	match rng.randi() % 100:
		0: anim.animation = "green"
		1, 2, 3: anim.animation = "blue"
		4, 5, 6: anim.animation = "red"
		7, 8, 9: anim.animation = "orange"
		_: anim.animation = "white"

# Set the position to a random position within the bounds of a rectangle
func set_random_position(x_min, y_min, x_max, y_max):
	position = Vector2(
		rng.randi_range(x_min, x_max + 1),
		rng.randi_range(y_min, y_max + 1)
	)

func destroy():
	print("Star destroyed")
	queue_free()
