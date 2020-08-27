extends KinematicBody2D

export var hurt_sound: PackedScene

onready var blink_anim: AnimationPlayer = $PlayerSkin/BlinkAnimationPlayer
onready var collider: CollisionShape2D = $CollisionShape2D
onready var hurtbox: Area2D = $Hurtbox
onready var skin: Node2D = $PlayerSkin
onready var state_machine: StateMachine = $StateMachine
onready var sword_collision: CollisionShape2D = $HitboxPivot/SwordHitbox/CollisionShape2D
onready var sword_hitbox: Area2D = $HitboxPivot/SwordHitbox
onready var sword_pivot: Position2D = $HitboxPivot

var is_active: = true setget set_is_active
var last_direction: = Vector2.DOWN


func _ready() -> void:
	# warning-ignore:return_value_discarded
	PlayerStats.connect("no_health", self, "queue_free")


func set_is_active(value: bool) -> void:
	is_active = value
	
	if not collider:
		return
	collider.disabled = not value


func play_animation(direction: Vector2, type: String) -> void:
	if direction.y > 0:
		skin.play(type + "_down")
		sword_pivot.rotation_degrees = 90 
	elif direction.y < 0:
		skin.play(type + "_up")
		sword_pivot.rotation_degrees = -90
	elif direction.x < 0:
		skin.play(type + "_left")
		sword_pivot.rotation_degrees = 180
	else:
		skin.play(type + "_right")
		sword_pivot.rotation_degrees = 0


func _on_Hurtbox_area_entered(area: Area2D)  -> void:
	if not hurtbox.is_invincible:
		PlayerStats.health -= area.damage

		hurtbox.start_invivibility(PlayerStats.after_hit_protection)
		hurtbox.create_hit_effect()

	var sound = hurt_sound.instance()
	get_tree().current_scene.add_child(sound)


func _on_Hurtbox_invivibility_started()  -> void:
	blink_anim.play("start")


func _on_Hurtbox_invivibility_ended() -> void:
	blink_anim.play("stop")
