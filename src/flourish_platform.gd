extends StaticBody2D


@export
var max_duration:= 1.0
var _elapsed_duration := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("flourish_platform")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	_elapsed_duration += delta
	if _elapsed_duration > max_duration:
		queue_free()
	pass
