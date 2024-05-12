extends Node

var attempt:int = 0
var hit:int = 0
var total_log:int = 0
var level_number: int = 1

func _ready():
    total_log = get_tree().get_nodes_in_group("log").size()
    level_number = ScoreManager.get_level_selection()
    SignalManager.on_attempt_made.connect(on_attempt_made)
    SignalManager.on_log_destroy.connect(on_log_destroy)


func on_attempt_made() -> void:
    attempt += 1




func on_log_destroy():
    hit += 1
    if hit == total_log:
        pass
        # Complete level, write the code later ;v