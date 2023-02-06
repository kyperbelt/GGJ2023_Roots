extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_area_entered)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area:Area2D):
	if "player" in area.get_groups():
		self.get_tree().change_scene_to_file("res://src/TitleScreen.tscn")
		pass
	pass # Replace with function body.
