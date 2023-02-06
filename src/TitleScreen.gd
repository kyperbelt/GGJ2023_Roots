extends Node2D

@export
var target_scene:String= "res://src/world.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_texture_button_pressed():
	var get_texture_button = get_node("start_texture_button")
	var leaf_particle = get_node("leaf_particle")
	var player = leaf_particle.get_node("AnimationPlayer")
	get_texture_button.visible = false
	player.play("blowing")
	await player.animation_finished
	get_tree().change_scene_to_file(target_scene)



func _on_exit_pressed():
	get_tree().quit()
