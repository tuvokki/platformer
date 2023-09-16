extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		else:
			velocity.y = JUMP_VELOCITY * 2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	var collision = get_last_slide_collision()
	if collision:
		if collision.get_collider().is_in_group("diamonds"):
			print("Player hit: " + collision.get_collider().name)
			collision.get_collider().queue_free()
			Game.add_score()
		elif collision.get_collider().is_in_group("keys"):
			print("Player hit: " + collision.get_collider().name)
			collision.get_collider().queue_free()
			Game.add_key()
		elif collision.get_collider().is_in_group("locks"):
			print("Player hit: " + collision.get_collider().name)
			Game.add_lock()
		elif collision.get_collider().is_in_group("waters"):
			Game.lost()
		elif collision.get_collider().name == "TileMap":
			pass
		else:
			print("Player hit: " + collision.get_collider().name)
