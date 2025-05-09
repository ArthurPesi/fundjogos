extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION = 0.08
var curr_movement = Vector2(0,0)
const AGGRO_DISTANCE = 90000
var is_aggro = false
@onready var player = $"../player"

#func move_enemy() -> void:
	

func _physics_process(delta: float) -> void:
	if !is_aggro:
		if position.distance_squared_to(player.position) < AGGRO_DISTANCE:
			is_aggro = true
	else:
		var direction = (player.position - position).normalized()
		
		curr_movement = curr_movement.move_toward(direction, ACCELERATION)
		velocity = curr_movement * MAX_SPEED
		move_and_slide()
