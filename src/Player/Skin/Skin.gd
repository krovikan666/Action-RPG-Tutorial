extends Node2D

signal animation_finished(name)

export var start_frame: = 18

onready var anim: AnimationPlayer = $AnimationPlayer
onready var sprite: Sprite = $Sprite


func _ready() -> void:
	sprite.frame = start_frame


func play(anim_name: String) -> void:
	if anim_name == anim.current_animation:
		return
	if anim_name in anim.get_animation_list():
		anim.stop()
		anim.play(anim_name)


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	emit_signal("animation_finished", anim_name)
