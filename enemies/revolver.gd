extends Node2D

@onready var parent: CharacterBody2D = $".."

var ammo = 6

var min_fire_timeout = 1
var max_fire_timeout = 1.4
var precision = 0.15
const BULLET_SPEED = 300
const BULLET_LIFE = 4
var timeoutFire
@onready var bullet = preload("res://bullet_evil.tscn")

func _ready() -> void:
	timeoutFire = randf_range(0.2, 0.4)

func fireManager(dir, delta):
	timeoutFire -= delta
	if timeoutFire <= 0 and parent.check_for_los(parent.player) and ammo > 0:
		ammo -= 1
		var temp_bullet = bullet.instantiate()
		parent.add_sibling(temp_bullet)
		var spread_rad = randf_range(-precision, precision)
		dir = Vector2(dir.x * cos(spread_rad) - dir.y * sin(spread_rad), dir.x * sin(spread_rad) + dir.y * cos(spread_rad))
		temp_bullet.start(parent.position, dir.normalized(), BULLET_SPEED, BULLET_LIFE)
		timeoutFire = randf_range(min_fire_timeout, max_fire_timeout)
		
