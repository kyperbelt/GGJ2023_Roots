extends Node2D

class_name SappyWorld

signal wind_started(wind_velocity)
signal wind_ended()

@export
var _wind_velocity:= 0.0

@export_range(1,100,1, "or_greater")
var wind_duration := 1.0
var wind_elapsed := 0.0
var is_windy := false

func _ready():		
	var vroot = get_tree().get_nodes_in_group("player")[0]
	print(vroot)
	var err = wind_started.connect(vroot.set_wind, CONNECT_DEFERRED)
	if (err != OK):
		print("wind_started connect error: ", err)
	wind_ended.connect(vroot.set_wind.bind(0), CONNECT_DEFERRED)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("wind_enable"):
		print("wind enable")
		set_windy(!is_windy)
	
	if is_windy:
		wind_elapsed += delta
		if (wind_elapsed >= wind_duration):
			wind_elapsed = 0.0
			set_windy(false)


func set_windy(windy := false):
	is_windy = windy
	if is_windy:
		wind_started.emit(_wind_velocity)
	else:
		wind_ended.emit()
