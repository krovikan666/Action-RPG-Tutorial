extends State

onready var move: State = get_parent()


func enter(_msg: Dictionary = {}) -> void:
	move.max_speed = move.max_speed_default
	move.velocity = Vector2.ZERO


func physics_process(delta: float) -> void:
	if owner.player_detector.can_see_player():
		_state_machine.transition_to("Move/Chase")
		return
	elif owner.global_position.distance_to(owner.start_position) < move.move_threshold:
		_state_machine.transition_to("Move/Wander")
		return

	var move_direction: Vector2 = move.get_move_direction(owner.start_position)
	move.move(move_direction, delta)
