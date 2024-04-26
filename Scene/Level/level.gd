extends Node2D

const PC = preload("res://Scene/PlayerCharacter/pc.tscn")
@onready var pc_start = %PCStart


func _ready():
	add_pc()
	SignalManager.on_pc_died.connect(add_pc)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_pc():
	var pc = PC.instantiate()
	add_child(pc)
	pc.position = pc_start.position


