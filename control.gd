extends Node2D
const color_debug = [100, 34, 34, 255]

const bg_colors = [
	[100, 86, 135, 255],
	[90, 84, 135, 255],
	[93, 93, 125, 255],
	[87, 87, 187, 255],
	[83, 108, 167, 255],
	[89, 90, 188, 255],
	[73, 100, 162, 255],
	[126, 129, 180, 255],
	[167, 129, 110, 255],
	[167, 77, 60, 255],
	[187, 107, 80, 255],
	[177, 77, 50, 255],
	[207, 97, 80, 255],
	[177, 87, 60, 255],
	[190, 180, 170, 255],
	[190, 190, 160, 255],
	[180, 197, 200, 255],
	[190, 170, 176, 255]
]

const wall_colors = [
	[60, 54, 54, 255],
	[73, 66, 67, 255],
	[50, 47, 53, 255],
	[80, 86, 83, 255],
	[92, 91, 92, 255],#
	[94, 94, 90, 255],
	[105, 98, 102, 255],
	[100, 110, 112, 255],
	[237, 129, 140, 255],
	[237, 20, 60, 255],
	[207, 13, 80, 255],
	[187, 12, 60, 255],
	[227, 12, 80, 255],
	[177, 75, 100, 255],
	[126, 60, 40, 255],
	[139, 10, 30, 255],
	[137, 21, 11, 255],
	[143, 30, 20, 255]
]


@onready var level_resources = [ [
	preload("res://levels/lvl_s_0.tscn"),
	preload("res://levels/lvl_s_1.tscn"),
	preload("res://levels/lvl_s_2.tscn"),
	preload("res://levels/lvl_s_3.tscn"),
	preload("res://levels/lvl_s_4.tscn"),
	preload("res://levels/lvl_s_5.tscn"),
	preload("res://levels/lvl_s_6.tscn"),
	preload("res://levels/lvl_s_7.tscn"),
	preload("res://levels/lvl_s_8.tscn"),
	preload("res://levels/lvl_s_9.tscn"),
	preload("res://levels/lvl_s_10.tscn"),
	preload("res://levels/lvl_s_11.tscn"),
	preload("res://levels/lvl_s_12.tscn"),
	preload("res://levels/lvl_s_13.tscn"),
	preload("res://levels/lvl_s_14.tscn"),
	preload("res://levels/lvl_s_15.tscn"),
	preload("res://levels/lvl_s_16.tscn"),
	preload("res://levels/lvl_s_17.tscn")
],
[
	preload("res://levels/lvl_m_0.tscn"),
	preload("res://levels/lvl_m_1.tscn"),
	preload("res://levels/lvl_m_2.tscn"),
	preload("res://levels/lvl_m_3.tscn"),
	preload("res://levels/lvl_m_4.tscn"),
	preload("res://levels/lvl_m_5.tscn"),
	preload("res://levels/lvl_m_6.tscn"),
	preload("res://levels/lvl_m_7.tscn"),
	preload("res://levels/lvl_m_8.tscn"),
	preload("res://levels/lvl_m_9.tscn"),
	preload("res://levels/lvl_m_10.tscn"),
	preload("res://levels/lvl_m_11.tscn"),
	preload("res://levels/lvl_m_12.tscn"),
	preload("res://levels/lvl_m_13.tscn"),
	preload("res://levels/lvl_m_14.tscn"),
	preload("res://levels/lvl_m_15.tscn"),
	preload("res://levels/lvl_m_16.tscn"),
	preload("res://levels/lvl_m_17.tscn")
]
]

