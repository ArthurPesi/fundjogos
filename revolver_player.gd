extends AnimatedSprite2D

@onready var parent: CharacterBody2D = $".."

var ammo = 6

var min_fire_timeout = 1
var max_fire_timeout = 1.4
var precision = 0.1
const BULLET_SPEED = 800
const BULLET_LIFE = 10
var timer = 0
const COOLDOWN = 0.4
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
	var spread_rad = randf_range(-precision, precision)
	var dir = Vector2(cos(parent.rotation), sin(parent.rotation))
	dir = Vector2(dir.x * cos(spread_rad) - dir.y * sin(spread_rad), dir.x * sin(spread_rad) + dir.y * cos(spread_rad))
	temp_bullet.start(parent.position, dir.normalized(), BULLET_SPEED, BULLET_LIFE)
	timer = COOLDOWN
		
