extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION = 0.08
const MIN_FIRE_TIMEOUT = 1
const MAX_FIRE_TIMEOUT = 1.4
const PRECISION = 0.15
var curr_movement = Vector2(0,0)
const AGGRO_DISTANCE_SQUARED = 120000
var is_aggro = false
@onready var player = $"../../player"
@onready var bullet = preload("res://bullet.tscn")
var timeoutFire

func _ready() -> void:
	timeoutFire = randf_range(MIN_FIRE_TIMEOUT, MAX_FIRE_TIMEOUT)
	
func fireManager(dir, delta):
	timeoutFire -= delta
	if timeoutFire <= 0:
		var temp_bullet = bullet.instantiate()
		add_sibling(temp_bullet)
		dir += Vector2(randf_range(-PRECISION,PRECISION), randf_range(-PRECISION,PRECISION))
		temp_bullet.start(position, dir.normalized())
		timeoutFire = randf_range(MIN_FIRE_TIMEOUT, MAX_FIRE_TIMEOUT)
		

func _physics_process(delta: float) -> void:
	if !is_aggro:
		if position.distance_squared_to(player.position) < AGGRO_DISTANCE_SQUARED:
			is_aggro = true
	else:
		look_at(player.position)
		var direction = (player.position - position).normalized()
		fireManager(direction, delta)
		
		curr_movement = curr_movement.move_toward(direction, ACCELERATION)
		velocity = curr_movement * MAX_SPEED
		move_and_slide()
