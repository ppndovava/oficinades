class_name Player extends CharacterBody2D
@export_category("Movimento")
@export var vel:float
@export var gravity:float
@export var jump:float


enum{PARADO,ANDANDO}
enum{NO_CHAO,PULANDO}
var current_x = PARADO
var current_y = NO_CHAO
var vida = 250
var MAX_VIDA = 250
var jump_limit = 0
@onready var anim = $Anim
@export_category("Canvas")
@export var lifebar:ProgressBar
@export var labelBar:Label
var no_jump = false
func Barra():
	lifebar.value = vida
	lifebar.max_value = MAX_VIDA
	labelBar.text = str(vida,"/",MAX_VIDA)
func _physics_process(delta):
	print(jump_limit)
	Barra()
	if jump_limit >= 1:
		no_jump = true
	else:
		no_jump = false
	if no_jump:
		jump_limit = 0
	if vida <= 0:
		get_tree().reload_current_scene()
	velocity.x = Input.get_axis("A","D") *  vel
	velocity.y += gravity * delta
	if velocity.x < 0:
		anim.flip_h = true
	elif  velocity.x > 0:
		anim.flip_h = false
	match current_x:
		PARADO:
			Stopped()
		ANDANDO:
			Walking()
	match current_y:
		NO_CHAO:
			Floor()
		PULANDO:
			Jump()
	move_and_slide()
func Stopped():
	if velocity.x != 0:
		current_x = ANDANDO
		current_y = NO_CHAO
		anim.play("Walk")
	if velocity.x != 0 and Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump
		current_x = ANDANDO
		current_y = PULANDO
		anim.play("Walk")
func Walking():
	if velocity.x == 0:
		current_x = PARADO
		current_y = NO_CHAO
		anim.play("Idle")
	if velocity.x == 0 and Input.is_action_just_pressed("ui_accept") and !no_jump:
		current_x = PARADO
		current_y = PULANDO
		anim.play("Idle")
func Floor():
	if Input.is_action_just_pressed("ui_accept") and !no_jump:
		current_y = PULANDO
		velocity.y = jump
		jump_limit += 1
func Jump():
	if is_on_floor():
		current_y = NO_CHAO



func _on_hurtbox_body_entered(body):
	if body.is_in_group("Enemies"):
		body.vida -= 20


func _on_timer_timeout():
	if vida <= 100:
		vida += 100
