extends CharacterBody2D

@export var SPEED = -60.0

@onready var anim = $AnimatedSprite2D

var facing_right = false

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if !$RaycastDown.is_colliding() && is_on_floor or $RaycastDir.is_colliding():
		flip()
	
	velocity.x = SPEED
	
	animation_handler()
	
	move_and_slide()

func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		SPEED = abs(SPEED)
	else:
		SPEED = abs(SPEED) *-1
		
func animation_handler():
	anim.play("Run")
