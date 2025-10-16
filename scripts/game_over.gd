extends Control


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_tut.tscn")
	Global.player_health = 3


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
