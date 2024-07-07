extends State

@export var sword_hitbox: Area2D
@onready var timer = $AttackTimer

var attacking: bool

func enter() -> void:
	attacking = true
	timer.start()
	FSM.animation_player.play('sword_2')

func exit() -> void:
	attacking = false

func process_input(event: InputEvent) -> State:
	if event.is_action_pressed("jump"):
		return FSM.jump_state
	return null

func process_frame(_delta: float) -> State:
	if not attacking:
		if FSM.direction == 0:
			return FSM.idle_state
		else:
			return FSM.run_state
	return null

func process_physics(delta: float) -> State:
	FSM.parent.velocity.y += gravity * delta
	if FSM.parent.velocity == Vector2.ZERO and FSM.parent.is_on_floor():
		return FSM.idle_state
	return null

func _on_attack_timer_timeout():
	attacking = false

func _on_sword_hitbox_area_entered(area):
	if area.is_in_group("enemy_hurtbox"):
		area.owner.find_child("FSM").take_damage(sword_hitbox.damage)
