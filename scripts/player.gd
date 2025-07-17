extends CharacterBody2D

@export var speed = 600
@export var gravity = 980
@export var jump_force = 600
@export var bulletscene: PackedScene

@export var maxjumps = 2
var remainingjumps = 2

func _physics_process(delta):
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	
	var stick_input = Vector2(
		Input.get_joy_axis(0, JOY_AXIS_LEFT_X),
		Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)
	)
	
	if  not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and remainingjumps > 0:
		velocity.y = -jump_force
		remainingjumps -= 1
		print("Jumped! Remaining jumps:", remainingjumps)
	
	move_and_slide()
	
	if is_on_floor():
		remainingjumps = maxjumps


	
	print(velocity)	


	
	if Input.is_action_just_pressed("ranged"):
		var bullet = bulletscene.instantiate()
		bullet.rotation = $Aim_Indicator.rotation
		bullet.position = global_position
		bullet.player = self
		
		add_sibling(bullet)

	if stick_input.length() > 0.1:
		$Aim_Indicator.visible = true
		$Aim_Indicator.rotation = stick_input.angle()
	else:
		$Aim_Indicator.visible = false
