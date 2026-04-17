extends StaticBody2D

@export var speed:=300

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	get_input_movement(_delta)

#moving the padel
func get_input_movement(delta:float)->void:
	var directionX = Input.get_axis("Left", "Right")
	position.x += directionX * speed * delta
