extends State

export var default_direction: = Vector2.DOWN
export var roll_speed: = Vector2(100, 100)

onready var move: State = get_parent()

var roll_direction: = default_direction


func _on_Skin_anaimaition_finsihed(_anim_name: String) -> void:
	_state_machine.transition_to("Move/Idle")


func physics_process(_delta: float) -> void:
	move.velocity = Movement.calculate_velocity(
		move.velocity, 
		roll_speed, 
		roll_speed, 
		roll_direction)
	move.velocity = owner.move_and_slide(move.velocity)


func enter(msg: Dictionary = {}) -> void:
	if msg.has("direction"):
		roll_direction = msg.direction

	owner.play_animation(roll_direction, "roll")
	owner.skin.connect("animation_finished", self, "_on_Skin_anaimaition_finsihed")


func exit() -> void:
	roll_direction = default_direction
	owner.skin.disconnect("animation_finished", self, "_on_Skin_anaimaition_finsihed")
