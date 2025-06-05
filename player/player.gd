extends CharacterBody2D

const AUDIO_PLAYER = preload("res://audio_player.tscn")
var enemies_inside_fire_range: Array[CharacterBody2D]

var player_settings

var weapon_holding_presets: Array[Resource]
var weapon_dropped_presets: Array[Resource]
const MAX_SPEED = 300
const ACCELERATION = 4
const ATTACK_SPEED = 1000
const ATTACK_DURATION = 0.1
const ATTACK_COOLDOWN_SPEED: float = 0.1
@onready var world: Node2D = $"../.."
@onready var enemy_holder: Node2D = $"../EnemyHolder"
var curr_movement = Vector2(0,0)
var curr_state = constants.player_states.WALKING
var curr_weapon_value = null
var directionRadians
var attackCounter: float = 0
var curr_collect = null
var weapon_obj = null
@onready var bullet = preload("res://player/bullet_good.tscn")
var timer_weapon = 0
var walk_dir: Vector2 = Vector2(0,0)
var look_dir: Vector2 = Vector2(0,0)
var sprite_instance
var unique_device
const MORTAL = false
const WEAPON_OFFSET = Vector2(8, 0)
var weapon_scale: Vector2

func _ready() -> void:
	for i in constants.weapons:
		weapon_holding_presets.append(load("res://weapons/" + i.to_lower() + "_sprite.tscn"))
		weapon_dropped_presets.append(load("res://weapons/" + i.to_lower() + "_dropped.tscn"))

func init(world_settings) -> void:
	player_settings = world_settings
	sprite_instance = player_settings.character_sprite.instantiate()
	add_child(sprite_instance)
	unique_device = player_settings.device if player_settings.device_type == constants.device_types.GAMEPAD else 0

func die_player():
	if curr_state != constants.player_states.DEAD and MORTAL:
		curr_state = constants.player_states.DEAD
		world.reload_level()
		$CollisionShape2D.queue_free()

func walk(delta: float) -> Vector2:
	rotation = atan2(look_dir.y, look_dir.x)
	if walk_dir.x == 0 or sign(walk_dir.x) != sign(curr_movement.x):
		curr_movement.x = 0
	if walk_dir.y == 0 or sign(walk_dir.y) != sign(curr_movement.y):
		curr_movement.y = 0

	curr_movement = curr_movement.move_toward(walk_dir, ACCELERATION * delta)
	if curr_movement == Vector2.ZERO:
		sprite_instance.play("idle")
	else:
		sprite_instance.play("walk")
	
	return curr_movement * MAX_SPEED

func collision_should_kill(collision) -> bool:
	if collision:
		return collision.is_in_group("kill") or (curr_state == constants.player_states.WALKING and collision.is_in_group("enemy"))
	return false
	
var atk_move = Vector2()

func melee():
	if attackCounter <= 0:
		atk_move = look_dir.normalized()
		rotation = atan2(look_dir.y, look_dir.x)
		curr_state = constants.player_states.ATTACKING
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", modulate, 0.35).from(Color.RED)

func animate():
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(weapon_obj, "scale", weapon_scale, weapon_obj.ANIMATION_DURATION).from(weapon_obj.scale * weapon_obj.ANIMATION_INCREASE)
	tween.tween_property(weapon_obj, "modulate:v", 1, weapon_obj.ANIMATION_DURATION/2).from(10)
	tween.tween_property(weapon_obj, "position", WEAPON_OFFSET, weapon_obj.ANIMATION_DURATION).from(Vector2.ZERO)
	tween.tween_property(weapon_obj, "rotation", 0, weapon_obj.ANIMATION_DURATION).from(weapon_obj.rotation - weapon_obj.ANIMATION_FALLBACK)
	tween.tween_property($AnimatedSprite2D, "scale:y", $AnimatedSprite2D.get_scale().y, weapon_obj.ANIMATION_SQUASH).from(2)

