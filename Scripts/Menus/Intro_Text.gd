extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_property(self, "visible_ratio", 1, 8.0)
	tween.set_trans(Tween.TRANS_CUBIC)
	await get_tree().create_timer(10).timeout
	get_tree().change_scene_to_file("res://Scenes/Areas/space.tscn")
