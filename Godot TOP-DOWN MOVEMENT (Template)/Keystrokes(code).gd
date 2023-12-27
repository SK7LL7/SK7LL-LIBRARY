extends CanvasLayer

#KEYS
onready var A = $A
onready var S = $S
onready var D = $D
onready var W = $W
onready var SHIFT = $SHIFT
onready var SPACE = $SPACE

#FUNCTION
func _process(_delta):
	if Input.is_action_pressed("LEFT"):
		A.frame = 1
	if Input.is_action_pressed("RIGHT"):
		D.frame = 1
	if Input.is_action_pressed("DOWN"):
		S.frame = 1
	if Input.is_action_pressed("UP"):
		W.frame = 1
	if Input.is_action_pressed("SHIFT"):
		SHIFT.frame = 1
	if Input.is_action_pressed("ROLL"):
		SPACE.frame = 1
	if Input.is_action_just_released("LEFT"):
		A.frame = 0
	if Input.is_action_just_released("RIGHT"):
		D.frame = 0
	if Input.is_action_just_released("DOWN"):
		S.frame = 0
	if Input.is_action_just_released("UP"):
		W.frame = 0
	if Input.is_action_just_released("SHIFT"):
		SHIFT.frame = 0
	if Input.is_action_just_released("ROLL"):
		SPACE.frame = 0
