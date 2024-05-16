extends Area2D

func _on_body_entered(body):
	if body.name == "Asteroid2" or body.name == "Asteroid2Right":
		body.bounce()
