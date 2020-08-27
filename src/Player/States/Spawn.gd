extends State

export var start_position: = Vector2(160, 90)


func _on_Skin_animation_finsihed(_anim_name: String) -> void:
	_state_machine.transition_to("Move/Idle")


func enter(_msg: Dictionary = {}) -> void:
	owner.position = start_position
	owner.is_active = false

	owner.skin.play("spawn")
	owner.skin.connect("animation_finished", self, "_on_Skin_animation_finsihed")


func exit() -> void:
	owner.is_active = true

	owner.skin.disconnect("animation_finished", self, "_on_Skin_animation_finsihed")
