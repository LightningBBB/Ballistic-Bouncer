extends Area2D

const SPEED: float = 10.0
var player: Node


func _process(delta: float) -> void:
	move_local_x(SPEED)



func _on_body_entered(body: Node2D) -> void:
	if body.has_meta("basic_enemy"):
		body.take_damage()
