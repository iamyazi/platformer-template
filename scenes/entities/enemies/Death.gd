extends State

var finished_dying: bool

func enter() -> void:
	finished_dying = false
	FSM.animation_player.play('death')

func exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	if finished_dying:
		FSM.parent.queue_free()
	return null

func process_physics(delta: float) -> State:
	FSM.parent.velocity.y += gravity * delta
	return null

func _on_animation_player_animation_finished(_death):
	finished_dying = true
