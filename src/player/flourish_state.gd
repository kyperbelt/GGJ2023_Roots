extends State 

class_name FlourishState

var flourish_elapsed : float= 0

func enter(player: Vroot):
    super.enter(player)
    print("Flourish")

func update(delta: float):

    flourish_elapsed+=delta

    if flourish_elapsed > _player.flourish_duration:
        flourish_elapsed = 0
        print("Flourish end")
        _player.position.y -= _player.max_height * _player.growth_alpha
        _player.set_state(_player.States.Idle)

