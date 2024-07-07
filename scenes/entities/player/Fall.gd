extends State

func enter() -> void:
	FSM.animation_player.play('fall')

func exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	if FSM.parent.is_on_floor():
		if Input.is_action_pressed("slide"):
			return FSM.slide_state
		elif Input.is_action_pressed("jump"):
			return FSM.jump_state
		elif FSM.direction:
			return FSM.run_state
		else:
			return FSM.idle_state
	return null	

func process_physics(delta: float) -> State:
	FSM.parent.velocity.y += gravity * delta
	FSM.parent.velocity.x = FSM.direction * FSM.parent.RUN_SPEED
	FSM.parent.move_and_slide()
	return null


