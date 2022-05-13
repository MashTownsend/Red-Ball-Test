extends Actor

func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if velocity.x == 0.0:
		velocity.x = -100.0
		
	if is_on_wall() == true:
		if get_which_wall_collided() == 1:
			velocity.x = 100.0
		else:
			velocity.x = -100.0



func get_which_wall_collided():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.normal.x > 0:
			return 1 # left
		elif collision.normal.x < 0:
			return -1
	return "none"
