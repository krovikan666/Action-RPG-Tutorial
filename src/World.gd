extends Node2D

onready var player: KinematicBody2D = $YSort/Player


func _ready() -> void:
	randomize()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_restart"):
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
		PlayerStats.reset_stats()
	if event.is_action_pressed("debug_spawn") and player != null:
		player.state_machine.transition_to("Spawn")
		PlayerStats.reset_stats()
	if event.is_action_pressed("debug_die"):
		PlayerStats.emit_signal("no_health")
