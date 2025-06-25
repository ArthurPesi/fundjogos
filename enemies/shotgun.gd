extends Node2D

const ID = constants.weapons.SHOTGUN
const SFX = constants.sound_effects.SHOTGUN_SHOT
var ammo = 2
var bullets_per_ammo
const MIN_FIRE_INITIAL_TIMEOUT = 0.8
const MAX_FIRE_INITIAL_TIMEOUT = 0.9
const PRECISION = 0.27
const MIN_BULLETS = 10
const MAX_BULLETS = 17
const BULLET_DURATION = 3
const MIN_BULLET_SPEED = 650
const MAX_BULLET_SPEED = 800
const MIN_RELOAD_TIME = 2
const MAX_RELOAD_TIME = 2.3
const CLIP_SIZE = 1
var curr_clip = CLIP_SIZE
const MIN_CONSECUTIVE_SHOTS_TIMEOUT = 0.0
const MAX_CONSECUTIVE_SHOTS_TIMEOUT = 0.0
var timeout_fire = MAX_FIRE_INITIAL_TIMEOUT
var curr_frame = 0
