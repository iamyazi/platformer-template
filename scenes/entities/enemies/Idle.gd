extends State

func enter() -> void:
	FSM.animated_sprite.play('idle')
	FSM.parent.velocity.x = 0

func exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	if FSM.player_in_attack_range:
		if FSM.can_attack:
			return FSM.attack_state
		else:
			return null
	elif FSM.player_in_walk_range:
		return FSM.walk_towards_player_state
	return null

func process_physics(delta: float) -> State:
	FSM.parent.velocity.y += gravity * delta
	FSM.parent.move_and_slide()
	return null
