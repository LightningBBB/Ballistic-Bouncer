extends Area2D

const SPEED: float = 20.0
var player: Node

func _process(_delta: float) -> void:
	# Moves the bullet in the direction it's facing
	move_local_x(SPEED)

func _on_body_entered(body: Node2D) -> void:
	# Tells the enemy to take damage
	if body.has_meta("basic_enemy"):
		body.take_damage()
