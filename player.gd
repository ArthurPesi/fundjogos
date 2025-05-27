extends CharacterBody2D

enum state {walking, attacking, dead}
enum weapon {revolver, uzi, shotgun, nothing}

const possible_weapons = ["revolver", "uzi", "shotgun"]
const weapon_holding_presets = [preload("res://revolver_sprite.tscn"), preload("res://uzi_sprite.tscn"), preload("res://shotgun_sprite.tscn")]
const weapon_dropped_presets = [preload("res://enemies/revolver_dropped.tscn"), preload("res://enemies/uzi_dropped.tscn"), preload("res://enemies/shotgun_dropped.tscn")]
var amount_weapons = possible_weapons.size()
const MAX_SPEED = 300
const ACCELERATION = 4
const ATTACK_SPEED = 1000
const ATTACK_DURATION = 0.1
@onready var world: Node2D = $".."
var curr_movement = Vector2(0,0)
var curr_state = state.walking
var curr_weapon_value = weapon.nothing
var directionRadians
var attackCounter = 0
var curr_collect = null
var weapon_obj = null
@onready var bullet = preload("res://bullet_good.tscn")
var timer_weapon = 0

const MORTAL = true

signal player_dead

func die_player():
	if curr_state != state.dead and MORTAL:
		curr_state = state.dead
		emit_signal("player_dead")
		$CollisionShape2D.queue_free()
		var tween = get_tree().create_tween()
		tween.tween_property($AnimatedSprite2D, "scale", Vector2.ZERO, 0.2)
	

func walk(delta: float) -> Vector2:
	attackCounter = clamp(attackCounter -1, 0, 1000)
	look_at(get_global_mouse_position())
	var input = Vector2(Input.get_axis("left","right"), Input.get_axis("up","down")).normalized()
	if input.x == 0 or sign(input.x) != sign(curr_movement.x):
		curr_movement.x = 0
	if input.y == 0 or sign(input.y) != sign(curr_movement.y):
		curr_movement.y = 0

	curr_movement = curr_movement.move_toward(input, ACCELERATION * delta)
	return curr_movement * MAX_SPEED

func collision_should_kill(collision) -> bool:
	if collision:
		return collision.is_in_group("kill") or (curr_state == state.walking and collision.is_in_group("enemy"))
	return false
	
var atk_move = Vector2()

func melee():
	var attackDirVec = get_global_mouse_position() - position
	atk_move = attackDirVec.normalized()
	rotation = atan2(attackDirVec.y, attackDirVec.x)
	curr_state = state.attacking
	
func animate():
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(weapon_obj, "scale", Vector2.ONE * -1, weapon_obj.ANIMATION_DURATION).from(Vector2.ONE * -weapon_obj.ANIMATION_INCREASE)
	tween.tween_property(weapon_obj, "modulate:v", 1, weapon_obj.ANIMATION_DURATION/2).from(10)

func shoot():
	if timer_weapon > 0 or weapon_obj.ammo <= 0:
		return
	weapon_obj.ammo -= 1
	animate()
	world.apply_shake(weapon_obj.SHAKE_STRENGTH)
	var amount_of_bullets = randf_range(weapon_obj.MIN_BULLETS, weapon_obj.MAX_BULLETS)
	for i in amount_of_bullets:
		var temp_bullet = bullet.instantiate()
		add_sibling(temp_bullet)
		var spread_rad = randf_range(-weapon_obj.PRECISION, weapon_obj.PRECISION)
		var dir = Vector2(cos(rotation), sin(rotation))
		dir = Vector2(dir.x * cos(spread_rad) - dir.y * sin(spread_rad), dir.x * sin(spread_rad) + dir.y * cos(spread_rad))
		temp_bullet.start(position, dir.normalized(), randf_range(weapon_obj.MIN_BULLET_SPEED, weapon_obj.MAX_BULLET_SPEED), weapon_obj.BULLET_DURATION)
	
	timer_weapon = weapon_obj.COOLDOWN
	
func get_weapon():
	for i in amount_weapons:
		if curr_collect.is_in_group(possible_weapons[i]):
			if weapon_obj:
				if weapon_obj.ammo > 0:
					var just_dropped = weapon_dropped_presets[curr_weapon_value].instantiate()
					just_dropped.position = position
					just_dropped.z_index = 1
					just_dropped.ammo = weapon_obj.ammo
					add_sibling(just_dropped)
				weapon_obj.queue_free()
			curr_weapon_value = i as weapon
			weapon_obj = weapon_holding_presets[i].instantiate()
			weapon_obj.ammo = curr_collect.ammo
			add_child(weapon_obj)
			curr_collect.queue_free()

func can_collect(object):
	curr_collect = object

func _physics_process(delta: float) -> void:
	match curr_state:
		state.walking:
			velocity = walk(delta)
			move_and_slide()
			if Input.is_action_just_pressed("knife") or (Input.is_action_just_pressed("fire") and !weapon_obj):
				melee()
			if Input.is_action_pressed("fire") and weapon_obj:
				shoot()
			if Input.is_action_just_pressed("get_weapon") and curr_collect:
				get_weapon()
		state.attacking:
			attackCounter += delta
			velocity = atk_move * ATTACK_SPEED
			move_and_slide()
			if attackCounter >= ATTACK_DURATION:
				curr_state = state.walking

	if curr_state != state.dead:
		for index in get_slide_collision_count():
			var collision = get_slide_collision(index).get_collider()
			if collision_should_kill(collision):
				die_player()
			elif curr_state == state.attacking and collision.is_in_group("enemy"):
				attackCounter = clamp(attackCounter - 0.03,0, attackCounter)
				collision.die()

	if weapon_obj:
		if timer_weapon > 0:
			timer_weapon -= delta