func shoot():
	if timer_weapon > 0 or !weapon_obj:
		return
	if weapon_obj.ammo <= 0:
		var tween = get_tree().create_tween().set_parallel(true)
		tween.tween_property(weapon_obj, "modulate", weapon_obj.modulate, 0.2).from(Color.RED)
		tween.tween_property(weapon_obj, "rotation", weapon_obj.rotation, 0.3).from(weapon_obj.rotation - 1)
		timer_weapon = randf_range(0.34, 0.69)
		var sound_player = AUDIO_PLAYER.instantiate()
		var no_ammo_sound = world.get_random_no_ammo_sound_effect()
		add_child(sound_player)
		sound_player.play_sound(no_ammo_sound)
		return
	weapon_obj.ammo -= 1
	animate()
	
	var sound_player = AUDIO_PLAYER.instantiate()
	var shot_sound = world.get_random_shot_sound_effect(curr_weapon_value)
	add_child(sound_player)
	sound_player.play_sound(shot_sound)
	if curr_weapon_value == constants.weapons.SHOTGUN:
		var reload_player = AUDIO_PLAYER.instantiate()
		var reload_sound = world.get_random_shotgun_cock_sound_effect()
		add_child(reload_player)
		sound_player.connect("finished",reload_player.play_sound.bind(reload_sound))
	
	world.apply_shake(weapon_obj.SHAKE_STRENGTH)
	var amount_of_bullets = randf_range(weapon_obj.MIN_BULLETS, weapon_obj.MAX_BULLETS)
	for i in amount_of_bullets:
		var temp_bullet = bullet.instantiate()
		add_sibling(temp_bullet)
		var spread_rad = randf_range(-weapon_obj.PRECISION, weapon_obj.PRECISION)
		var dir = Vector2(cos(rotation), sin(rotation))
		dir = Vector2(dir.x * cos(spread_rad) - dir.y * sin(spread_rad), dir.x * sin(spread_rad) + dir.y * cos(spread_rad))
		temp_bullet.start(position, dir.normalized(), randf_range(weapon_obj.MIN_BULLET_SPEED, weapon_obj.MAX_BULLET_SPEED), weapon_obj.BULLET_DURATION, self)
	
	timer_weapon = weapon_obj.COOLDOWN
	
	for N in enemies_inside_fire_range:
		enemies_inside_fire_range.erase(N)
		if N.curr_state == constants.enemy_states.REGULAR:
			N.enter_aggro(self)
	
func get_weapon():
	for i in constants.weapons.values():
		if curr_collect.is_in_group(constants.weapons.keys()[i].to_lower()):
			if weapon_obj:
				if weapon_obj.ammo > 0:
					var just_dropped = weapon_dropped_presets[curr_weapon_value].instantiate()
					just_dropped.position = position
					just_dropped.z_index = 1
					just_dropped.rotation = randf() * PI * 2
					just_dropped.ammo = weapon_obj.ammo
					enemy_holder.add_child(just_dropped)
				weapon_obj.queue_free()
			curr_weapon_value = i as constants.weapons
			weapon_obj = weapon_holding_presets[i].instantiate()
			weapon_obj.ammo = curr_collect.ammo
			weapon_obj.position = WEAPON_OFFSET
			weapon_scale = weapon_obj.scale
			curr_collect.queue_free()
			add_child(weapon_obj)
			break

func can_collect(object):
	curr_collect = object

func _physics_process(delta: float) -> void:
	if player_settings.device_type == constants.device_types.KEYBOARD:
		look_dir = get_global_mouse_position() - position
	match curr_state:
		constants.player_states.WALKING:
			if attackCounter > 0:
				attackCounter -= ATTACK_COOLDOWN_SPEED * delta
			velocity = walk(delta)
			move_and_slide()
			if check_fire() and weapon_obj:
				shoot()

		constants.player_states.ATTACKING:
			attackCounter += delta
			velocity = atk_move * ATTACK_SPEED
			move_and_slide()
			if attackCounter >= ATTACK_DURATION:
				curr_state = constants.player_states.WALKING

	if curr_state != constants.player_states.DEAD:
		for index in get_slide_collision_count():
			var collision = get_slide_collision(index).get_collider()
			if collision_should_kill(collision):
				die_player()
			elif curr_state == constants.player_states.ATTACKING and collision.is_in_group("enemy"):
				attackCounter = clamp(attackCounter - 0.03,0, attackCounter)
				collision.die()

	if weapon_obj:
		if timer_weapon > 0:
			timer_weapon -= delta
			
			
func check_fire() -> bool:
	if player_settings.device_type == constants.device_types.KEYBOARD:
		if Input.is_action_pressed(player_settings.fire_action):
			return true
	else:
		if Input.is_joy_button_pressed(player_settings.device, JOY_BUTTON_RIGHT_SHOULDER):
			return true
	return false

func _input(event: InputEvent) -> void:
	if event.device == unique_device:
		if Input.is_action_just_pressed(player_settings.knife_action) or (Input.is_action_just_pressed(player_settings.fire_action) and !weapon_obj) and curr_state == constants.player_states.WALKING:
			melee()
		if event.is_action(player_settings.get_weapon_action) and Input.is_action_just_pressed(player_settings.get_weapon_action) and curr_collect and curr_state != constants.player_states.DEAD:
			get_weapon()
		
		walk_dir = Vector2(Input.get_axis(player_settings.left_action,player_settings.right_action), Input.get_axis(player_settings.up_action,player_settings.down_action)).normalized()
		if player_settings.device_type == constants.device_types.GAMEPAD:
			if event.is_action_pressed("look_down_gamepad") or event.is_action_pressed("look_up_gamepad") or event.is_action_pressed("look_left_gamepad") or event.is_action_pressed("look_right_gamepad"):
				look_dir = Vector2(Input.get_axis("look_left_gamepad","look_right_gamepad"), Input.get_axis("look_up_gamepad","look_down_gamepad"))

func _on_fire_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		if body.curr_state == constants.enemy_states.REGULAR:
			enemies_inside_fire_range.append(body)

func _on_fire_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemies_inside_fire_range.erase(body)