@onready var sound_effects = [
	[preload("res://SFX/guns/shotgun/1.mp3"), preload("res://SFX/guns/shotgun/2.mp3")],
	[preload("res://SFX/guns/cock_shotgun/1.mp3")],
	[preload("res://SFX/guns/revolver/1.mp3"), preload("res://SFX/guns/revolver/2.mp3"),preload("res://SFX/guns/revolver/3.mp3"),preload("res://SFX/guns/revolver/4.mp3")],
	[preload("res://SFX/guns/uzi/1.mp3")],
	[preload("res://SFX/guns/no_ammo/1.mp3"), preload("res://SFX/guns/no_ammo/2.mp3"),preload("res://SFX/guns/no_ammo/3.mp3"),preload("res://SFX/guns/no_ammo/4.mp3")],
	[preload("res://SFX/guns/pick_up/1.mp3"), preload("res://SFX/guns/pick_up/2.mp3"),preload("res://SFX/guns/pick_up/3.mp3")],
	[preload("res://SFX/enemies/aggro/1.mp3"), preload("res://SFX/enemies/aggro/2.mp3"),preload("res://SFX/enemies/aggro/3.mp3"), preload("res://SFX/enemies/aggro/4.mp3"), preload("res://SFX/enemies/aggro/5.mp3")],
	[preload("res://SFX/enemies/death/1.mp3"), preload("res://SFX/enemies/death/2.mp3"),preload("res://SFX/enemies/death/3.mp3"), preload("res://SFX/enemies/death/4.mp3"), preload("res://SFX/enemies/death/5.mp3")],
	[preload("res://SFX/players/death/male/1.mp3"), preload("res://SFX/players/death/male/2.mp3")],
	[preload("res://SFX/players/death/female/1.mp3"), preload("res://SFX/players/death/female/2.mp3")],
	[preload("res://SFX/players/attack/fighter/1.mp3")],
	[preload("res://SFX/players/attack/paladin/1.mp3")],
	[preload("res://SFX/UI/button_click/1.mp3"), preload("res://SFX/UI/button_click/2.mp3"), preload("res://SFX/UI/button_click/3.mp3")],
]

@onready var menu_resources = [
	preload("res://menus/main_menu.tscn"),
	preload("res://menus/settings.tscn"),
	preload("res://menus/char_selection.tscn"),
	preload("res://menus/credits.tscn"),
	preload("res://menus/thanks.tscn")
]


var pause_blur
signal confirmation_signal
var curr_level_id = 0
var show_transition_text := false
var active_devices: Array[int]
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
	var attack_sfx
	var character
	var character_sprite
	
var players_settings: Array[player_class] = [player_class.new(), player_class.new()]
const LEVEL_HOLDER_PRESET = preload("res://levels/level_holder.tscn")
const SAVE_PATH = "user://savegame.json"

var game_mode = constants.game_modes.SINGLE
var sound_mode = constants.sound_modes.SOLO
var keyboard_player: int
var NOISE_SHAKE_SPEED: float = 10.0
var NOISE_SHAKE_STRENGTH: float = 60.0
var RANDOM_SHAKE_STRENGTH: float = 30.0
var SHAKE_DECAY_RATE: float = 3.0
var shake_strength: float = 0.0
var noise_i: float = 0.0
var level_holder
var scene_type = constants.scene_types.MENU
var noise = FastNoiseLite.new()
var rand = RandomNumberGenerator.new()
var main_camera: Camera2D
var players: Array[CharacterBody2D]
var pause_menu
var enemy_holder: Node2D
var navigation_region: NavigationRegion2D
var amount_of_enemies: int
var world_to_render: World2D
var split_cam_container: HBoxContainer
var main_viewport: SubViewport
const MULTIPLAYER_CAMERAS_CONTAINER = preload("res://levels/multiplayer_cameras_container.tscn")
const SPATIAL_AUDIO_PLAYER = preload("res://spatial_audio_player.tscn")
const AUDIO_PLAYER = preload("res://audio_player.tscn")
const SFX_PATH = "res://SFX/"
var transition_label: Label
var level_instance
var finish_area
const ARROW = preload("res://levels/arrow.tscn")

func _ready() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var json = file.get_as_text()
		
		var saved_data = JSON.parse_string(json)
		
		curr_level_id = saved_data["level_id"]
	
	if constants.DEBUG_LEVEL:
		curr_level_id = constants.DEBUG_LEVEL
	TranslationServer.set_locale(OS.get_locale_language())
	Input.connect("joy_connection_changed",_on_joy_connection_changed)
	
	#var i_level = 0
	#var i_path_level = "res://levels/lvl_s_" + str(i_level) + ".tscn"
	#while FileAccess.file_exists(i_path_level):
		#level_resources[constants.game_modes.SINGLE].append(load(i_path_level))
		#i_level += 1
		#i_path_level = "res://levels/lvl_s_" + str(i_level) + ".tscn"
		#
	#i_level = 0
	#i_path_level = "res://levels/lvl_m_" + str(i_level) + ".tscn"
	#while FileAccess.file_exists(i_path_level):
		#level_resources[constants.game_modes.MULTI].append(load(i_path_level))
		#i_level += 1
		#i_path_level = "res://levels/lvl_m_" + str(i_level) + ".tscn"
	
	#sound_effects.resize(constants.sound_paths.size())
	#for i in constants.sound_effects.values():
		#var curr_file = 1
		#var curr_dir = SFX_PATH.path_join(constants.sound_paths[i])
		#while FileAccess.file_exists(curr_dir.path_join(str(curr_file) + ".mp3")):
			#sound_effects[i].append(load(curr_dir.path_join(str(curr_file) + ".mp3")))
			#curr_file += 1

	players.resize(2)
	#for i in constants.menus:
		#menu_resources.append(load("res://menus/" + i.to_lower() + ".tscn"))
	RenderingServer.set_default_clear_color(get_level_bg_color())
	rand.randomize()
	noise.seed = rand.randi()
	noise.frequency = 0.08
	level_instance = menu_resources[constants.menus.MAIN_MENU].instantiate()
	add_child(level_instance)

