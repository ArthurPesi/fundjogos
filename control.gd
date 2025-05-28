extends Node2D

var paused = false

const colors = [
	[100, 34, 34, 255],
	[200, 69, 69, 255]
]

var curr_level = 0

var NOISE_SHAKE_SPEED: float = 10.0
var NOISE_SHAKE_STRENGTH: float = 60.0
var RANDOM_SHAKE_STRENGTH: float = 30.0
var SHAKE_DECAY_RATE: float = 3.0
var shake_strength: float = 0.0
var noise_i: float = 0.0

@onready var level_resources = [preload("res://scenes/scene_2d.tscn"), preload("res://scenes/scene_2d2.tscn")]
var level_instance
var noise = FastNoiseLite.new()
var rand = RandomNumberGenerator.new()
var camera: Camera2D
var pause_menu
var enemy_holder: Node2D
var navigation_region: NavigationRegion2D
var amount_of_enemies: int

func get_level_color():
	return Color.from_rgba8(colors[curr_level][0],colors[curr_level][1],colors[curr_level][2],colors[curr_level][3])

func _ready() -> void:
	RenderingServer.set_default_clear_color(get_level_color())
	rand.randomize()
	noise.seed = rand.randi()
	noise.frequency = 0.08
	level_instance = level_resources[curr_level].instantiate()
	add_child(level_instance)
	
	get_node_references()

	
func check_enemy_amount():
	amount_of_enemies -= 1
	if amount_of_enemies == 0:
		await get_tree().create_timer(1).timeout
		load_next_level()
	
func get_node_references():
	camera = level_instance.get_node("player/Camera2D")
	pause_menu = level_instance.get_node("player/Camera2D/pause_menu")
	enemy_holder = level_instance.get_node("EnemyHolder")
	navigation_region = level_instance.get_node("NavigationRegion2D")
	amount_of_enemies = enemy_holder.get_child_count()
	
func apply_shake(strength) -> void:
	shake_strength += strength
	
func _process(delta: float) -> void:
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

func load_curr_level():
	enemy_holder.reset_screen()
	navigation_region.reset_screen()
	await get_tree().create_timer(0.5).timeout
	shake_strength = 0
	Engine.time_scale = 1
	if(level_instance):
		level_instance.queue_free()
	
	await get_tree().create_timer(0.1).timeout
	level_instance = level_resources[curr_level].instantiate()
	add_child(level_instance)
	get_node_references()
	
func load_next_level():
	if curr_level + 1 < level_resources.size():
		curr_level += 1
		RenderingServer.set_default_clear_color(get_level_color())
	load_curr_level()

func _input(event):
	if event.is_action_pressed("quit"):
		if !paused:
			Engine.time_scale = 0
			pause_menu.show()
		if paused:
			Engine.time_scale = 1
			pause_menu.hide()
		paused = !paused
