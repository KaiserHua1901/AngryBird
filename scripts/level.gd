extends Node2D

const PC = preload("res://Scene/PlayerCharacter/pc.tscn")
@onready var pc_start = %PCStart

var main_menu = preload("res://Scene/main_menu.tscn")

func _ready():
	add_pc()
	SignalManager.on_pc_died.connect(add_pc)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_select"):
		get_tree().change_scene_to_packed(main_menu)
	

func add_pc():
	var pc = PC.instantiate()
	pc.position = pc_start.position
	add_child(pc)