func _on_joy_connection_changed(device, connected):
	if !connected and device in active_devices:
		pause_menu.pause()

func play_spatial_sound_effect(sound_effect, audio_position: Vector2):
	var random = randi() % sound_effects[sound_effect].size()
	var sound = sound_effects[sound_effect][random]
	var audio_player = SPATIAL_AUDIO_PLAYER.instantiate()
	audio_player.global_position = audio_position
	main_viewport.add_child(audio_player)
	audio_player.play_sound(sound)

func play_sound_effect(sound_effect):
	var random = randi() % sound_effects[sound_effect].size()
	var sound = sound_effects[sound_effect][random]
	var audio_player = AUDIO_PLAYER.instantiate()
	add_child(audio_player)
	audio_player.play_sound(sound)
	
func get_level_bg_color():
	return Color.from_rgba8(bg_colors[curr_level_id][0],bg_colors[curr_level_id][1],bg_colors[curr_level_id][2],bg_colors[curr_level_id][3])

func get_level_wall_color():
	return Color.from_rgba8(wall_colors[curr_level_id][0],wall_colors[curr_level_id][1],wall_colors[curr_level_id][2],wall_colors[curr_level_id][3])
	
var arrow_instance
func bookkeep_enemy_amount():
	amount_of_enemies -= 1
	if amount_of_enemies <= 0:
		arrow_instance = ARROW.instantiate()
		arrow_instance.target = finish_area.global_position
		arrow_instance.target_rotation = finish_area.rotation
		players[0].add_child(arrow_instance)
		
func check_level_up():
	if amount_of_enemies == 0:
		load_next_level()

func get_world_to_render():
	return world_to_render

func start_level():
	if scene_type == constants.scene_types.LEVEL:
		main_viewport = level_holder.get_node("MainViewport")
		transition_label = level_holder.get_node("TextCanvas/Control/Label")
		transition_label.text = "LEVEL" + str(curr_level_id)
		transition_label.hide()
		main_viewport.add_child(level_instance)
		main_camera = level_instance.get_node("Camera2D")
		finish_area = level_instance.get_node("FinishLevelArea")
		players[0] = level_instance.get_node("Player1")
		players[0].init(players_settings[0])
		if game_mode == constants.game_modes.MULTI:
			players[1] = level_instance.get_node("Player2")
			players[1].init(players_settings[1])
			world_to_render = main_viewport.world_2d
			split_cam_container = MULTIPLAYER_CAMERAS_CONTAINER.instantiate()
			split_cam_container.main_camera = main_camera
			split_cam_container.keyboard_player = keyboard_player
			add_child(split_cam_container)
			
		pause_menu = level_holder.get_node("PauseCanvas/pause_menu")
		pause_blur = level_holder.get_node("PauseCanvas/ColorRect")
		enemy_holder = level_instance.get_node("EnemyHolder")
		navigation_region = level_instance.get_node("NavigationRegion2D")
		amount_of_enemies = enemy_holder.get_child_count()
		
		var tween = get_tree().create_tween().set_parallel(true)
		
		for N in enemy_holder.get_children():
			var sprite = N.get_node("Sprite")
			tween.tween_property(sprite, "scale", sprite.get_scale(), 0.2).from(Vector2.ZERO)
		var tile_set = navigation_region.get_child(0)
		var wall_color = get_level_wall_color()
		tile_set.modulate = wall_color
		tween.tween_property(tile_set, "modulate:a", 1, 0.1).from(0)

func apply_shake(strength) -> void:
	shake_strength += strength
	
