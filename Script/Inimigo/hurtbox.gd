extends Area2D


func _on_body_entered(body):
	if body is Player:
		body.velocity.y = body.jump
		owner.queue_free()
		Global.pontos += 1

