extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION = 0.08
const MIN_FIRE_TIMEOUT = 2
const MAX_FIRE_TIMEOUT = 2.5
const PRECISION = 0.27
var curr_movement = Vector2(0,0)
const AGGRO_DISTANCE_SQUARED = 120000
const MIN_BULLETS = 10
const MAX_BULLETS = 17
const BULLET_DURATION = 0.3
const MIN_BULLET_SPEED = 800
const MAX_BULLET_SPEED = 1200
var is_aggro = false
@onready var player = $"../../player"
@onready var bullet = preload("res://bullet.tscn")
var timeoutFire
var amount_of_bullets

func _ready() -> void:
	timeoutFire = randf_range(MIN_FIRE_TIMEOUT, MAX_FIRE_TIMEOUT)
	amount_of_bullets = randf_range(MIN_BULLETS, MAX_BULLETS)
	
func fireManager(dir, delta):
	timeoutFire -= delta
	if timeoutFire <= 0:
		for i in amount_of_bullets:
			var temp_bullet = bullet.instantiate()
			add_sibling(temp_bullet)
			var spread_rad = randf_range(-PRECISION, PRECISION)
			dir = Vector2(dir.x * cos(spread_rad) - dir.y * sin(spread_rad), dir.x * sin(spread_rad) + dir.y * cos(spread_rad))
			temp_bullet.start(position, dir.normalized(), randf_range(MIN_BULLET_SPEED, MAX_BULLET_SPEED), BULLET_DURATION)
			timeoutFire = randf_range(MIN_FIRE_TIMEOUT, MAX_FIRE_TIMEOUT)
			amount_of_bullets = randf_range(MIN_BULLETS, MAX_BULLETS)
			

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
