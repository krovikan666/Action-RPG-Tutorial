extends Area2D

signal invivibility_started
signal invivibility_ended

export var hit_effect_scene: PackedScene
export var hit_offset: = Vector2(0,8)

onready var collision: CollisionShape2D = $CollisionShape2D
onready var timer: Timer = $Timer

var is_invincible: = false setget set_is_invincible


func set_is_invincible(value: bool) -> void:
	is_invincible = value
	if is_invincible:
		emit_signal("invivibility_started")
	else:
		emit_signal("invivibility_ended")


func start_invivibility(duration: float) -> void:
	self.is_invincible = true
	timer.start(duration)


func create_hit_effect() -> void:
	var effect: Node = hit_effect_scene.instance()
	var main: Node = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position - hit_offset


func _on_Hurtbox_invivibility_started() -> void:
	collision.set_deferred("disabled", true)


func _on_Hurtbox_invivibility_ended() -> void:
	collision.disabled = false


func _on_Timer_timeout() -> void:
	self.is_invincible = false
