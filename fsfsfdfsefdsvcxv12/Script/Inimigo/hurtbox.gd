extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		body.velocity.y = body.jump
		owner.queue_free()
		get_tree().change_scene_to_file("res://Cenas/Main/Victory.tscn")
