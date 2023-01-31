extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():

	update_name()
	pass # Replace with function body.


func update_name():
	$nameplate.text = "Hello world!"	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$nameplate.text = "Hello world!"

	if Input.is_action_pressed("move_down"):
		$nameplate.text = "moving_down"
