extends State

@export var stun_lock: float

@onready var timer = $StunLockTimer

var stun_locked: bool

func enter() -> void:
	FSM.parent.health -= FSM.damage_taken
	stun_locked = true
	timer.start(stun_lock)
	FSM.animation_player.play('taking_damage')

func exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	if FSM.parent.health <= 0:
		return FSM.death_state
	elif stun_locked:
		return null
	else:
		return FSM.idle_state

func process_physics(delta: float) -> State:
	FSM.parent.velocity.y += gravity * delta
	FSM.parent.velocity.x = 0
	FSM.parent.move_and_slide()

	return null

func _on_stun_lock_timer_timeout():
	stun_locked = false
