extends Node2D

@export var rest_lenght = 2.0
@export var stiffness = 10.0
@export var damping = 2.0

@onready var player := get_parent()
@onready var ray := $RayCast2D
@onready var rope := $Line2D

var launched = false
var target: Vector2

func _process(delta: float) -> void:
	
	ray.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("Shoot"):
		launch()
	if Input.is_action_just_released("Shoot"):
		retract()
	if launched:
		handle_grapple(delta)
func launch():
	if ray.is_colliding():
		launched = true
		target = ray.get_collision_point()
		rope.show()
		
func retract():
	launched = false
	rope.hide()

func handle_grapple(delta):
	var target_dir = player.global_position.direction_to(target)
	var target_dist = player.global_position.distance_to(target)
	
	var displacement = target_dist - rest_lenght
	
	var force = Vector2.ZERO
	
	if displacement > 0:
		var spring_forse_magnitude = stiffness * displacement
		var spring_forse = target_dir * spring_forse_magnitude
		
		var vel_dot = player.velocity.dot(target_dir)
		var damping = -damping * vel_dot * target_dir
		
		force = spring_forse + damping
		
	player.velocity += force * delta
	update_rope()
func update_rope():
	rope.set_point_position(1, to_local(target))
