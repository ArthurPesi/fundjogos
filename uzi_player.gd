extends AnimatedSprite2D

@onready var parent: CharacterBody2D = $".."

var ammo = 50

const PRECISION = 0.32
const BULLET_DURATION = 0.5
const MIN_BULLET_SPEED = 900
const MAX_BULLET_SPEED = 1000
var timer = 0
const COOLDOWN = 0.05

@onready var bullet = preload("res://bullet_good.tscn")
func _physics_process(delta: float) -> void:
	if timer > 0:
		timer -= delta

func shoot():
	if timer > 0 or ammo <= 0:
		return
	
	ammo -= 1
	var temp_bullet = bullet.instantiate()
	parent.add_sibling(temp_bullet)
	var spread_rad = randf_range(-PRECISION, PRECISION)
	var dir = Vector2(cos(parent.rotation), sin(parent.rotation))
	dir = Vector2(dir.x * cos(spread_rad) - dir.y * sin(spread_rad), dir.x * sin(spread_rad) + dir.y * cos(spread_rad))
	temp_bullet.start(parent.position, dir.normalized(), randf_range(MIN_BULLET_SPEED, MAX_BULLET_SPEED), BULLET_DURATION)
	
	timer = COOLDOWN
