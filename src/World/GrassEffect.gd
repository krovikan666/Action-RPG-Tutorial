extends Node2D

onready var anim: AnimatedSprite = $AnimatedSprite
onready var collision: CollisionShape2D = $Hurtbox/CollisionShape2D


func _on_AnimatedSprite_animation_finished():
	if anim.animation == "destroy":
		queue_free()


func _on_Hurtbox_area_entered(_area: Area2D):
	collision.disabled = true
	anim.play("destroy")
