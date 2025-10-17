extends Control

# Start Button
func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_tut.tscn")
	Global.player_health = 3

# Quit Game Button
func _on_quit_pressed() -> void:
	get_tree().quit()
