extends State

@export var sprite: Sprite2D

func enter() -> void:
	FSM.animation_player.play('run')
	
func exit() -> void:
	sprite.offset = Vector2(0,0)

func process_input(event: InputEvent) -> State:
	if event is InputEventKey:
		if event.is_action_pressed("jump"):
			return FSM.jump_state
		elif event.is_action_pressed("slide"):
			return FSM.slide_state
	elif event is InputEventMouseButton:
		if event.is_action_pressed("attack_1"):
			return FSM.attack_state
	return null
	
func process_frame(_delta: float) -> State:
	if FSM.direction == 0:
		return FSM.idle_state
	return null

func process_physics(delta: float) -> State:
	FSM.parent.velocity.y += gravity * delta
	FSM.parent.velocity.x = FSM.direction * FSM.parent.RUN_SPEED
	FSM.parent.move_and_slide()

	if FSM.parent.velocity.y > 0:
		return FSM.fall_state
	

	return null
