extends CharacterBody2D

class_name Vroot

enum States{
	Idle,
	Growing, 
	Flourish, 
	Moving,
	Falling
}

signal flourished(location: Vector2)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the _gravity from the project settings to be synced with RigidBody nodes.
var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var growth_alpha :float = 0.0
# create a mechanic for when the player is standing still, the longer he stands still the slower he moves
# until a max where he can't move at all
var _standing_still_elapsed:= 0.0

var standing_still_alpha := 0.0
@export
var flourish_duration:= 1.0
@export
var max_height := 100
var initial_growth_y:=0.0

@export
var _standing_still_max:= 3.0
@export_range(0.1,1.0,0.1)
var _wind_threshold:= 0.5

var _wind := 0.0 

var _current_state : State

var _state_map := {
	States.Idle: IdleState.new(),
	States.Growing: GrowingState.new(),
	States.Flourish: FlourishState.new(),
	States.Moving: MovingState.new(),
	States.Falling: FallingState.new()
}

@onready
var animation_player := $AnimationPlayer

func _ready():
	add_to_group("player")
	set_state(States.Idle)

func _physics_process(delta):
	# Add the _gravity.
	if not is_on_floor():
		velocity.y += _gravity * delta

	# # Handle Jump.
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	# 	velocity.y = JUMP_VELOCITY

	# if Input.is_action_pressed("move_down"):
	# 	_standing_still_elapsed += delta
	# 	print("rooting")
	# else: 
	#  _standing_still_elapsed  = 0.0

	_standing_still_elapsed = clamp(_standing_still_elapsed, 0, _standing_still_max)
	standing_still_alpha = _standing_still_elapsed/_standing_still_max
	var progress_bar : TextureProgressBar = $ProgressBar
	progress_bar.value = standing_still_alpha * progress_bar.max_value
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var direction = Input.get_axis("move_left", "move_right")
	# if direction:
	# 	$icon.flip_h = direction < 0
	# 	var cur_scale = progress_bar.scale.x
	# 	progress_bar.scale.x *= -1 if ($icon.flip_h && cur_scale > 0  )|| (!$icon.flip_h && cur_scale < 0) else 1
	# 	var rooted := false
	# 	if standing_still_alpha > 0: 
	# 		rooted = true
		
	# 	if !rooted:
	# 		velocity.x = direction * SPEED #(1.0 - get_movement_multiplier(_standing_still_elapsed/standing_still_max))
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, SPEED)


	# if velocity.x == 0:
	# 	animation_player.play("RESET")
	# else: 
	# 	animation_player.play("move")
		
	if _current_state:
		_current_state.update(delta)

	if _wind > 0 && standing_still_alpha < _wind_threshold:
		velocity.x = _wind

	move_and_slide()

func set_state(state: States):
	_current_state = _state_map[state]
	_current_state.enter(self)

func get_movement_multiplier(alpha: float)->float:
	return 1.0 - (1.0 - alpha * 0.9) * (1.0 - alpha * 0.9)

func set_wind(wind: float):
	print("wind was set to " + str(wind) + "")
	_wind = wind

