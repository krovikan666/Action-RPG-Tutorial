extends Area2D


var player: KinematicBody2D = null


func can_see_player() -> bool:
	return player != null


func _on_PlayerDetectionZone_body_entered(body: Node) -> void:
	if body is KinematicBody2D:
		player = body


func _on_PlayerDetectionZone_body_exited(body: Node) -> void:
	if body is KinematicBody2D:
		player = null
