class_name State 

var player: Vroot
var transitions:={}

func add_transition(predicate: Callable, state : State):
    transitions[predicate] = state 

func _internal_update(delta: float):
    for predicate in transitions.keys():
        if predicate.call() as bool:
            player.set_state(transitions[predicate])
    update(delta)

func update(delta: float):
    pass
