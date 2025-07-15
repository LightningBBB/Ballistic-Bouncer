extends CharacterBody2D

@export var speed = 600
@export var gravity = 30
@export var jump_force = 800

func _physics_process(delta):
	# Existing movement code
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction

	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 500:
			velocity.y = 500

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force

	move_and_slide()
	print(velocity)

	# Rotate Aim_Indicator with joystick input and toggle visibility - ChatGPT
	var stick_input = Vector2(
		Input.get_joy_axis(0, JOY_AXIS_RIGHT_X),
		Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)  # Y-axis NOT inverted
	)

	if stick_input.length() > 0.1:
		$Aim_Indicator.visible = true
		$Aim_Indicator.rotation = stick_input.angle()
	else:
		$Aim_Indicator.visible = false
