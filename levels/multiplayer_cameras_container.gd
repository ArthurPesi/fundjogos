extends HBoxContainer
@onready var camera_1: Camera2D = $SubViewportContainer1/SubViewport1/Camera1
@onready var camera_2: Camera2D = $SubViewportContainer2/SubViewport2/Camera2
@onready var sub_viewport_1: SubViewport = $SubViewportContainer1/SubViewport1
@onready var sub_viewport_2: SubViewport = $SubViewportContainer2/SubViewport2

@onready var world = get_parent()
var player_1: CharacterBody2D
var player_2: CharacterBody2D
var viewport_width
var window_half_size
const PIOVERFOUR = PI / 4
const THREEPIOVERFOUR = 3 * PIOVERFOUR
const PIOVERTWO = PIOVERFOUR * 2
const MIN_DISTANCE := Vector2(576,324)
const MAX_DISTANCE := Vector2(1276,824)
const MAX_AUDIO_DISTANCE = 1000
var main_camera
var keyboard_player

func _ready() -> void:
	player_1 = world.players[0]
	player_2 = world.players[1]
	pivot_offset = size / 2
	window_half_size = Vector2(DisplayServer.window_get_size() / 2)
	position = window_half_size - pivot_offset
	viewport_width = sub_viewport_1.size.x

func get_true_width(angle):
	if angle < 0:
		angle += PI * 2
	var width_angle = lerp(window_half_size.x, window_half_size.y, sin(angle))
	if angle >= 0 and angle < PIOVERFOUR:
		return width_angle / cos(angle)
	elif angle < PIOVERTWO:
		return width_angle / cos(PIOVERTWO - angle)
	elif angle < THREEPIOVERFOUR:
		return width_angle / cos(angle - PIOVERTWO)
	elif angle < PI:
		return width_angle / cos(PI - angle)
	return get_true_width(angle - PI)

func _process(delta: float) -> void:
	if !player_1 or !player_2:
		return
	var diff =  player_2.position - player_1.position
	var angle = diff.angle()
	rotation = angle
	camera_1.global_rotation = angle
	camera_2.global_rotation = angle
	var p2_ang = diff.normalized()
	var midpoint = lerp(player_1.position, player_2.position, 0.5)
	var initial_pos_1 = midpoint - (p2_ang * (viewport_width/2))
	var initial_pos_2 = midpoint + (p2_ang * (viewport_width/2))
	
	var true_offset = (viewport_width - get_true_width(angle)) / 2
	var final_pos_2 = player_2.position + (p2_ang * true_offset)
	var final_pos_1 = player_1.position - (p2_ang * true_offset)
	
	var percentage_x = clamp(remap(abs(diff.x), MIN_DISTANCE.x, MAX_DISTANCE.x, 0, 1), 0, 1)
	var percentage_y = clamp(remap(abs(diff.y), MIN_DISTANCE.y, MAX_DISTANCE.y, 0, 1), 0, 1)
	camera_1.position.x = lerp(initial_pos_1.x, final_pos_1.x, percentage_x)
	camera_1.position.y = lerp(initial_pos_1.y, final_pos_1.y, percentage_y)
	
	if keyboard_player == 0:
		main_camera.position = camera_1.position + (p2_ang * (viewport_width/2))
	elif keyboard_player == 1:
		main_camera.position = camera_2.position - (p2_ang * (viewport_width/2))
	camera_2.position.x = lerp(initial_pos_2.x, final_pos_2.x, percentage_x)
	camera_2.position.y = lerp(initial_pos_2.y, final_pos_2.y, percentage_y)
	
	if diff.length() > MAX_AUDIO_DISTANCE:
		if world.sound_mode == constants.sound_modes.SOLO:
			sub_viewport_2.audio_listener_enable_2d = true
			world.sound_mode = constants.sound_modes.SPLIT

	elif world.sound_mode == constants.sound_modes.SPLIT:
		sub_viewport_2.audio_listener_enable_2d = false
		world.sound_mode = constants.sound_modes.SOLO
		
		
