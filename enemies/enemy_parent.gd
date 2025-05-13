extends CharacterBody2D

var max_speed = 200
var acceleration = 0.08
var curr_movement = Vector2(0,0)
var aggro_distance_squared_los = 120000
var aggro_distance_squared_hear = 12000
const VISION_ANGLE = 1.5

var is_aggro = false
@onready var ray_cast: RayCast2D = $RayCast2D
@export var weapon: Node2D
@onready var player = $"../../player"
@onready var nav: NavigationAgent2D = $NavigationAgent2D
var timeoutFire
		
func check_for_los() -> bool:
	ray_cast.target_position = player.position - position
	ray_cast.global_rotation = 0
	ray_cast.force_raycast_update()
	if ray_cast.is_colliding():
		if ray_cast.get_collider().is_in_group("obstacle"):
			return false
	return true
	
func to_unit_circle(angle) -> float:
	if(angle != 0):
		return fmod(2 * PI, angle)
	else:
		return 0

func should_aggro():
	var distance_to_player = position.distance_squared_to(player.position)
	if distance_to_player < aggro_distance_squared_los:
		var los = check_for_los()
		if los and abs(ray_cast.target_position.angle() - to_unit_circle(rotation)) < VISION_ANGLE:
			print(rotation)
			return true
		if distance_to_player < aggro_distance_squared_hear:
			print(abs(ray_cast.target_position.angle() - to_unit_circle(rotation)))
			if los:
				return true
	return false

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("debug") and (position.distance_squared_to(get_global_mouse_position())) < 5000:
		pass
	if !is_aggro:
		if should_aggro():
			is_aggro = true
	else:
		nav.target_position = player.global_position
		var direction = global_position.direction_to(nav.get_next_path_position())#(player.position - position).normalized()
		look_at(nav.get_next_path_position())
		weapon.fireManager(direction, delta)
		
		ray_cast.global_rotation_degrees = 0
		
		curr_movement = curr_movement.move_toward(direction, acceleration)
		velocity = curr_movement * max_speed
		move_and_slide()
