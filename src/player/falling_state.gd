extends State

class_name FallingState

func enter(player: Vroot):
    super.enter(player)
    player.velocity.x *=.3
    # player.set_animation("falling")

func update(delta: float):
    var vroot = self._player

    if Input.is_action_pressed("grapple"):
        vroot.set_state(Vroot.States.Grappling)
        return

    if vroot.is_on_floor():
        vroot.set_state(Vroot.States.Idle)
        vroot.velocity.x = 0
