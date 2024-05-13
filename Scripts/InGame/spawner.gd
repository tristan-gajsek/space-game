extends Node2D

var construct = preload("res://Scenes/Enemies/construct.tscn")

func _ready():
	pass


func _process(delta):
	spawn(construct.instantiate())
	pass

func spawn(enemy):
	add_child(enemy)
