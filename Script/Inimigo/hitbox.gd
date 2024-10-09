extends Area2D



func _on_body_entered(body):
	if body is Player:
		body.vida -= 50
		if body.vida <= 0:
			get_tree().change_scene_to_file("res://Cenas/Main/defeat.tscn")
