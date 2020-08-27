extends State

onready var move: State = get_parent()


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	if not owner.player_detector.can_see_player():
		_state_machine.transition_to("Move/Idle")
		return 

	var target: Vector2 = owner.player_detector.player.global_position
	var move_direction: Vector2 = move.get_move_direction(target)

	move.move(move_direction, delta)
