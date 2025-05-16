extends Node2D

@onready var parent: CharacterBody2D = $".."


const MAX_SPEED = 200
const ACCELERATION = 0.08
const MIN_FIRE_TIMEOUT = 0.03
const MAX_FIRE_TIMEOUT = 0.08
const PRECISION = 0.32
const BULLET_DURATION = 0.5
const MIN_BULLET_SPEED = 900
const MAX_BULLET_SPEED = 1000
const CLIP_SIZE = 30
const RELOAD_TIME = 1
var curr_reload = 0
var curr_ammo = CLIP_SIZE
@onready var bullet = preload("res://bullet_evil.tscn")
var timeoutFire
var amount_of_bullets

func _ready() -> void:
	timeoutFire = randf_range(0.7, 1)
			
			
func fireManager(dir, delta):
	timeoutFire -= delta
	if timeoutFire <= 0 and curr_ammo > 0 and parent.check_for_los():
		var temp_bullet = bullet.instantiate()
		parent.add_sibling(temp_bullet)
		var spread_rad = randf_range(-PRECISION, PRECISION)
		dir = Vector2(dir.x * cos(spread_rad) - dir.y * sin(spread_rad), dir.x * sin(spread_rad) + dir.y * cos(spread_rad))
		temp_bullet.start(parent.position, dir.normalized(), randf_range(MIN_BULLET_SPEED, MAX_BULLET_SPEED), BULLET_DURATION)
		timeoutFire = randf_range(MIN_FIRE_TIMEOUT, MAX_FIRE_TIMEOUT)
		curr_ammo -= 1
	if curr_ammo <= 0:
		curr_reload += delta
		if curr_reload >= RELOAD_TIME:
			curr_ammo = CLIP_SIZE
			curr_reload = 0
