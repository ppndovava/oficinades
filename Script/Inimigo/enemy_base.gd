class_name Enemy_Base extends CharacterBody2D
var gravity = 2500
enum{PARADO,ATACANDO}
var state = PARADO
@onready var anim:AnimationPlayer = get_node("Anim")
@onready var texture:Sprite2D = get_node("Texture")
@onready var tempo:Timer = get_node("Tempo")
@export var inimigo:PackedScene
var vida = 120
var no_ar = true
func _ready():
	tempo.start()
func _physics_process(delta):
	print(vida)
	if no_ar:
		velocity.y += gravity * delta
		move_and_slide()
	match state:
		PARADO:
			Stopped()
		ATACANDO:
			Atacando()
	if is_on_floor():
		no_ar = false
		velocity = Vector2.ZERO
func Stopped():
	if anim.current_animation == "Attack":
		state = ATACANDO
		anim.play("Attack")
func Atacando():
	if anim.current_animation == "PARADO":
		state = PARADO
		anim.play("Idle")

func Animacao_ataque():
	if texture.frame == 5:
		var enemy = inimigo.instantiate()
		enemy.global_position = $Position.global_position
		enemy.scale = Vector2(1.8,1.8)
		get_parent().add_child(enemy)
		enemy.add_to_group("Enemies")
		enemy.name = "Inimigo"
func _on_tempo_timeout():
	if anim.current_animation == "Idle":
		anim.play("Attack")
		$Change.start()


func _on_change_timeout():
	if anim.current_animation == "Attack":
		Animacao_ataque()
		anim.play("Idle")
		tempo.start()
