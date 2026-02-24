extends CharacterBody2D

const SPEED = 300.0

@onready var gun: CharacterBody2D = $Gun
@export var bullet_scene: PackedScene

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX := Input.get_axis("ui_left", "ui_right")
	var directionY := Input.get_axis("ui_up", "ui_down")
	
	var direction = Vector2(directionX, directionY)
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	var to_mouse = get_global_mouse_position() - position
	
	if to_mouse.length() < 0.165:
		to_mouse = Vector2(0,-1)
	
	var mouse_direction = to_mouse.normalized()
	
	gun.global_position = gun.global_position.lerp(global_position + 75 * mouse_direction, 0.19)
	
	gun.global_rotation = lerp_angle(gun.global_rotation, mouse_direction.angle() + deg_to_rad(90), 0.19)
	
	if Input.is_action_pressed("shoot"):
		var bullet = bullet_scene.instantiate()
		var gun_tip_offset = Vector2(0, 0)
		
		bullet.global_position = gun.global_position + gun_tip_offset
		
		bullet.direction = mouse_direction
		
		get_tree().current_scene.add_child(bullet)
		
	move_and_slide()


#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
