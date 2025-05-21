extends Node2D

var paused = false

var NOISE_SHAKE_SPEED: float = 10.0
var NOISE_SHAKE_STRENGTH: float = 60.0
var RANDOM_SHAKE_STRENGTH: float = 30.0
var SHAKE_DECAY_RATE: float = 2.0


var noise_i: float = 0.0
@onready var rand = RandomNumberGenerator.new()
var shake_strength: float = 0.0

@onready var camera: Camera2D = $player/Camera2D
@onready var noise = FastNoiseLite.new()
@onready var pause_menu = get_node("player/Camera2D/pause_menu")

func _ready() -> void:
	Engine.time_scale = 1
	rand.randomize()
	noise.seed = rand.randi()
	noise.frequency = 0.08
	
func apply_shake() -> void:
	shake_strength = NOISE_SHAKE_STRENGTH
	
func _process(delta: float) -> void:
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


func _on_player_player_dead() -> void:
	if get_tree():
		pass#get_tree().reload_current_scene()
	

func _input(event):
	if event.is_action_pressed("fire"):
		apply_shake()

	if event.is_action_pressed("quit"):
		if !paused:
			Engine.time_scale = 0
			pause_menu.show()
		if paused:
			Engine.time_scale = 1
			pause_menu.hide()
		paused = !paused
