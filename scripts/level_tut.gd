extends Node2D

const SPAWN_INTERVAL: int = 3
const INITIAL_SPAWN_ENEMIES: int = 3

@export var enemy_spawn_nodes: Node
@export var spawn_timer: Timer
@export var enemy_scene: PackedScene

var spawn_position: Array = []
var spawn_nodes: Array = []
var player: Node = null

func _ready() -> void:
	# Identify Player
	for node in get_tree().get_nodes_in_group("Player"):
		player = node

	# Identifies all the spawnpoint nodes
	spawn_nodes = enemy_spawn_nodes.get_children()
	for node in spawn_nodes:
		spawn_position.append(node.global_position)

	# Spawn the innitial 3 enemies
	for i in range(INITIAL_SPAWN_ENEMIES):
		var new_enemy = enemy_scene.instantiate()
		new_enemy.global_position = get_safe_spawn_position()
		add_child(new_enemy)

	# Begin the spawning timer
	spawn_timer.wait_time = SPAWN_INTERVAL
	spawn_timer.start()

# Finds a spawn locations that the player is not near
func get_safe_spawn_position() -> Vector2:
	if player == null or spawn_position.size() == 0:
		return spawn_position[0]

	#Finds closest spawn point to player
	var closest_index = 0
	var closest_distance = player.global_position.distance_to(spawn_position[0])
	for i in range(1, spawn_position.size()):
		var distance = player.global_position.distance_to(spawn_position[i])
		if distance < closest_distance:
			closest_distance = distance
			closest_index = i

	# Creates a list of spawn points that are not the closest to the player
	var available_spawns: Array = []
	for i in range(spawn_position.size()):
		if i != closest_index:
			available_spawns.append(spawn_position[i])

	# Returns a random safe spawn point
	if available_spawns.size() > 0:
		return available_spawns[randi() % available_spawns.size()]
	return spawn_position[0]

# Spawns a new enemy at the random safe spawn point on timer trigger
func _on_spawn_timer_timeout() -> void:
	var new_enemy = enemy_scene.instantiate()
	new_enemy.global_position = get_safe_spawn_position()
	add_child(new_enemy)
