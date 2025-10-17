extends CharacterBody2D

@export var speed = 400
@export var gravity = 980
@export var jump_force = 600
@export var max_jumps = 2
@export var jump_check_interval = 1.0

var remaining_jumps = 2
var jump_timer = 0.0
var player: Node = null


# Identify Player
func _ready():
	for node in get_tree().get_nodes_in_group("Player"):
		player = node

# Die / Take Damage
func take_damage():
	Input.start_joy_vibration(0, 1, 1, 0.15)
	queue_free()
	Global.experience += 10


func _physics_process(delta):
	if player == null:
		return
	
	# Chase the player
	var direction = player.global_position.x - global_position.x
	if direction < 0:
		direction = -1
	else:
		direction = 1
	
	velocity.x = speed * direction
	
	# Gravity and Jumps Reset
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		remaining_jumps = max_jumps
	
	# Jump Mechanics
	jump_timer += delta
	if jump_timer >= jump_check_interval:
		jump_timer = 0.0
		# Atempt First Jump
		if is_on_floor() and randf() < 0.5:
			velocity.y = -jump_force
			remaining_jumps -= 1
		# Atempt Second Jump
		elif not is_on_floor() and remaining_jumps > 0 and randf() < 0.80:
			velocity.y = -jump_force
			remaining_jumps -= 1
	
	move_and_slide()


# Attack
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		body._on_area_2d_body_entered(self)
		Input.start_joy_vibration(0, 1, 1, 0.25)
		queue_free()
