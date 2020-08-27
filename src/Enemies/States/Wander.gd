extends State

export var min_timer: = 3
export var max_timer: = 6
export var wander_range: = 32

onready var move: State = get_parent()
onready var timer: Timer = $Timer

var target_position: Vector2


func physics_process(delta: float) -> void:
	if owner.player_detector.can_see_player():
		_state_machine.transition_to("Move/Chase")
		return 

	var move_direction: Vector2 = move.get_move_direction(target_position)
	move.move(move_direction, delta)


func enter(_msg: Dictionary = {}) -> void:
	update_target_position()
	timer.start()


func exit() -> void:
	timer.stop()


func update_target_position() -> void:
	var target_vector: = Vector2(
		rand_range(-wander_range, wander_range), 
		rand_range(-wander_range, wander_range)
	)
	target_position = owner.start_position +  target_vector


func _on_Timer_timeout() -> void:
	update_target_position()
	timer.wait_time = rand_range(min_timer, max_timer)




