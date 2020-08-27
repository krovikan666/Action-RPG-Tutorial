extends Control

onready var hearts_ui_empty: TextureRect = $HeartUIEmpty
onready var hearts_ui_full: TextureRect = $HeartUIFull

var max_hearts: = 4 setget set_max_hearts
var hearts: = 4 setget set_hearts


func set_hearts(value: int) -> void:
	# warning-ignore:narrowing_conversion
	hearts = clamp(value, 0, max_hearts)
	if hearts_ui_full != null:
		hearts_ui_full.rect_size.x = hearts * 15


func set_max_hearts(value: int) -> void:
	max_hearts = value
	if hearts_ui_empty != null:
		hearts_ui_empty.rect_size.x = max_hearts * 15

	# warning-ignore:narrowing_conversion
	self.hearts = min(hearts, max_hearts)


func _ready() -> void:
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health

	# warning-ignore:return_value_discarded
	PlayerStats.connect("health_changed", self, "set_hearts")

	# warning-ignore:return_value_discarded
	PlayerStats.connect("max_health_changed", self, "set_max_hearts")
