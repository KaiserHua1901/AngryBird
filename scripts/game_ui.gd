extends Control

@onready var game_completed = %GameCompleted
@onready var attempt_label = $MarginContainer/VBoxContainer/Attempts
@onready var level_number = $MarginContainer/VBoxContainer/LevelNumber
@onready var audio = %GameCompletedAudio
var main_menu = preload("res://Scene/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	level_number.text = "Level %s" %ScoreManager.get_level_selection()
	on_score_update(0)
	SignalManager.on_score_update.connect(on_score_update)
	SignalManager.on_level_complete.connect(on_level_complete)
 	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("menu") == true:
		get_tree().change_scene_to_packed(main_menu)


func on_score_update(attempt:int) -> void:
	attempt_label.text = "Attempt %s" %attempt


func on_level_complete() -> void:
	game_completed.visible = true
	audio.playing = true

