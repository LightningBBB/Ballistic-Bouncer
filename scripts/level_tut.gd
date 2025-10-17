extends Node2D

const spawn_interval: int = 3
const initial_spawn_enemys: int = 3

var spawn_position: Array = []
var spawn_nodes: Array = []
var player: Node = null

@export var enemy_spawn_nodes: Node
@export var spawn_timer: Timer
@export var enemy_scene: PackedScene


func _ready() -> void:
	for node in get_tree().get_nodes_in_group("Player"):
		player = node
	
	spawn_nodes = enemy_spawn_nodes.get_children()
	
	# Store Spawn Locations
	for x in spawn_nodes:
		spawn_position.append(x.global_position)
	
	# Spawn Starting Enemies
	for x in range(initial_spawn_enemys):
		print(x)
		var new_enemy = enemy_scene.instantiate()
		var spawn_pos = get_safe_spawn_position()
		add_child(new_enemy)
		
		new_enemy.global_position = spawn_pos
	
	# Start Spawning Timer
	spawn_timer.wait_time = spawn_interval
	spawn_timer.start()


# Find Safest Spawn Point
func get_safe_spawn_position() -> Vector2:
	if player == null or spawn_position.size() == 0:
		return spawn_position[0]
	
	# Find closest spawn location from player
	var closest_index = 0
	var closest_distance = player.global_position.distance_to(spawn_position[0])
	
	for i in range(1, spawn_position.size()):
		var distance = player.global_position.distance_to(spawn_position[i])
		if distance < closest_distance:
			closest_distance = distance
			closest_index = i
	
	# Make list of safe spawn points
	var available_spawns = []
	for i in range(spawn_position.size()):
		if i != closest_index:
			available_spawns.append(spawn_position[i])
	
	# Return random safe spawn
	if available_spawns.size() > 0:
		return available_spawns[randi() % available_spawns.size()]
	else:
		return spawn_position[0]


# Random Enemy Spawning
func _on_spawn_timer_timeout() -> void:
	var new_enemy = enemy_scene.instantiate()
	var spawn_pos = get_safe_spawn_position()
	add_child(new_enemy)
	
	new_enemy.global_position = spawn_pos
