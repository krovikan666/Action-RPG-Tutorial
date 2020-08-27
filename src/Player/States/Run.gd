extends State

onready var move: State = get_parent()


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)


func physics_process(_delta: float) -> void:
	move.update_direction()

	var move_direction: Vector2 = move.get_move_direction()
	if move_direction == Vector2.ZERO:
		move.velocity = Vector2.ZERO
		_state_machine.transition_to("Move/Idle")
		return 

	move.velocity = Movement.calculate_velocity(
		move.velocity, 
		move.max_speed, 
		move.acceleration, 
		move_direction
	)
	move.velocity = owner.move_and_slide(move.velocity)

	owner.play_animation(owner.last_direction, "run")
