extends CharacterBody2D

var max_speed = 200
var acceleration = 0.08
var min_fire_timeout = 1
var max_fire_timeout = 1.4
var precision = 0.15
var curr_movement = Vector2(0,0)
var aggro_distance_squared = 120000

var is_aggro = false
@onready var player = $"../../player"
@onready var bullet = preload("res://bullet.tscn")
var timeoutFire

func _ready() -> void:
	timeoutFire = randf_range(min_fire_timeout, max_fire_timeout)

func fireManager(dir, delta):
	timeoutFire -= delta
	if timeoutFire <= 0:
		var temp_bullet = bullet.instantiate()
		add_sibling(temp_bullet)
		var spread_rad = randf_range(-precision, precision)
		dir = Vector2(dir.x * cos(spread_rad) - dir.y * sin(spread_rad), dir.x * sin(spread_rad) + dir.y * cos(spread_rad))
		temp_bullet.start(position, dir.normalized(), 1000, 0.5)
		timeoutFire = randf_range(min_fire_timeout, max_fire_timeout)
		

func _physics_process(delta: float) -> void:
	if !is_aggro:
		if position.distance_squared_to(player.position) < aggro_distance_squared:
			is_aggro = true
	else:
		look_at(player.position)
		var direction = (player.position - position).normalized()
		fireManager(direction, delta)
		
		curr_movement = curr_movement.move_toward(direction, acceleration)
		velocity = curr_movement * max_speed
		move_and_slide()
