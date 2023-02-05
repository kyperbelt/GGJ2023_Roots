extends State 

class_name MovingState


func enter(player: Vroot):
    super.enter(player)
    _player.animation_player.play("move")

func update(_delta : float):
    if Input.is_action_just_pressed("move_down"):
        _player.velocity.x = 0
        _player.set_state(Vroot.States.Idle)
        return
    if !_player.is_on_floor():
        _player.set_state(Vroot.States.Falling)
        return
    var direction = Input.get_axis("move_left", "move_right")
    if direction:
        var icon:Sprite2D = _player.get_node("icon")
        icon.flip_h = direction < 0
        _player.velocity.x = direction * _player.SPEED #(1.0 - get_movement_multiplier(_standing_still_elapsed/standing_still_max))
    else:
        _player.velocity.x = move_toward(_player.velocity.x, 0, _player.SPEED)
    if _player.velocity.x == 0:
        _player.set_state(Vroot.States.Idle)

