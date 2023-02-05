extends State 

class_name GrapplingState

var _grappling_velocity:= Vector2(0, 0)
var _direction := Vector2(0, 0)
var grapple

func enter(player: Vroot):
	super.enter(player)
	var mouse_pos = _player.get_global_mouse_position()
	_direction = _player.to_local(mouse_pos).normalized()
	grapple = _player.grapple
	grapple.shoot(_player.to_local(mouse_pos))
	print("position: ", mouse_pos)
	pass

func update(delta: float):
	if !Input.is_action_pressed("grapple"):
		_player.set_state(Vroot.States.Idle)
		grapple.release()
		return

	var move_direction = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	if !_player.is_on_floor():
		move_direction = 0;
	
	if grapple._hooked:
		_grappling_velocity = _player.to_local(grapple.get_true_global_position()).normalized() * grapple.grapple_pull_foce

		if _grappling_velocity.y > 0:
			_grappling_velocity.y *= 0.5 
		else:
			_grappling_velocity.y *= 1.6

		if sign(_grappling_velocity.x) != sign(move_direction):
			_grappling_velocity.x *= 0.6
		
	else: 
		_grappling_velocity = Vector2(0, 0)

	_player.velocity += _grappling_velocity
	_player.velocity.x += move_direction * Vroot.SPEED * delta
	
	if move_direction == 0:
		_player.velocity.x *= 0.9
	

	pass
