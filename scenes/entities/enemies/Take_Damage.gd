extends State

@export var stun_lock: float

@onready var timer = $StunLockTimer

var stun_locked: bool
var direction: float

func enter() -> void:
	FSM.parent.health -= FSM.damage_taken
	stun_locked = true
	timer.start(stun_lock)
	FSM.animation_player.play('taking_damage')

func exit() -> void:
	stun_locked = false

func process_frame(_delta: float) -> State:
	if FSM.parent.health <= 0:
		return FSM.death_state
	elif stun_locked:
		return null
	elif FSM.player_in_attack_range:
		return FSM.attack_state
	elif FSM.player_in_walk_range:
		return FSM.walk_towards_player_state
	else:
		return FSM.idle_state

func process_physics(delta: float) -> State:
	FSM.parent.velocity.y += gravity * delta
	FSM.parent.velocity.x = 0
	FSM.parent.move_and_slide()

	return null

func _on_stun_lock_timer_timeout():
	stun_locked = false

