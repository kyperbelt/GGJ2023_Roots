extends CharacterBody2D

class_name Vroot

enum States{
	Idle,
	Growing, 
	Flourish, 
	Moving,
	Falling,
	Grappling
}

signal flourished(location: Vector2)
signal growth_started
signal growth_finished

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready
var camera := $Camera2D

# Get the _gravity from the project settings to be synced with RigidBody nodes.
var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var growth_alpha :float = 0.0
# create a mechanic for when the player is standing still, the longer he stands still the slower he moves
# until a max where he can't move at all
var _standing_still_elapsed:= 0.0

var standing_still_alpha := 0.0

@export
var step_latency := 0.2
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
	States.Falling: FallingState.new(),
	States.Grappling : GrapplingState.new()
}

@onready
var animation_player := $AnimationPlayer

@onready
var _grass_step_sounds:= $GrassStepSounds
var current := 0

@onready
var grapple := $root_grapple

func _ready():
	add_to_group("player")
	set_state(States.Idle)

func _physics_process(delta):
	# Add the _gravity.
	if not is_on_floor():
		velocity.y += _gravity * delta

	_standing_still_elapsed = clamp(_standing_still_elapsed, 0, _standing_still_max)
	standing_still_alpha = _standing_still_elapsed/_standing_still_max
	var progress_bar : TextureProgressBar = $ProgressBar
	progress_bar.value = standing_still_alpha * progress_bar.max_value
		
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

func play_step_sound():
	if current >= _grass_step_sounds.get_child_count():
		current = 0
	_grass_step_sounds.get_child(current).play()
	current += 1
