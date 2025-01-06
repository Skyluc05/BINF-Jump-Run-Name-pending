extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var Coyote_timer = $Coyote_Timer

@export var Jump_Buffer_Time = 0.1
@export var Coyote_Time = 0.5 

const SPEED = 300.0
const JUMP_VELOCITY = -400
const ACCELERATION = 0.1
const DECELERATION = 0.1

var Jump_Buffer = false
var Jump_Available = true

func _physics_process(delta: float) -> void:

	if not is_on_floor():	
		if Jump_Available:
			get_tree().create_timer(Coyote_Time).timeout.connect(Coyote_Timeout)
			
		velocity += get_gravity() * delta
	else:
		Jump_Available = true
		
	
	if Input.is_action_just_pressed("Jump"):
			jump()

	var direction := Input.get_axis("Left", "Right")
	run(direction)
	
	var was_on_floor = is_on_floor()

	move_and_slide()
		
	handle_animation(direction)
	
func _input(event):
	if event.is_action_released("Jump"):
		if velocity.y < 0.0:
			velocity.y *= 0.5
	
func handle_animation(direction):
	handle_sprite_flip(direction)
	if is_on_floor():
		if velocity:
			anim.play("Run")
		else:
			anim.play("Idle")
	else:
		if velocity.y < 0.0:
			anim.play("Jump")
		else:
			anim.play("Fall")
			
		
func handle_sprite_flip(direction):
	if direction == 1:
		anim.flip_h = false
	if direction == -1:
		anim.flip_h = true

func jump():
	if Jump_Available:
		velocity.y = JUMP_VELOCITY
		Jump_Available = false
	else:
		Jump_Buffer = true
		get_tree().create_timer(Jump_Buffer_Time).timeout.connect(on_jump_buffer_timer)
		
func Coyote_Timeout():
	Jump_Available = false
		
func on_jump_buffer_timer():
	Jump_Buffer = false	
	
func run(direction):
	if Input.is_action_pressed("Left") or Input.is_action_pressed("Right") or Jump_Buffer:
		velocity.x = lerp(velocity.x, SPEED * direction, ACCELERATION)
	else:
		velocity.x = 0
