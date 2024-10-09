extends Node2D
var shot_true = true
var bullet = preload("res://Cenas/Main/bullet.tscn")

func _physics_process(_delta):
	var mouse_pos = get_global_mouse_position() #guardando a pos do mouse
	look_at(mouse_pos) #fazendo a arma apontar para o mouse
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and shot_true: 
		var bala = bullet.instantiate() # criando a instância da bala
		bala.rotation = rotation #definindo a rotação da bala
		bala.global_position = $Marker2D.global_position #posição inicial da bala
		get_tree().get_root().add_child(bala) #adicionando a bala na cena
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and shot_true: 
		shot_true = false #impedindo o jogador de atirar até o tempo de recarga acabar
		await get_tree().create_timer(1).timeout #tempo de recarga
		shot_true = true #permitindo o jogador atirar
