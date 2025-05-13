extends CharacterBody2D

const MAX_SPEED = 300
const ACCELERATION = 4
const ATTACK_SPEED = 1000
const ATTACK_DURATION = 0.1
enum state {walking, attacking}
@onready var world: Node2D = $".."
var curr_movement = Vector2(0,0)
var curr_state = state.walking
var directionRadians
var attackCounter = 0
signal player_dead

func walk(delta: float) -> Vector2:
	attackCounter = clamp(attackCounter -1, 0, 1000)
	look_at(get_global_mouse_position())
	var input = Vector2(Input.get_axis("left","right"), Input.get_axis("up","down")).normalized()
	if input.x == 0 or sign(input.x) != sign(curr_movement.x):
		curr_movement.x = 0
	if input.y == 0 or sign(input.y) != sign(curr_movement.y):
		curr_movement.y = 0

	curr_movement = curr_movement.move_toward(input, ACCELERATION * delta)
	return curr_movement * MAX_SPEED

func collision_should_kill(collision) -> bool:
	return collision.is_in_group("kill") or (curr_state == state.walking and collision.is_in_group("enemy"))
	
var atk_move = Vector2()

func fire_set():
	var attackDirVec = get_global_mouse_position() - position
	atk_move = attackDirVec.normalized()
	rotation = atan2(attackDirVec.y, attackDirVec.x)
	curr_state = state.attacking


func _physics_process(delta: float) -> void:
	match curr_state:
		state.walking:
			velocity = walk(delta)
			move_and_slide()
			if Input.is_action_just_pressed("fire"):
				fire_set()
		state.attacking:
			attackCounter += delta
			velocity = atk_move * ATTACK_SPEED
			move_and_slide()
			if attackCounter >= ATTACK_DURATION:
				curr_state = state.walking
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index).get_collider()
		if collision_should_kill(collision):
			emit_signal("player_dead")
			break
		elif curr_state == state.attacking and collision.is_in_group("enemy"):
			attackCounter = clamp(attackCounter - 0.03,0, attackCounter)
			collision.queue_free()
			world.freeze(0.4)
