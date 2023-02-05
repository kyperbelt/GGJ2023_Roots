extends State

class_name GrowingState

func enter(player: Vroot):
	super.enter(player)
	_player.initial_growth_y = _player.position.y
	print("entering growing state")


func update(delta: float):
	if Input.is_action_pressed("move_down"):
		_player._standing_still_elapsed += delta
	else: 
		_player.growth_alpha = clamp(_player.standing_still_alpha, 0, 1)
		_player._standing_still_elapsed = 0


