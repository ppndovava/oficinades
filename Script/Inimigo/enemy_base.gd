extends CharacterBody2D
var gravity = 2500
enum{IDLE,ATTACK}
var state = IDLE
@onready var anim:AnimationPlayer = $Anim
@onready var texture:Sprite2D = $Texture
@onready var tempo:Timer = $Tempo
@export var inimigo:PackedScene
func _ready():
	tempo.start()
func _physics_process(delta):
	velocity.y += gravity * delta
	match state:
		IDLE:
			Stopped()
		ATTACK:
			Atacando()
	move_and_slide()
func Stopped():
	if anim.current_animation == "Attack":
		state = ATTACK
		anim.play("Attack")
func Atacando():
	if anim.current_animation == "Idle":
		state = IDLE
		anim.play("Idle")

func Animacao_ataque():
	if texture.frame == 5:
		var enemy = inimigo.instantiate()
		enemy.global_position = $Position.global_position
		enemy.scale = Vector2(1.8,1.8)
		get_parent().add_child(enemy)
		enemy.add_to_group("Enemies")

func _on_tempo_timeout():
	if anim.current_animation == "Idle":
		anim.play("Attack")
		$Change.start()


func _on_change_timeout():
	if anim.current_animation == "Attack":
		Animacao_ataque()
		anim.play("Idle")
		tempo.start()
