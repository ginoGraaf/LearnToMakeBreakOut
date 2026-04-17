extends StaticBody2D

@export var health:=0
@export var brickTexture:Array[Texture2D] = []


func _CheckBrickDestroyed()->void:
	GlobalUI.UpdateScore(100)
	$AudioStreamPlayer2D.play()

	health-=1
	match health:
		2:
			$Sprite2D.texture=brickTexture[1]
		1:
			$Sprite2D.texture=brickTexture[2]
	if health<=0:
		$Sprite2D.visible=false
		$BrickCollider.disabled =true
		await $AudioStreamPlayer2D.finished
		queue_free()
