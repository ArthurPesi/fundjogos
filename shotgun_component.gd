extends Node


func fireManager(delta, dir):
	utFire -= delta
	if timeoutFire <= 0:
		for i in 10:
			var temp_bullet = bullet.instantiate()
			add_sibling(temp_bullet)
			dir += Vector2(randf_range(-PRECISION,PRECISION), randf_range(-PRECISION,PRECISION))
			temp_bullet.start(position, dir.normalized(), randf_range(700, 1100), 0.2)
			timeoutFire = randf_range(MIN_FIRE_TIMEOUT, MAX_FIRE_TIMEOUT)
