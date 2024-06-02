extends Area2D

signal player_damage

func _on_body_entered(body):
	body.destroy()
	if body.is_in_group("Enemy"):
		emit_signal("player_damage")
