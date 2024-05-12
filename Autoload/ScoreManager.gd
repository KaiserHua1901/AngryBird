extends Node

var level_selection:int = 1: 
    set = set_level_selection, get = get_level_selection

func set_level_selection(value:int):
    level_selection = value

func get_level_selection():
    return level_selection

func _ready():
    pass