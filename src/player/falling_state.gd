extends State

class_name FallingState

func enter(player: Vroot):
    super.enter(player)
    # player.set_animation("falling")

func update(delta: float):
    var vroot = self._player

    if vroot.is_on_floor():
        vroot.set_state(Vroot.States.Idle)
