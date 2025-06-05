extends Node2D

const ID = constants.weapons.REVOLVER
var ammo = 6
var bullets_per_ammo = 1
var timeout_fire = 0
const PRECISION = 0.15
const MIN_FIRE_INITIAL_TIMEOUT = 0.2
const MAX_FIRE_INITIAL_TIMEOUT = 0.4
const MIN_BULLETS = 1
const MAX_BULLETS = 1
const BULLET_DURATION = 4
const MIN_BULLET_SPEED = 300
const MAX_BULLET_SPEED = 300
const MIN_RELOAD_TIME = 1
const MAX_RELOAD_TIME = 1.4
const CLIP_SIZE = 1
var curr_clip = CLIP_SIZE
const MIN_CONSECUTIVE_SHOTS_TIMEOUT = 0.0
const MAX_CONSECUTIVE_SHOTS_TIMEOUT = 0.0
