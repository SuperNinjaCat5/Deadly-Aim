extends Area2D

@export var speed = 600
var direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

	if position.distance_to(get_viewport().get_visible_rect().size / 2) > 2000:
		queue_free()
