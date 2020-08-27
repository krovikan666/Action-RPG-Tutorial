extends Node


static func calculate_velocity(
		old_velocity: Vector2,
		max_speed: Vector2,
		acceleration: Vector2,
		move_direction: Vector2
	) -> Vector2:

	var new_velocity: = old_velocity

	new_velocity += move_direction.normalized() * acceleration
	new_velocity.x = clamp(new_velocity.x, -max_speed.x, max_speed.x)
	new_velocity.y = clamp(new_velocity.y, -max_speed.y, max_speed.y)
	return new_velocity
