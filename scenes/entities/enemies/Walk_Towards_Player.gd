extends State

var direction: float

func enter() -> void:
	FSM.animated_sprite.play('walk')

func exit() -> void:
	FSM.animated_sprite.stop()

func process_frame(_delta: float) -> State:
	direction = (FSM.parent.player.position - FSM.parent.position).x
	if FSM.player_in_attack_range and FSM.can_attack:
		return FSM.attack_state
	elif not FSM.player_in_walk_range:
		return FSM.idle_state
	return null

func process_physics(delta: float) -> State:
	FSM.parent.velocity.y += gravity * delta
	FSM.parent.velocity.x = FSM.parent.move_speed * sign(direction)
	FSM.parent.move_and_slide()
	FSM.parent.flip_sprite(direction)
	return null
