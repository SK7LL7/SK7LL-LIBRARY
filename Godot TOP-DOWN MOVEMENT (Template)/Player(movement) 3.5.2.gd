extends KinematicBody2D

#CODE FOR GODOT 3.5.2


#CONST_VALUES
const ACCELERATION_VALUE = 5
const MAX_ROLLING_SPEED = 5
const MAX_WALKING_SPEED = 2
const MAX_RUNNING_SPEED = 2
const FRICTION_VALUE = 100


var currentVelocity = Vector2.ZERO
var currentRoll = Vector2.LEFT

#ANIMATIONS
onready var characterAnimationPlayer = $AnimationPlayer
onready var characterAnimationTree = $AnimationTree
onready var characterAnimationState = characterAnimationTree.get("parameters/playback")

#CHARACTER STATES
var CharacterState = MOVING


enum {
	MOVING,
	ROLLING
}

#FUNCTIONS
func _physics_process(delta):
	match CharacterState:
		MOVING:
			MOVING_STATE(delta)
		ROLLING:
			ROLLING_START()
	
	
	
func MOVING_STATE(delta):
	var inputDir = Vector2.ZERO
	#INPUTS
	inputDir.x = Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT")
	inputDir.y = Input.get_action_strength("DOWN") - Input.get_action_strength("UP")
	inputDir = inputDir.normalized()
	
	if inputDir != Vector2.ZERO:
		currentRoll = inputDir
		characterAnimationTree.set("parameters/IDLE/blend_position", inputDir)
		characterAnimationTree.set("parameters/WALK/blend_position", inputDir)
		characterAnimationTree.set("parameters/ROLL/blend_position", inputDir)

		#RUNNING STATE
		if Input.is_action_pressed("SHIFT"):
			characterAnimationTree.set("parameters/RUN/blend_position", inputDir)
			characterAnimationState.travel("RUN")
			currentVelocity = inputDir * (MAX_RUNNING_SPEED + 1) / 1
		else:
			characterAnimationTree.set("parameters/RUN/blend_position", Vector2.ZERO)
			characterAnimationState.travel("WALK")
			currentVelocity = inputDir * MAX_WALKING_SPEED
	else:
		characterAnimationState.travel("IDLE")
		currentVelocity = currentVelocity.move_toward(Vector2.ZERO, FRICTION_VALUE * delta)
		
	if Input.is_action_just_pressed("ROLL"):
		CharacterState = ROLLING
		
	IS_MOVING()

func ROLLING_START():
	currentVelocity = currentRoll * MAX_ROLLING_SPEED
	characterAnimationState.travel("ROLL")
	IS_MOVING()

func ROLLING_END():
	CharacterState = MOVING
	
	
func IS_MOVING():
	var _moveResult = move_and_collide(currentVelocity)
