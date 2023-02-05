extends State

class_name GrowingState

func enter(player: Vroot):
	super.enter(player)
	_player.initial_growth_y = _player.position.y
	print("entering growing state")


func update(delta: float):
	if !_player.is_on_floor():
		_player.set_state(_player.States.Falling)
		return

	if Input.is_action_pressed("move_down"):
		_player._standing_still_elapsed += delta
		var platforms = _player.get_tree().get_nodes_in_group("flourish_platform")
		for platform in platforms:
			platform.queue_free()
			return
	else: 
		_player.growth_alpha = clamp(_player.standing_still_alpha, 0, 1)
		_player._standing_still_elapsed = 0
		_player.set_state(_player.States.Flourish)







