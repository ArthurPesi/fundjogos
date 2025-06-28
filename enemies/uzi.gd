extends Node2D

const ID = constants.weapons.UZI
const SFX = constants.sound_effects.UZI_SHOT
var timeout_fire = 0
var bullets_per_ammo = 1
const MIN_FIRE_INITIAL_TIMEOUT = 0.5
const MAX_FIRE_INITIAL_TIMEOUT = 0.99
const PRECISION = 0.32
const MIN_BULLETS = 1
const MAX_BULLETS = 1
const BULLET_DURATION = 3
const MIN_BULLET_SPEED = 700
const MAX_BULLET_SPEED = 850
const MIN_RELOAD_TIME = 1.6
const MAX_RELOAD_TIME = 2.29
const MIN_CONSECUTIVE_SHOTS_TIMEOUT = 0.02
const MAX_CONSECUTIVE_SHOTS_TIMEOUT = 0.1
const CLIP_SIZE = 8
var curr_clip = CLIP_SIZE
var curr_frame = 0

var curr_reload = 0
var ammo = 40
