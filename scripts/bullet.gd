extends Area2D

const SPEED: float = 20.0
var player: Node


func _process(delta: float) -> void:
	move_local_x(SPEED)
