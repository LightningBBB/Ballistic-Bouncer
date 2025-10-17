extends CharacterBody2D

@export var speed = 400
@export var gravity = 980

var player: Node = null

func _ready():
	for node in get_tree().get_nodes_in_group("Player"):
		player = node

func take_damage():
	queue_free()
	Global.experience += 10

func _physics_process(delta):
	# prevent crash if player isn't found yet
	if player == null:
		return

	var direction = player.global_position.x - global_position.x
	if direction < 0:
		direction = -1
	else:
		direction = 1

	velocity.x = speed * direction

	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("player"):
		body._on_area_2d_body_entered(self)
		queue_free()
