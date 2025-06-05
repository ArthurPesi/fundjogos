extends Node2D

var timeout_fire = 0
var ammo = 4
var bullets_per_ammo
const MIN_FIRE_INITIAL_TIMEOUT = 0.3
const MAX_FIRE_INITIAL_TIMEOUT = 0.8
const PRECISION = 0.27
const MIN_BULLETS = 10
const MAX_BULLETS = 17
const BULLET_DURATION = 3
const MIN_BULLET_SPEED = 300
const MAX_BULLET_SPEED = 350
const MIN_RELOAD_TIME = 2
const MAX_RELOAD_TIME = 2.3
const CLIP_SIZE = 1
var curr_clip = CLIP_SIZE
const MIN_CONSECUTIVE_SHOTS_TIMEOUT = 0.0
const MAX_CONSECUTIVE_SHOTS_TIMEOUT = 0.0
