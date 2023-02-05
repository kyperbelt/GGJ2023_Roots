extends State

class_name IdleState

func enter(player):
    super.enter(player)
    player.animation_player.play("RESET")
    print("IdleState")

func update(_delta: float):
    if Input.is_action_pressed("move_down"):
        _player.set_state(Vroot.States.Growing)
        return

    var direction = Input.get_axis("move_left", "move_right")
    if direction != 0:
        _player.set_state(Vroot.States.Moving)