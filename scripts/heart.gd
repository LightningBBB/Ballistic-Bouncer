extends Node2D

@onready var heart_one = $"Heart 1"
@onready var heart_two = $"Heart 2"
@onready var heart_three = $"Heart 3"

var experience: int = 0

func _process(_delta: float) -> void:
	# Process to control how many hearts are displayed
	if Global.player_health == 3:
		pass
	elif Global.player_health == 2:
		heart_three.self_modulate = Color(0, 0, 0, 0.5)
	elif Global.player_health == 1:
		heart_three.self_modulate = Color(0, 0, 0, 0.5)
		heart_two.self_modulate = Color(0, 0, 0, 0.5)
