extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	
	if is_on_floor():
			anim.play("Idle")
	if not is_on_floor():	
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			jump()

	if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		var direction := Input.get_axis("Left", "Right")
		run(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	

func jump():
	anim.play("Jump")
	velocity.y = JUMP_VELOCITY
	
	
func run(direction):
	if is_on_floor():
		anim.play("Run")
	
	velocity.x = direction * SPEED
	
