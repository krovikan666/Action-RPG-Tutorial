extends State

export var acceleration_default: = Vector2(10, 10)
export var max_speed_default: = Vector2(25, 25)
export var move_threshold: = 5.0

var acceleration: = acceleration_default
var max_speed: = max_speed_default
var velocity: = Vector2.ZERO


func update_direction() -> void:
	owner.anim.flip_h = velocity.x < 0


func get_move_direction(target: Vector2) -> Vector2:
	if owner.global_position.distance_to(target) < move_threshold:
		return Vector2.ZERO
	return owner.global_position.direction_to(target)


func move(direction: Vector2, delta: float) -> void:
	velocity = Movement.calculate_velocity(velocity, max_speed, acceleration, direction)

	if owner.soft_collision.is_colliding():
		velocity += owner.soft_collision.get_push_vector() * 500 * delta

	velocity = owner.move_and_slide(velocity)
	update_direction()
