extends Node2D
var life:=3

func _on_loss_ball_body_entered(body: Node2D) -> void:
	print("EnterBall")
	if body.has_method("_resetBall"):
		body._resetBall()
		life-=1
		GlobalUI.LoseLife(life)
		if life <=0:
			get_tree().call_deferred("change_scene_to_file","res://Scene/game_over.tscn")


func _on_audio_stream_player_2d_finished() -> void:
	$"../BG Music".play()
