extends State

func enter() -> void:
	FSM.animation_player.play('jump')
	FSM.parent.velocity.y = FSM.parent.JUMP_VELOCITY
	
func exit() -> void:
	pass

func process_physics(delta: float) -> State:
	FSM.parent.velocity.y += gravity * delta
	FSM.parent.velocity.x = FSM.direction * FSM.parent.RUN_SPEED
	FSM.parent.move_and_slide()
	if FSM.parent.is_on_floor():
		if FSM.direction:
			return FSM.run_state
		elif FSM.parent.velocity == Vector2.ZERO:
			return FSM.idle_state
	elif FSM.parent.velocity.y > 0:
		return FSM.fall_state
	return null
