

extends CharacterBody2D




const SPEED = 200.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	if is_on_floor():
		if direction == 0:
			if (Global.has_slime == false):
				animated_sprite.play("idle")
			else:
				animated_sprite.play("slimedle")
		else:
			if (Global.has_slime == false):
				animated_sprite.play("walk_cycle")
			else:
				animated_sprite.play("slime_cycle")
	else:
		if (Global.has_slime == false):
			animated_sprite.play("jump")
		else:
			animated_sprite.play("slime_jump")

	move_and_slide()
	



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("keys"):
		area.queue_free()
	if area.is_in_group("SlimePal"):
		Global.has_slime = true





		
