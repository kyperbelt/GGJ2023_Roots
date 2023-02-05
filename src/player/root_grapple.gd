### https://gitlab.com/godotdemos/hook-demo/-/blob/master/Chain.gd
extends Node2D

### How hard the grapple pulls the character
@export 
var grapple_pull_foce := 100

### how fast the grappling hook moves
@export
var grapple_speed := 50

@onready
var _mid_section = $mid_section
var _direction := Vector2()
var _true_global_position := Vector2()

@onready 
var _tip = $tip

var _grappling := false
var _hooked := false

func get_true_global_position():
    return _true_global_position

func shoot(direction: Vector2):
    _direction = direction.normalized()
    _grappling = true 
    _true_global_position= self.global_position

func release():
    _grappling = false
    _hooked = false

func _process(_delta):
    self.visible = _grappling || _hooked
    if !self.visible:
        return
    
    var tip_location = to_local(_true_global_position)

    _mid_section.rotation = self.position.angle_to_point(tip_location) - PI/2
    _tip.rotation = self.position.angle_to_point(tip_location) - PI/2
    _mid_section.position = tip_location
    _mid_section.region_rect.size.y = tip_location.length()


func _physics_process(_delta):
    _tip.global_position = _true_global_position
    if _grappling:
        if _tip.move_and_collide(_direction * grapple_speed * _delta):
            _grappling = false
            _hooked = true
        else:
            _true_global_position = _tip.global_position


func _ready():
    add_to_group("grapple")