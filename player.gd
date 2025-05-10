extends CharacterBody2D

const MAX_SPEED = 300
const ACCELERATION = 0.08
const ATTACK_SPEED = 1000
var curr_movement = Vector2(0,0)

enum state {walking, dead, attacking}

var curr_state = state.walking
var mouseTrack = Vector2()
var mouseAttack = Vector2()

var directionRadians
var attackDirVec
var attackCounter = 0



func fire():
	mouseAttack = get_global_mouse_position()
	curr_state = state.attacking
	attackDirVec = mouseAttack - position
	curr_movement = attackDirVec.normalized()
	rotation = atan2(attackDirVec.y, attackDirVec.x)

func _physics_process(delta: float) -> void:
	if curr_state == state.walking:
		attackCounter = clamp(attackCounter -1, 0, 1000)
		look_at(get_global_mouse_position())
		var input = Vector2(Input.get_axis("left","right"), Input.get_axis("up","down")).normalized()
		if input.x == 0 or sign(input.x) != sign(curr_movement.x):
			curr_movement.x = 0
		if input.y == 0 or sign(input.y) != sign(curr_movement.y):
			curr_movement.y = 0
		
		curr_movement = curr_movement.move_toward(input, ACCELERATION)
		velocity = curr_movement * MAX_SPEED
		move_and_slide()
	if curr_state == state.attacking and attackCounter < 6:
		attackCounter += 1
		velocity = curr_movement * ATTACK_SPEED
		move_and_slide()
	else:
		curr_state = state.walking
	
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index).get_collider()
		if collision.is_in_group("kill") or curr_state == state.walking:
			get_tree().reload_current_scene()
			break
		elif curr_state == state.attacking:
			attackCounter -= 2
			collision.queue_free()
			
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire") and attackCounter == 0:
		fire()
