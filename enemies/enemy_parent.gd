extends CharacterBody2D

var max_speed = 200
var acceleration = 0.08
var curr_movement = Vector2(0,0)
var aggro_distance_squared_los = 120000
var aggro_distance_squared_hear = 6000
const VISION_ANGLE = 1

var objects_inside_vision_area: Array[Object]

var debug = false

var curr_state = constants.enemy_states.REGULAR
var target: CharacterBody2D
@onready var player: CharacterBody2D = $"../../Player1"

@onready var world: Node2D = $"../../.."

@onready var ray_cast: RayCast2D = $RayCast2D
@export var weapon: Node2D
@onready var drop = load("res://weapons/" + weapon.name + "_dropped.tscn")
@onready var bullet = preload("res://enemies/bullet_evil.tscn")
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var vision_area: Area2D = $VisionArea

func _ready() -> void:
	weapon.timeout_fire = randf_range(weapon.MIN_FIRE_INITIAL_TIMEOUT, weapon.MAX_FIRE_INITIAL_TIMEOUT)

func shoot(dir):
	if weapon.timeout_fire <= 0 and check_for_los(player) and weapon.ammo > 0:
		weapon.ammo -= 1
		weapon.curr_clip -= 1
		weapon.bullets_per_ammo = randf_range(weapon.MIN_BULLETS, weapon.MAX_BULLETS)
		for i in weapon.bullets_per_ammo:
			var temp_bullet = bullet.instantiate()
			add_sibling(temp_bullet)
			var spread_rad = randf_range(-weapon.PRECISION, weapon.PRECISION)
			dir = Vector2(dir.x * cos(spread_rad) - dir.y * sin(spread_rad), dir.x * sin(spread_rad) + dir.y * cos(spread_rad))
			temp_bullet.start(position, dir.normalized(), randf_range(weapon.MIN_BULLET_SPEED, weapon.MAX_BULLET_SPEED), weapon.BULLET_DURATION)
		var time_for_next_shot: float
		if weapon.curr_clip <= 0:
			time_for_next_shot = randf_range(weapon.MIN_RELOAD_TIME, weapon.MAX_RELOAD_TIME)
			weapon.curr_clip = weapon.CLIP_SIZE
		else:
			time_for_next_shot = randf_range(weapon.MIN_CONSECUTIVE_SHOTS_TIMEOUT, weapon.MAX_CONSECUTIVE_SHOTS_TIMEOUT)
		weapon.timeout_fire = time_for_next_shot
		#weapon.curr_clip = weapon.CLIP_SIZE

func check_for_los(obj) -> bool:
	ray_cast.target_position = obj.position - position
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

func check_aggro():
	for N in objects_inside_vision_area:
		if check_for_los(N):
			enter_aggro(player)
			
func enter_aggro(aggro_target):
	curr_state = constants.enemy_states.AGGRO
	target = aggro_target
	vision_area.queue_free()
	add_to_group("trigger_aggro")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("debug") and (position.distance_squared_to(get_global_mouse_position())) < 5000:
		debug = true
		print("debugging")
	if curr_state == constants.enemy_states.REGULAR:
		check_aggro()
	elif curr_state == constants.enemy_states.AGGRO:
		weapon.timeout_fire -= delta
		nav.target_position = target.global_position
		var direction = global_position.direction_to(nav.get_next_path_position())
		look_at(nav.get_next_path_position())
		if weapon.timeout_fire <= 0 and check_for_los(target) and weapon.ammo > 0:
			shoot(direction)
		#weapon.fireManager(direction, delta)
		
		ray_cast.global_rotation_degrees = 0
		
		curr_movement = curr_movement.move_toward(direction, acceleration)
		velocity = curr_movement * max_speed
		move_and_slide()

func die():
	if curr_state != constants.enemy_states.DEAD:
		curr_state = constants.enemy_states.DEAD
		world.check_enemy_amount()
		$CollisionShape2D.queue_free()
		var temp_drop = drop.instantiate()
		temp_drop.position = position
		temp_drop.rotation = randf() * PI * 2
		temp_drop.z_index = 0
		temp_drop.ammo = weapon.ammo
		var tween = get_tree().create_tween()
		tween.tween_property($Sprite, "scale", Vector2(0,0),0.8)
		tween.tween_callback(queue_free)
		world.freeze(0.5)
		call_deferred("add_sibling", temp_drop)

func _on_vision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("trigger_aggro"):
		objects_inside_vision_area.append(body)
	if body.is_in_group("player"):
		player = body

func _on_vision_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("trigger_aggro"):
		objects_inside_vision_area.erase(body)
		

func _on_vision_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("trigger_aggro"):
		objects_inside_vision_area.append(area)
	if area.is_in_group("good"):
		if area.bullet_owner.is_in_group("player"):
			player = area.bullet_owner

func _on_vision_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("trigger_aggro"):
		objects_inside_vision_area.erase(area)


func _on_die_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.curr_state == constants.player_states.ATTACKING:
			die()
