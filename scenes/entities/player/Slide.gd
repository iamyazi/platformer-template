extends State

@onready var timer = $Timer

var previous_collision_shape_height: float
var previous_collision_shape_position: Vector2

var direction: float
var sliding: bool

func enter() -> void:
	timer.start()
	direction = FSM.direction
	sliding = true
	FSM.animation_player.play('slide')

func exit() -> void:
	FSM.collision_shape.shape.height = 42
	FSM.collision_shape.position = Vector2(0,5)

func process_frame(_delta: float) -> State:
	if sliding:
		return null
	if FSM.direction:
		return FSM.run_state
	else:
		return FSM.idle_state

func process_physics(delta: float) -> State:
	FSM.parent.velocity.y += gravity * delta
	FSM.parent.velocity.x = direction * FSM.parent.SLIDE_SPEED
	FSM.parent.move_and_slide()
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		return FSM.jump_state
	return null

func _on_timer_timeout():
	sliding = false
