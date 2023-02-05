extends State 

class_name FlourishState

var flourish_elapsed : float= 0

func enter(player: Vroot):
    player.get_node("SproutSound").play()
    super.enter(player)
    # TODO: animation of flourish starts here
    print("Flourish")

func update(delta: float):

    flourish_elapsed+=delta

    if flourish_elapsed > _player.flourish_duration:
        flourish_elapsed = 0
        # TODO animation of flourish ends here
        print("Flourish end")
        _player.position.y -= _player.max_height * _player.growth_alpha
        _player.set_state(_player.States.Idle)
        _player.flourished.emit(_player.position)

