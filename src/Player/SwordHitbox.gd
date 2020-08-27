extends Hitbox

var knockback_vector: = Vector2.ZERO setget ,get_vector


func get_vector() -> Vector2:
	return owner.last_direction
