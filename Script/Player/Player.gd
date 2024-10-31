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
@onready var anim = $Anim
@export_category("Canvas")
@export var lifebar:ProgressBar
@export var labelBar:Label
func Barra():
	lifebar.value = vida
	lifebar.max_value = MAX_VIDA
	labelBar.text = str(vida,"/",MAX_VIDA)
func _physics_process(delta):
	Barra()
	velocity.x = Input.get_axis("A","D") *  vel
	velocity.y += gravity * delta
	atirar_coco()
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
	if velocity.x == 0 and Input.is_action_just_pressed("ui_accept"):
		current_x = PARADO
		current_y = PULANDO
		anim.play("Idle")
func Floor():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		current_y = PULANDO
		velocity.y = jump
func Jump():
	if is_on_floor():
		current_y = NO_CHAO

func _on_hurtbox_body_entered(body):
	if body.is_in_group("Enemies"):
		body.vida -= 20

func atirar_coco():
	var shot_true = true
	var bullet = preload("res://Cenas/Main/bullet.tscn")
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and shot_true: 
		anim.play("Attack")
		$Colision_animator.play("Attack")
		await anim.animation_finished
		if anim.animation == "Attack" and anim.frame == 3 and velocity.x == 0:
			anim.play("Idle")
			$Colision_animator.play("Normal")
		elif anim.animation == "Attack" and anim.frame == 3 and velocity.x != 0:
			anim.play("Walk")
			$Colision_animator.play("Normal")
		var bala = bullet.instantiate() # criando a instância da bala
		bala.rotation = rotation #definindo a rotação da bala
		bala.global_position = $Onde_Atirar/Marker2D.global_position #posição inicial da bala
		get_parent().add_child(bala) #adicionando a bala na cena
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and shot_true: 
		shot_true = false #impedindo o jogador de atirar até o tempo de recarga acabar
		await get_tree().create_timer(1).timeout #tempo de recarga
		shot_true = true #permitindo o jogador atirar



