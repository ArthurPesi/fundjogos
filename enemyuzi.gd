extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION = 0.08
const MIN_FIRE_TIMEOUT = 0.03
const MAX_FIRE_TIMEOUT = 0.08
const PRECISION = 0.32
var curr_movement = Vector2(0,0)
const AGGRO_DISTANCE_SQUARED = 120000
const BULLET_DURATION = 0.5
const MIN_BULLET_SPEED = 900
const MAX_BULLET_SPEED = 1000
const CLIP_SIZE = 30
const RELOAD_TIME = 1
var curr_reload = 0
var curr_ammo = CLIP_SIZE
var is_aggro = false
@onready var player = $"../../player"
@onready var bullet = preload("res://bullet.tscn")
var timeoutFire
var amount_of_bullets

func _ready() -> void:
	timeoutFire = randf_range(MIN_FIRE_TIMEOUT, MAX_FIRE_TIMEOUT)
	
func fireManager(dir, delta):
	timeoutFire -= delta
	if timeoutFire <= 0 and curr_ammo > 0:
		var temp_bullet = bullet.instantiate()
		add_sibling(temp_bullet)
		var spread_rad = randf_range(-PRECISION, PRECISION)
		dir = Vector2(dir.x * cos(spread_rad) - dir.y * sin(spread_rad), dir.x * sin(spread_rad) + dir.y * cos(spread_rad))
		temp_bullet.start(position, dir.normalized(), randf_range(MIN_BULLET_SPEED, MAX_BULLET_SPEED), BULLET_DURATION)
		timeoutFire = randf_range(MIN_FIRE_TIMEOUT, MAX_FIRE_TIMEOUT)
		curr_ammo -= 1
	if curr_ammo <= 0:
		curr_reload += delta
		if curr_reload >= RELOAD_TIME:
			curr_ammo = CLIP_SIZE
			curr_reload = 0

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
