extends AnimatedSprite2D

@onready var parent: CharacterBody2D = $".."

var ammo = 4

const PRECISION = 0.27
const MIN_BULLETS = 10
const MAX_BULLETS = 17
const BULLET_DURATION = 0.3
const MIN_BULLET_SPEED = 800
const MAX_BULLET_SPEED = 1200
var amount_of_bullets
var timer = 0
const COOLDOWN = 0.7
const SHAKE_STRENGTH = 70.0
@onready var bullet = preload("res://bullet_good.tscn")

func _physics_process(delta: float) -> void:
	if timer > 0:
		timer -= delta

func shoot():
	if timer > 0 or ammo <= 0:
		return
	ammo -= 1
	parent.world.apply_shake(SHAKE_STRENGTH)
	amount_of_bullets = randf_range(MIN_BULLETS, MAX_BULLETS)
	for i in amount_of_bullets:
		var temp_bullet = bullet.instantiate()
		parent.add_sibling(temp_bullet)
		var spread_rad = randf_range(-PRECISION, PRECISION)
		var dir = Vector2(cos(parent.rotation), sin(parent.rotation))
		dir = Vector2(dir.x * cos(spread_rad) - dir.y * sin(spread_rad), dir.x * sin(spread_rad) + dir.y * cos(spread_rad))
		temp_bullet.start(parent.position, dir.normalized(), randf_range(MIN_BULLET_SPEED, MAX_BULLET_SPEED), BULLET_DURATION)
	
	timer = COOLDOWN
