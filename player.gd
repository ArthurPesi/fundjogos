extends CharacterBody2D

const MAX_SPEED = 300
const ACCELERATION = 0.08
var curr_movement = Vector2(0,0)

func _physics_process(delta: float) -> void:
	var input = Vector2(Input.get_axis("left","right"), Input.get_axis("up","down")).normalized()
	if input.x == 0 or sign(input.x) != sign(curr_movement.x):
		curr_movement.x = 0
	if input.y == 0 or sign(input.y) != sign(curr_movement.y):
		curr_movement.y = 0
	
	curr_movement = curr_movement.move_toward(input, ACCELERATION)
	velocity = curr_movement * MAX_SPEED
	move_and_slide()
