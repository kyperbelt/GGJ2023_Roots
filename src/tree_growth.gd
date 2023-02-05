extends Node2D

@export
var duration = 1.0
var elapsed = 0.0
var animation_finished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !animation_finished:
		return

	elapsed+=delta
	if elapsed>duration:
		elapsed=0
		queue_free()
	pass


func on_animation_finished():
	animation_finished = true
	print("ANIMATION FINISHED")
