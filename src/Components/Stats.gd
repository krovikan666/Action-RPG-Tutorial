extends Node2D

signal health_changed(value)
signal max_health_changed(value)
signal no_health

export var after_hit_protection = 0.5
export var start_health: = 1

onready var max_health: int = start_health setget set_max_health
onready var health: int = max_health setget set_health


func reset_stats() -> void:
	self.max_health = start_health
	self.health = max_health


func set_health(value: int) -> void:
	health = value
	emit_signal("health_changed", health)

	if health <= 0:
		emit_signal("no_health")

func set_max_health(value: int) -> void:
	# warning-ignore:narrowing_conversion
	max_health = max(1, value)
	emit_signal("max_health_changed", max_health)

	if health:
		# warning-ignore:narrowing_conversion
		self.health = min(health, max_health)
