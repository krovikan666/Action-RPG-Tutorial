extends State

onready var move: State = get_parent()


func unhandled_input(event: InputEvent) -> void:
	move.unhandled_input(event)


func physics_process(_delta: float) -> void:
	if move.get_move_direction() != Vector2.ZERO:
		_state_machine.transition_to("Move/Run")


func enter(msg: Dictionary = {}) -> void:
	move.enter(msg)
	
	move.max_speed = move.max_speed_default
	move.velocity = Vector2.ZERO

	owner.play_animation(owner.last_direction, "idle")


func exit() -> void:
	move.exit()

