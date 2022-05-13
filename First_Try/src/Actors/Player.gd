extends Actor

var slide_direction: = 0
export var horizontal_acceleration: = 1000.0
export var horizontal_terminal_velocity: = 2000.0
export var friction: = 900.0
export var jump_strength: = 900.0
export var vertical_wall_jump_strength: = 200.0
export var horizontal_wall_jump_strength: = 700.00

func _physics_process(delta: float) -> void:
	var direction: = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 0.0)
	# direction is either 0, -1 (<-) or 1 (->)
	
	velocity.x +=  direction.x * horizontal_acceleration * delta
	if direction.x == 1:
		velocity.x = min(velocity.x, horizontal_terminal_velocity)
		
	if direction.x == -1:
		velocity.x = max(velocity.x, -horizontal_terminal_velocity)

	if velocity.x > 0:
		slide_direction = 1
		
	if velocity.x < 0:
		slide_direction = -1
	
	if direction.x == 0:
		if slide_direction == 1:
			velocity.x +=  -slide_direction * friction * delta
		if slide_direction == -1:
			velocity.x +=  -slide_direction * friction * delta
		if velocity.x < 20 and velocity.x > -20:
			slide_direction = 0
			velocity.x = 0











	if is_on_floor() == true:
		velocity.y += -1 * Input.get_action_strength("jump") * jump_strength
	
	if is_on_wall() == true and is_on_floor() == false and Input.get_action_strength("jump") == 1.0 and get_which_wall_collided() == -direction.x:
		velocity.y = -1 * vertical_wall_jump_strength
		velocity.x += get_which_wall_collided() * horizontal_wall_jump_strength
		
	velocity = move_and_slide(velocity, Vector2.UP)


func get_which_wall_collided():
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		if collision.normal.x > 0:
			return 1
		elif collision.normal.x < 0:
			return -1
	return "none"
