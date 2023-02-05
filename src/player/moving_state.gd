extends State 

class_name MovingState

var step_interval = 0.2
var step_timer = 0.0

func enter(player: Vroot):
    super.enter(player)
    _player.animation_player.play("move")
    _player.play_step_sound()

func update(_delta : float):
    if Input.is_action_just_pressed("move_down"):
        _player.velocity.x = 0
        _player.set_state(Vroot.States.Idle)
        return
    if !_player.is_on_floor():
        _player.set_state(Vroot.States.Falling)
        return

    if Input.is_action_pressed("grapple"):
        _player.set_state(Vroot.States.Grappling)
        return

    var direction = Input.get_axis("move_left", "move_right")
    step_timer += _delta
    if step_timer > step_interval:
        step_timer = 0.0
        _player.play_step_sound()
    if direction:
        var icon:Sprite2D = _player.get_node("icon")
        icon.flip_h = direction < 0
        _player.velocity.x = direction * _player.SPEED #(1.0 - get_movement_multiplier(_standing_still_elapsed/standing_still_max))
    else:
        _player.velocity.x = move_toward(_player.velocity.x, 0, _player.SPEED)
    if _player.velocity.x == 0:
        _player.set_state(Vroot.States.Idle)

