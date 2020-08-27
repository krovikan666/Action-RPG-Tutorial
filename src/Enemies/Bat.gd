extends KinematicBody2D

export var knockback_friction: = 200
export var knockback_force: = 120

onready var anim: AnimatedSprite = $Sprite
onready var blink_anim: AnimationPlayer = $BlinkAnimationPlayer
onready var death_sound: AudioStreamPlayer = $AudioStreamPlayer
onready var hurtbox: Area2D = $Hurtbox
onready var hurtbox_collision: CollisionShape2D = $Hurtbox/CollisionShape2D
onready var player_detector: Area2D = $PlayerDetectionZone
onready var soft_collision: Area2D = $SoftCollision
onready var stats: Node2D = $Stats

onready var start_position: Vector2 = global_position

var knockback = Vector2.ZERO


func _physics_process(delta: float) -> void:
	knockback = knockback.move_toward(Vector2.ZERO, knockback_friction * delta)
	knockback = move_and_slide(knockback)


func _on_Hurtbox_area_entered(area: Area2D) -> void:
	stats.health -= area.damage
	knockback = area.knockback_vector * knockback_force

	hurtbox.start_invivibility(stats.after_hit_protection)
	hurtbox.create_hit_effect()


func _on_Hurtbox_invivibility_ended() -> void:
	blink_anim.play("stop")


func _on_Hurtbox_invivibility_started() -> void:
	blink_anim.play("start")


func _on_Sprite_animation_finished() -> void:
	if anim.animation == "death":
		queue_free()


func _on_Stats_no_health() -> void:
	hurtbox_collision.set_deferred("disabled", true)
	death_sound.play()
	anim.play("death")
