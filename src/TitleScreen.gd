extends Node2D
@export
var target_scene:= "res://src/world.tscn"
var start_texture_button
# Called when the node enters the scene tree for the first time.
func _ready():
	start_texture_button = TextureButton.new()
	start_texture_button.position = Vector2(0, 0)
	start_texture_button.normal_texture = load("res://image/Root (New)/Sapling/RootSpriteFix.png")
	start_texture_button.pressed_texture = load("res://image/Root (New)/Sapling/SaplingRooting.png")
	start_texture_button.connect("pressed", self, "_on_texture_button_pressed")
	add_child(start_texture_button)

func _on_start_button_pressed():
	get_tree().change_scene(target_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
