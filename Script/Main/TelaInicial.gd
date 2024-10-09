extends Control

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Cenas/Player/level_one.tscn")


func _on_creditos_pressed():
	pass # Replace with function body.



func _on_sair_pressed():
	get_tree().quit()
