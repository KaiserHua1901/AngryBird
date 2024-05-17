extends Node

var level_selection:int = 1: 
    set = set_level_selection, get = get_level_selection

const DEFAULT_SCORE:int = 1000
const SCORE_PATH = "user://savefile.json"

var level_score:Dictionary = {}


func _ready():
    load_file()

func Check_and_Add(level:String):
    if level_score.has(level) == false:
        level_score[level] = DEFAULT_SCORE

func set_score_for_level(score:int, level:String):
    Check_and_Add(level)
    if level_score[level] > score:
        level_score[level] = score
    save_file()

func get_highest_score(level:String):
    Check_and_Add(level)
    return level_score[level]

func set_level_selection(value:int):
    level_selection = value

func get_level_selection():
    return level_selection


func save_file():
    var file = FileAccess.open(SCORE_PATH, FileAccess.WRITE)
    var score_json_str = JSON.stringify(level_score)
    file.store_string(score_json_str)

func load_file():
    var file = FileAccess.open(SCORE_PATH, FileAccess.READ)
    if file == null:
        save_file()
    else:
        var data = file.get_as_text()
        level_score = JSON.parse_string(data) 

