extends KinematicBody2D

var state = MOVE

enum {
	MOVE,
	ATTACK,
	SWORD,
}

onready var anim_tree = $AnimationTree
onready var anim_state = anim_tree.get("parameters/playback")

var speed = 100
var velocity = Vector2.ZERO

# warning-ignore:unused_argument
func _physics_process(delta):
	match state:
		MOVE:
			move_state()
		SWORD:
			sword_state()
	
func move_state():
	var input_movement = Vector2.ZERO
	input_movement.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_movement.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if input_movement != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input_movement)
		anim_tree.set("parameters/Walk/blend_position", input_movement)
		anim_tree.set("parameters/Sword/blend_position", input_movement)
		anim_state.travel("Walk")
		velocity += input_movement * speed
		velocity = velocity.clamped(speed)
	else:
		anim_state.travel("Idle")
		velocity = Vector2.ZERO
		
	if Input.is_action_just_pressed(("ui_sword")):
		state = SWORD
		
	move_and_slide(velocity)

func sword_state():
	velocity = Vector2.ZERO
	anim_state.travel("Sword")
	
func sword_finished():
	state = MOVE
