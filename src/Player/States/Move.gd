extends State
# Parent state that abstracts and handles basic movement

export var acceleration_default: = Vector2(25, 25)
export var max_speed_default: = Vector2(50, 50)

var acceleration: = acceleration_default
var max_speed: = max_speed_default
var velocity: = Vector2.ZERO


func get_move_direction() -> Vector2:
	var right_strength: float = Input.get_action_strength("move_right")
	var left_strength: float = Input.get_action_strength("move_left")
	var up_strength: float = Input.get_action_strength("move_up")
	var down_strength: float = Input.get_action_strength("move_down")
	
	return Vector2(right_strength - left_strength, up_strength - down_strength)


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		_state_machine.transition_to("Attack", {"direction": owner.last_direction})
	elif event.is_action_pressed("roll"):
		_state_machine.transition_to("Move/Roll", {"direction": owner.last_direction})


func update_direction() -> void:
	if get_move_direction() != Vector2.ZERO:
		owner.last_direction = get_move_direction()
