extends Node2D

@onready var parent: CharacterBody2D = $".."

var timeoutFire

var ammo = 4

const MIN_FIRE_TIMEOUT = 2
const MAX_FIRE_TIMEOUT = 2.5
const PRECISION = 0.27
const MIN_BULLETS = 10
const MAX_BULLETS = 17
const BULLET_DURATION = 0.3
const MIN_BULLET_SPEED = 800
const MAX_BULLET_SPEED = 1200
var amount_of_bullets

@onready var bullet = preload("res://bullet_evil.tscn")

func _ready() -> void:
	timeoutFire = randf_range(0.5, 0.7)
	amount_of_bullets = randf_range(MIN_BULLETS, MAX_BULLETS)

func fireManager(dir, delta):
	timeoutFire -= delta
	if timeoutFire <= 0 and parent.check_for_los() and ammo > 0:
		ammo -= 1
		for i in amount_of_bullets:
			var temp_bullet = bullet.instantiate()
			parent.add_sibling(temp_bullet)
			var spread_rad = randf_range(-PRECISION, PRECISION)
			dir = Vector2(dir.x * cos(spread_rad) - dir.y * sin(spread_rad), dir.x * sin(spread_rad) + dir.y * cos(spread_rad))
			temp_bullet.start(parent.position, dir.normalized(), randf_range(MIN_BULLET_SPEED, MAX_BULLET_SPEED), BULLET_DURATION)
			timeoutFire = randf_range(MIN_FIRE_TIMEOUT, MAX_FIRE_TIMEOUT)
			amount_of_bullets = randf_range(MIN_BULLETS, MAX_BULLETS)
