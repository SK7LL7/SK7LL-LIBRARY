extends KinematicBody2D

# CODE FOR GODOT 3.5.2 - SK7LL

# CHARACTER-VALUES
const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 100
const RUNNING_SPEED = 200
const JUMP_HEIGHT = -500

# CHARACTER-MOTION
var motion = Vector2()
var current_speed = SPEED

# CHARACTER
onready var character = $SPRITE
onready var characterAnimation = $AnimationPlayer

func _physics_process(_delta):
	motion.y += GRAVITY

	# CHARACTER-INPUT
	if Input.is_action_pressed("RIGHT"):
		motion.x = current_speed
		character.flip_h = false
	elif Input.is_action_pressed("LEFT"):
		motion.x = -current_speed
		character.flip_h = true
	else:
		motion.x = 0

	# CHARACTER-JUMP
	if is_on_floor():
		if Input.is_action_just_pressed("UP"):
			motion.y = JUMP_HEIGHT
	else:
		if motion.y < 0:
			characterAnimation.play("JUMP")
		else:
			characterAnimation.play("FALL")

	# CHARACTER-ANIMATION
	if motion.x != 0 and current_speed == SPEED and is_on_floor():
		characterAnimation.play("WALK")
	elif motion.x != 0 and current_speed == RUNNING_SPEED and is_on_floor():
		characterAnimation.play("RUN")
	elif motion.x == 0 and is_on_floor():
		characterAnimation.play("IDLE")

	# CHARACTER-RUN
	if Input.is_action_pressed("SHIFT"):
		current_speed = RUNNING_SPEED
	else:
		current_speed = SPEED

	motion = move_and_slide(motion, UP)
