extends Control

@onready var animated_sprite_2d = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_btn_pressed():
	AudioPlayer.button()
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")
