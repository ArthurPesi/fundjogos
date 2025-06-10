extends Node2D

const ID = constants.weapons.UZI
const SFX = constants.sound_effects.UZI_SHOT
var timeout_fire = 0
var bullets_per_ammo = 1
const MIN_FIRE_INITIAL_TIMEOUT = 2
const MAX_FIRE_INITIAL_TIMEOUT = 2.5
const PRECISION = 0.15
const MIN_BULLETS = 1
const MAX_BULLETS = 1
const BULLET_DURATION = 3
const MIN_BULLET_SPEED = 300
const MAX_BULLET_SPEED = 400
const MIN_RELOAD_TIME = 1.5
const MAX_RELOAD_TIME = 2
const MIN_CONSECUTIVE_SHOTS_TIMEOUT = 0.04
const MAX_CONSECUTIVE_SHOTS_TIMEOUT = 0.06
const CLIP_SIZE = 20
var curr_clip = CLIP_SIZE

var curr_reload = 0
var ammo = 30
