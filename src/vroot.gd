extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# create a mechanic for when the player is standing still, the longer he stands still the slower he moves
# until a max where he can't move at all
var standing_still_elapsed:= 0.0
var standing_still_max := 3.0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if velocity.y == 0:
		if velocity.x == 0:
			standing_still_elapsed += delta
		else: 
			standing_still_elapsed -= delta

	standing_still_elapsed = clamp(standing_still_elapsed, 0, standing_still_max)
	var standing_still_alpha = standing_still_elapsed/standing_still_max
	$ProgressBar.ratio = standing_still_alpha
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		$icon.flip_h = direction < 0
		velocity.x = direction * SPEED * (1.0 - get_movement_multiplier(standing_still_elapsed/standing_still_max))
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		


	move_and_slide()


func get_movement_multiplier(alpha: float)->float:
	return 1.0 - (1.0 - alpha * 0.9) * (1.0 - alpha * 0.9)