extends State

class_name GrowingState

func update(delta: float):
    if Input.is_action_pressed("move_down"):
        _player._standing_still_elapsed += delta
    else: 
        _player._standing_still_elapsed = 0
        _player.set_state(_player.States.Flourish)

