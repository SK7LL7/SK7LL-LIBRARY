extends CharacterBody2D

# CODE FOR GODOT 4.2.1 - SK7LL

# CHARACTER-VALUES
const UP : Vector2 = Vector2(0, -1)
const GRAVITY : float = 20
const SPEED : float = 100
const RUNNING_SPEED : float = 200
const JUMP_HEIGHT : float = -500

# CHARACTER-MOTION
var current_speed : float = SPEED

# CHARACTER
@onready var character = $SPRITE
@onready var characterAnimation = $AnimationPlayer

func _physics_process(_delta):
	velocity.y += GRAVITY

	# CHARACTER-INPUT
	if Input.is_action_pressed("RIGHT"):
		velocity.x = current_speed
		character.flip_h = false
	elif Input.is_action_pressed("LEFT"):
		velocity.x = -current_speed
		character.flip_h = true
	else:
		velocity.x = 0

	# CHARACTER-JUMP
	if is_on_floor():
		if Input.is_action_just_pressed("UP"):
			velocity.y = JUMP_HEIGHT
		elif Input.is_action_just_pressed("SPACE"):
			velocity.y = JUMP_HEIGHT
	else:
		if velocity.y < 0:
			characterAnimation.play("JUMP")
		else:
			characterAnimation.play("FALL")

	# CHARACTER-ANIMATION
	if velocity.x != 0 and current_speed == SPEED and is_on_floor():
		characterAnimation.play("WALK")
	elif velocity.x != 0 and current_speed == RUNNING_SPEED and is_on_floor():
		characterAnimation.play("RUN")
	elif velocity.x == 0 and is_on_floor():
		characterAnimation.play("IDLE")

	# CHARACTER-RUN
	if Input.is_action_pressed("SHIFT"):
		current_speed = RUNNING_SPEED
	else:
		current_speed = SPEED
		
	move_and_slide()
