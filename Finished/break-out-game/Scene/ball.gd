extends CharacterBody2D

@export var speed = 400
var direction := Vector2(0, 0).normalized()
var playGame:=false

func _physics_process(delta: float) -> void:
	if playGame==false:
		_getInputMovement()
		
	# calculate the speed of the ball
	var velocity_frame = direction * speed * delta
	var collision_info = move_and_collide(velocity_frame)
	
	# screen border hit
	_hitBorderScreen()

	# Handel for all colliding and prevent tunneling
	var attempts = 4
	while collision_info and attempts > 0:
		_handleAnythingWeHit(collision_info)
		
		# Important: use the 'remainder' to complete the rest of the frame
		# We reflect the remaining movement based on the new direction
		var remainder = collision_info.get_remainder().bounce(collision_info.get_normal())
		collision_info = move_and_collide(remainder)
		attempts -= 1

func _getInputMovement()->void:
		if Input.is_action_just_pressed("StartPlaying"):
			playGame=true
			direction= Vector2(1,-1).normalized()

func _handleAnythingWeHit(collision_info: KinematicCollision2D) -> void:
	var collider = collision_info.get_collider()
	
	if collider.is_in_group("paddel"):
		# Special paddle bounce logica
		var padel_shape = collider.get_node("PadelCollider").shape
		var padel_width = padel_shape.get_rect().size.x
		var relative_x = (global_position.x - collider.global_position.x) / (padel_width / 2)
		collider.playSound()
		# Update Direction: X On base of hitting, Y Always up
		direction = Vector2(relative_x, -1).normalized()
		
	elif collider.has_method("_CheckBrickDestroyed"):
		# Brick collider Logic
		collider._CheckBrickDestroyed()
		direction = direction.bounce(collision_info.get_normal())
	else:
		# Walls or other Object
		direction = direction.bounce(collision_info.get_normal())

# when the ball hit a Border of the screen
func _hitBorderScreen() -> void:
	var screen_size = get_viewport_rect().size
	if position.x <= 0 or position.x >= screen_size.x:
		direction.x *= -1
	if position.y <= 0: # only the upper border the down border is Game Over
		direction.y *= -1

func _resetBall()->void:
	playGame=false
	direction=Vector2(0,0).normalized()
	position= Vector2(317,355)
