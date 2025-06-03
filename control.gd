extends Node2D

var paused = false

const bg_colors = [
	[100, 34, 34, 255],
	[200, 69, 69, 255]
]

const wall_colors = [
	[69, 12, 12, 255],
	[169, 34, 34, 255]
]

var curr_level = 0

class player_class:
	var device
	var device_type
	var fire_action
	var get_weapon_action
	var knife_action
	var left_action
	var right_action
	var up_action
	var down_action
	var character_sprite
	
var player_one = player_class.new()

enum menu {MAIN_MENU, SETTINGS, CHAR_SELECTION}
enum scene {MENU, LEVEL}

var NOISE_SHAKE_SPEED: float = 10.0
var NOISE_SHAKE_STRENGTH: float = 60.0
var RANDOM_SHAKE_STRENGTH: float = 30.0
var SHAKE_DECAY_RATE: float = 3.0
var shake_strength: float = 0.0
var noise_i: float = 0.0
@onready var menu_resources = [preload("res://scenes/main_menu.tscn"), preload("res://scenes/config.tscn"), preload("res://scenes/char_selection.tscn")]
@onready var level_resources = [preload("res://scenes/scene_2d.tscn"), preload("res://scenes/scene_2d2.tscn")]
var level_instance
var scene_type = scene.MENU
var noise = FastNoiseLite.new()
var rand = RandomNumberGenerator.new()
var camera: Camera2D
var player: CharacterBody2D
var pause_menu
var enemy_holder: Node2D
var navigation_region: NavigationRegion2D
var amount_of_enemies: int

func get_level_bg_color():
	return Color.from_rgba8(bg_colors[curr_level][0],bg_colors[curr_level][1],bg_colors[curr_level][2],bg_colors[curr_level][3])

func get_level_wall_color():
	return Color.from_rgba8(wall_colors[curr_level][0],wall_colors[curr_level][1],wall_colors[curr_level][2],wall_colors[curr_level][3])
	
func _ready() -> void:
	RenderingServer.set_default_clear_color(get_level_bg_color())
	rand.randomize()
	noise.seed = rand.randi()
	noise.frequency = 0.08
	level_instance = menu_resources[menu.MAIN_MENU].instantiate()
	add_child(level_instance)

	
func check_enemy_amount():
	amount_of_enemies -= 1
	if amount_of_enemies == 0:
		await get_tree().create_timer(1).timeout
		load_next_level()
	
func start_level():
	if scene_type == scene.LEVEL:
		camera = level_instance.get_node("player/Camera2D")
		player = level_instance.get_node("player")
		player.init(player_one)
		pause_menu = level_instance.get_node("player/Camera2D/pause_menu")
		enemy_holder = level_instance.get_node("EnemyHolder")
		navigation_region = level_instance.get_node("NavigationRegion2D")
		amount_of_enemies = enemy_holder.get_child_count()
		
		var tween = get_tree().create_tween().set_parallel(true)
		for N in enemy_holder.get_children():
			var sprite = N.get_node("Sprite")
			tween.tween_property(sprite, "scale", sprite.get_scale(), 0.2).from(Vector2.ZERO)
			
		var wall_color = get_level_wall_color()
		for N in navigation_region.get_children():
			var sprite = N.get_node("Sprite")
			tween.tween_property(sprite, "scale:y", sprite.get_scale().y, 0.2).from(0)
			sprite.modulate = wall_color
	
func apply_shake(strength) -> void:
	shake_strength += strength
	
func _process(delta: float) -> void:
	if scene_type == scene.LEVEL:
		if shake_strength > 0:
			shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)
			
			var shake_offset: Vector2
			shake_offset = get_noise_offset(delta, NOISE_SHAKE_SPEED, shake_strength)
			camera.offset = shake_offset

func get_noise_offset(delta: float, speed: float, strength: float) -> Vector2:
	noise_i += delta * speed
	return Vector2(
		noise.get_noise_2d(1, noise_i) * strength,
		noise.get_noise_2d(100, noise_i) * strength
	)


func freeze(time):
	Engine.time_scale = 0.05
	await get_tree().create_timer(time * 0.05).timeout
	Engine.time_scale = 1

func reset_screen():
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(player.get_node("AnimatedSprite2D"), "scale", Vector2.ZERO, 0.2)
	if player.weapon_obj:
			player.weapon_obj.queue_free()
	for N in navigation_region.get_children():
		tween.tween_property(N, "scale:y", 0, 0.3)
	for N in enemy_holder.get_children():
		if N.is_in_group("enemy"):
			N.curr_state = N.states.dead
		tween.tween_property(N, "scale", Vector2.ZERO, 0.3)

	
func reload_level():
	load_scene(scene.LEVEL, curr_level)
	
func load_scene(new_type, new_scene):
	if scene_type == scene.LEVEL:
		reset_screen()
		await get_tree().create_timer(0.5).timeout
		shake_strength = 0
		Engine.time_scale = 1
	elif scene_type == scene.MENU:
		RenderingServer.set_default_clear_color(get_level_bg_color())
	if(level_instance):
		level_instance.queue_free()
	
	await get_tree().create_timer(0.1).timeout
	scene_type = new_type
	if new_type == scene.LEVEL:
		level_instance = level_resources[new_scene].instantiate()
		add_child(level_instance)
		start_level()
	elif new_type == scene.MENU:
		level_instance = menu_resources[new_scene].instantiate()
		add_child(level_instance)
	
func load_next_level():
	if curr_level + 1 < level_resources.size() and scene_type == scene.LEVEL:
		curr_level += 1
		RenderingServer.set_default_clear_color(get_level_bg_color())
	load_scene(scene.LEVEL, curr_level)

func _input(event):
	if event.is_action_pressed("quit_keyboard") and scene_type == scene.LEVEL:
		if !paused:
			Engine.time_scale = 0
			pause_menu.show()
		if paused:
			Engine.time_scale = 1
			pause_menu.hide()
		paused = !paused
		
func add_player(device_id, device_type):
	player_one.device = device_id
	player_one.device_type = device_type
	var action_suffix = "_keyboard" if device_type == constants.device_types.KEYBOARD else "_gamepad"
	player_one.fire_action = "fire" + action_suffix
	player_one.get_weapon_action = "get_weapon" + action_suffix
	player_one.knife_action = "knife" + action_suffix
	player_one.left_action = "left" + action_suffix
	player_one.right_action = "right" + action_suffix
	player_one.up_action = "up" + action_suffix
	player_one.down_action = "down" + action_suffix
