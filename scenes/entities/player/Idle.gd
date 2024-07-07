extends State

func enter() -> void:
	FSM.animation_player.play('idle')

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	if event is InputEventKey:
		if event.is_action_pressed("jump"):
			return FSM.jump_state
	elif Input.is_action_pressed("attack_1"):
		return FSM.attack_state
	return null

func process_frame(_delta: float) -> State:
	if FSM.direction != 0:
		return FSM.run_state
	return null

func process_physics(delta: float) -> State:
	FSM.parent.velocity.y += gravity * delta
	FSM.parent.velocity.x = 0
	FSM.parent.move_and_slide()

	return null