func _process(delta: float) -> void:
	if scene_type == constants.scene_types.LEVEL:
		if Input.is_action_just_pressed("debug"):
			load_next_level()
		if shake_strength > 0:
			shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)
			
			var shake_offset: Vector2
			shake_offset = get_noise_offset(delta, NOISE_SHAKE_SPEED, shake_strength)
			main_camera.offset = shake_offset
			if game_mode == constants.game_modes.MULTI:
				split_cam_container.camera_1.offset = shake_offset
				split_cam_container.camera_2.offset = shake_offset

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
	if arrow_instance:
		tween.tween_property(arrow_instance.get_node("AnimatedSprite2D"), "scale", Vector2.ZERO, 0.2)
	for player in players:
		if player:
			tween.tween_property(player.get_node("AnimatedSprite2D"), "scale", Vector2.ZERO, 0.2)
			if player.weapon_obj:
				player.weapon_obj.queue_free()
	tween.tween_property(navigation_region.get_child(0), "modulate:a", 0, 0.1)
	for N in enemy_holder.get_children():
		if N.is_in_group("enemy"):
			N.curr_state = constants.enemy_states.DEAD
		tween.tween_property(N, "scale", Vector2.ZERO, 0.3)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("confirm"):
		confirmation_signal.emit()
	
func reload_level():
	players[0].get_node("CollisionShape2D").queue_free()
	if game_mode == constants.game_modes.MULTI:
		players[1].get_node("CollisionShape2D").queue_free()
	load_scene(constants.scene_types.LEVEL, curr_level_id)
	
func load_scene(new_type, new_scene):
	if scene_type == constants.scene_types.LEVEL:
		reset_screen()
		await get_tree().create_timer(0.5).timeout
		shake_strength = 0
		Engine.time_scale = 1
	elif scene_type == constants.scene_types.MENU:
		RenderingServer.set_default_clear_color(get_level_bg_color())
	if(show_transition_text):
		transition_label.show()
		await confirmation_signal
		show_transition_text = false
		
	if(level_instance):
		level_instance.queue_free()
		
	if scene_type == constants.scene_types.LEVEL and new_type == constants.scene_types.MENU and level_holder:
		level_holder.queue_free()
		
	await get_tree().create_timer(0.2).timeout
	scene_type = new_type
	if new_type == constants.scene_types.LEVEL:
		if !level_holder:
			level_holder = LEVEL_HOLDER_PRESET.instantiate()
			add_child(level_holder)
		level_instance = level_resources[game_mode][new_scene].instantiate()
		start_level()
	elif new_type == constants.scene_types.MENU:
		level_instance = menu_resources[new_scene].instantiate()
		add_child(level_instance)

func load_next_level():
	if curr_level_id + 1 >= level_resources[0].size():
		curr_level_id = 0
		load_scene(constants.scene_types.MENU, constants.menus.THANKS)
		return
	if curr_level_id + 1 < level_resources[0].size() and scene_type == constants.scene_types.LEVEL:
		curr_level_id += 1
		var next_color = get_level_bg_color()
		RenderingServer.set_default_clear_color(next_color)
		pause_blur.modulate = next_color
		pause_blur.modulate.a = 0.7
	show_transition_text = true
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data = {}
	data["level_id"] = curr_level_id
	var json = JSON.stringify(data)
	file.store_string(json)
	file.close()
	load_scene(constants.scene_types.LEVEL, curr_level_id)
		
func is_device_active(device_id) -> bool:
	return active_devices.has(device_id)
	
func add_player(player_id, device_id, device_type):
	var player_device: int
	if device_type == constants.device_types.KEYBOARD:
		active_devices.append(-1)
		player_device = -1
		keyboard_player = player_id
	else:
		active_devices.append(device_id)
		player_device = device_id
	if player_id == 1:
		game_mode = constants.game_modes.MULTI
	players_settings[player_id].device = player_device
	players_settings[player_id].device_type = device_type
	var action_suffix = "_keyboard" if device_type == constants.device_types.KEYBOARD else "_gamepad"
	players_settings[player_id].fire_action = "fire" + action_suffix
	players_settings[player_id].get_weapon_action = "get_weapon" + action_suffix
	players_settings[player_id].knife_action = "knife" + action_suffix
	players_settings[player_id].left_action = "left" + action_suffix
	players_settings[player_id].right_action = "right" + action_suffix
	players_settings[player_id].up_action = "up" + action_suffix
	players_settings[player_id].down_action = "down" + action_suffix
	
func remove_all_players():
	for i in players_settings:
		i = player_class.new()
	game_mode = constants.game_modes.SINGLE
	active_devices.clear()
