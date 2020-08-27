extends State

export var default_direction: = Vector2.DOWN

var attack_direction: = default_direction


func _on_Skin_anaimaition_finsihed(_anim_name: String) -> void:
	_state_machine.transition_to("Move/Idle")


func enter(msg: Dictionary = {}) -> void:
	if msg.has("direction"):
		attack_direction = msg.direction
	owner.sword_collision.disabled = false

	owner.play_animation(attack_direction, "attack")
	owner.skin.connect("animation_finished", self, "_on_Skin_anaimaition_finsihed")


func exit() -> void:
	attack_direction = default_direction
	owner.sword_collision.disabled = true
	owner.skin.disconnect("animation_finished", self, "_on_Skin_anaimaition_finsihed")

