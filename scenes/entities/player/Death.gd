extends State

func enter() -> void:
	FSM.animation_player.play('death')
	FSM.parent.velocity.x = 0

func exit() -> void:
	pass

func process_physics(delta: float) -> State:
	FSM.parent.velocity.y += gravity * delta
	FSM.parent.move_and_slide()

	return null
