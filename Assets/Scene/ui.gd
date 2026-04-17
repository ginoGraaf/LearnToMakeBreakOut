extends Control

static var image:Texture=load("res://Sprite/break assets/Misc/sp_ball.png")
var score:=0


func UpdateScore(addScore:int)->void:
	score+=addScore
	$ScoreContainer/ScoreLabel.text="Score: "+str(score)

func LoseLife(life:int)->void:

	#remove all childeren
	for child in $LifeContainer/HBoxContainer.get_children():
		child.queue_free()
	
	#create new childeren and set health
	for i in life:
		var text_rect=TextureRect.new()
		text_rect.texture=image
		text_rect.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT
		text_rect.expand_mode=TextureRect.EXPAND_FIT_WIDTH
		$LifeContainer/HBoxContainer.add_child(text_rect)
