extends CharacterBody2D

enum {IDLE,WALK,ATTACK}
var state = IDLE
const SPEED = 40
var dir = 1
@onready var anim = $Anim
@onready var ray = $Ray2D
var gravidade = 2000
func _physics_process(delta):
	anim.current_animation = "Default"
	if not is_on_floor():
		velocity.y += gravidade * delta
	velocity.x = SPEED * dir
	if ray.is_colliding():
		dir *= -1
		if dir < 0:
			velocity.x = -SPEED
		elif dir > 0:
			velocity.x = SPEED
	if velocity.x < 0:
		$Sprite.flip_h = false
		ray.target_position.x = -5
	elif velocity.x > 0:
		$Sprite.flip_h = true
		ray.target_position.x = 15
	move_and_slide()




