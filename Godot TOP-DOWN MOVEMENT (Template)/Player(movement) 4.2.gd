extends CharacterBody2D

#CODE UPDATED FOR GODOT 4.2

#CONST_VALUES
const ACCELERATION_VALUE : float = 5
const MAX_ROLLING_SPEED : float = 5
const MAX_WALKING_SPEED : float = 2
const MAX_RUNNING_SPEED : float = 2
const FRICTION_VALUE : float = 100

var currentVelocity : Vector2 = Vector2.ZERO
var currentRoll : Vector2 = Vector2.LEFT

#ANIMATIONS
@onready var characterAnimationPlayer : AnimationPlayer = $AnimationPlayer
@onready var characterAnimationTree : AnimationTree = $AnimationTree
@onready var characterAnimationState : AnimationNodeStateMachinePlayback

#CHARACTER STATES
var CharacterState : int = MOVING

enum {
	MOVING,
	ROLLING
}

#FUNCTIONS
func _ready() -> void:
	characterAnimationState = characterAnimationTree.get("parameters/playback")

func _physics_process(delta: float) -> void:
	match CharacterState:
		MOVING:
			MOVING_STATE(delta)
		ROLLING:
			ROLLING_START()

func MOVING_STATE(delta: float) -> void:
	var inputDir : Vector2 = Vector2.ZERO

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

func ROLLING_START() -> void:
	currentVelocity = currentRoll * MAX_ROLLING_SPEED
	characterAnimationState.travel("ROLL")
	IS_MOVING()

func ROLLING_END() -> void:
	CharacterState = MOVING

func IS_MOVING() -> void:
	var _moveResult : KinematicCollision2D = move_and_collide(currentVelocity)
