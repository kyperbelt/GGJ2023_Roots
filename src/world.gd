extends Node2D

class_name SappyWorld

signal wind_started(wind_velocity)
signal wind_ended()

var floursih_platform: PackedScene = preload("res://src/flourish_platform.tscn")
var growth_animation: PackedScene = preload("res://src/tree_growth.tscn")

@export
var _wind_velocity:= 0.0

@export_range(1,100,1, "or_greater")
var wind_duration := 1.0
var wind_elapsed := 0.0
var is_windy := false

var tree_animation: AnimationPlayer
var tree
var player : Vroot

func _ready():		
	var vroot = get_tree().get_nodes_in_group("player")[0]
	vroot.flourished.connect(flourish_platform)
	vroot.growth_started.connect(grow_start)
	vroot.growth_finished.connect(grow_finished)

	player = vroot


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


func flourish_platform(position_passed: Vector2):
	var platform = floursih_platform.instantiate()
	platform.z_index = -1
	add_child(platform)
	tree.on_animation_finished()
	platform.position = position_passed

func grow_start():
	print("grow start")
	tree = growth_animation.instantiate()
	var animation_player = tree.get_node("AnimationPlayer")
	tree.z_index = 1
	tree.position = player.position
	add_child(tree)
	animation_player.play("trunk_growth")
	tree_animation = animation_player
	tree_animation.speed_scale /= player._standing_still_max

func grow_finished():
	print("grow end")
	tree_animation.pause()
