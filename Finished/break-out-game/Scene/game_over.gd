extends Control

#show the score
func _ready() -> void:
	$"MarginContainer/VBoxContainer/Final Score".text="Your Final Score: "+str(GlobalUI.score)

func _process(_delta: float) -> void:
	_input_get_key()
	
func _input_get_key()->void:
	if Input.is_action_just_pressed("StartPlaying"):
		get_tree().change_scene_to_file("res://Scene/game.tscn")
