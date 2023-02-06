extends Area2D

class_name BoidArea2D

# https://www.youtube.com/watch?v=oFnIlNW_p10
 
@onready var rayFolder := $rayFolder.get_children()
var boidsISee := []
var vel := Vector2.ZERO
var speed := 7.0
var screensize : Vector2
var movv := 48

var player: Vroot

func setPlayer(worldPlayer: Vroot):
	player = worldPlayer
	self.global_position = player.position


# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport_rect().size
	vel.x = 1
	vel.y = 1
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta: float) -> void:
	boids()
	checkCollision()
	vel = vel.normalized() * speed
	move()
	rotation = lerp_angle(rotation, vel.angle_to_point(Vector2.ZERO), 0.4)
	
func boids():
	if boidsISee:
		var numOfBoids := boidsISee.size()
		var avgVel := Vector2.ZERO
		var avgPos := Vector2.ZERO
		var steerAway := Vector2.ZERO
		
		for boid in boidsISee:
			avgVel += boid.vel
			avgPos += boid.position
			# If the boidISee is close to this boid, move away... this calculation's value is small when far away and very big when very close
			steerAway -= (boid.global_position - global_position) * (movv/(global_position - boid.global_position).length())
			
		avgVel /= numOfBoids
		vel += (avgVel - vel) /2
		
		avgPos /= numOfBoids
		vel += (avgPos - position)
		
		steerAway /= numOfBoids
		vel += steerAway
		
	
func checkCollision():
	for ray in rayFolder:
		var r : RayCast2D = ray
		if r.is_colliding():
			# "blocks" is the tutorial's wall pixels
			if r.get_collider().is_in_group("blocks"):
				var magi := 100/(r.get_collision_point() - global_position).length_squared()
				vel -= (r.cast_to.rotated(rotation)* magi)
			
	
func move():
	#stay close
	if( global_position.y > player.global_position.y ):
		vel.y = abs(vel.y) * -1

	if( global_position.y < player.global_position.y - 300 ):
		vel.y = abs(vel.y)
	
	if( global_position.x > player.global_position.x + 150 ):
		vel.x = abs(vel.x) * -1
	
	if( global_position.x < player.global_position.x - 150 ):
		vel.x = abs(vel.x)
	
	global_position += vel
	

func _on_vision_area_2d_area_entered(area: Area2D):
	if area != self and area.is_in_group("boid"):
		boidsISee.append(area)


func _on_vision_area_2d_area_exited(area: Area2D):
	if area:
		boidsISee.erase(area)
