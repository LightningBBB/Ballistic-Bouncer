extends Node2D

const spawn_interval: int = 3
const initial_spawn_enemys: int = 3

var spawn_position: Array = []
var spawn_nodes: Array = []

@export var enemy_spawn_nodes: Node
@export var spawn_timer: Timer
@export var enemy_scene: PackedScene


func _ready() -> void:
	spawn_nodes = enemy_spawn_nodes.get_children()
	
	for x in spawn_nodes:
		spawn_position.append(x.global_position)
	
	for x in range(initial_spawn_enemys):
		print(x)
		var new_enemy = enemy_scene.instantiate()
		var pos_index = randi_range(1, spawn_position.size() - 1)
		var spawn_pos = spawn_position[pos_index]
		add_child(new_enemy)
		
		new_enemy.global_position = spawn_pos
	
	spawn_timer.wait_time = spawn_interval
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	var new_enemy = enemy_scene.instantiate()
	var pos_index = randi_range(1, spawn_position.size() - 1)
	var spawn_pos = spawn_position[pos_index]
	add_child(new_enemy)
	
	new_enemy.global_position = spawn_pos
