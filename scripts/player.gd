extends CharacterBody2D

@export var speed: float = 600
@export var gravity: float = 980
@export var jump_force: float = 600
@export var bulletscene: PackedScene
@export var maxjumps: int = 2

var remainingjumps: int = 2

func _physics_process(delta: float) -> void:
	# Left and right movement input
	var horizontal_direction := Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction

	# Gravity and jump reset
	if is_on_floor():
		velocity.y = 0
		remainingjumps = maxjumps
	else:
		velocity.y += gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and remainingjumps > 0:
		velocity.y = -jump_force
		remainingjumps -= 1
		print("Jumped, remaining jumps:", remainingjumps)

	# Ranged attack
	if Input.is_action_just_pressed("ranged") and bulletscene:
		var bullet = bulletscene.instantiate()
		bullet.rotation = $Aim_Indicator.rotation
		bullet.position = global_position
		bullet.player = self
		add_sibling(bullet)
		Input.start_joy_vibration(0, 1, 1, 0.1)

	# Analog stick input for movement and aim
	var stick_input := Vector2(Input.get_joy_axis(0, JOY_AXIS_LEFT_X),
		Input.get_joy_axis(0, JOY_AXIS_LEFT_Y))

	if stick_input.length() > 0.1:
		$Aim_Indicator.visible = true
		$Aim_Indicator.rotation = round(stick_input.angle() / (PI / 4)) * (PI / 4)
	else:
		$Aim_Indicator.visible = false

	move_and_slide()

# Enemy collision
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("basic_enemy"):
		Global.player_health -= 1
		print("Hit by enemy! Health:", Global.player_health)
	if Global.player_health == 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
