extends Control
@onready var label = $Label
var packed:PackedScene = preload("res://Cenas/Player/level_one.tscn")

func _ready():
	label.visible = true

func _physics_process(delta):
	if Input.is_action_just_pressed("Enter"):
		label.visible = false
		get_tree().change_scene_to_packed(packed)
