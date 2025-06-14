class_name savegame
extends Resource

const SAVE_PATH := "user://savegame.tres"
var curr_level: int
var master_volume_db
var music_volume_db
var sfx_volume_db
var language

func write_save():
	ResourceSaver.save(self, SAVE_PATH)
