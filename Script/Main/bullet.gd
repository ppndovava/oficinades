extends Area2D

var vel = 400 #velocidade do tiro

func _physics_process(delta):
	global_position += (Vector2.RIGHT*vel).rotated(rotation) * delta  #tiro ir para direção de sua rotação




