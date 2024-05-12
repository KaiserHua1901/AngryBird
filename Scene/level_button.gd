extends TextureButton


const HOVER_SCALE: Vector2 = Vector2(1.1, 1.1)
const DEFAULT_SCALE: Vector2 = Vector2(1.0,1.0)


@export var Level_Number: int = 1


@onready var level_Label = %LevelLabel
@onready var score_label = %ScoreLabel

var level_scene: PackedScene


func _ready():
    level_scene = load("res://Scene/Level/level%s.tscn" %Level_Number)
    level_Label.text = str(Level_Number)

func _on_pressed():
    ScoreManager.set_level_selection(Level_Number)
    get_tree().change_scene_to_packed(level_scene)



func _on_mouse_exited():
    scale = DEFAULT_SCALE


func _on_mouse_entered():
    scale = HOVER_SCALE





