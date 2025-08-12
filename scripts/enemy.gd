extends CharacterBody2D

@export var speed = 600
@export var gravity = 980

var player:Node
func _ready():
	for node in get_tree().get_nodes_in_group("Player"):
		player = node

func take_damage():
	queue_free()

func _physics_process(delta):
	var direction = player.global_position.x - global_position.x
	if direction < 0:
		direction = -1
	else:
		direction = 1
	velocity.x = speed * direction
	
	if  not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
	
