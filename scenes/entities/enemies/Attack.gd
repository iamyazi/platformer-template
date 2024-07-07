extends State

@export var sword_hitbox: Area2D
@export var attack_length: float

var attacking: bool

@onready var atk_timer = $AttackTimer
@onready var cd_timer = $CDTimer

var direction: float

func enter() -> void:
	attacking = true
	atk_timer.start(attack_length)
	FSM.animation_player.play('attack')

func exit() -> void:
	FSM.can_attack = false
	cd_timer.start()

func process_frame(_delta: float) -> State:
	direction = (FSM.parent.player.position - FSM.parent.position).normalized().x
	if attacking:
		return null
	else:
		return FSM.idle_state

func process_physics(delta: float) -> State:
	FSM.parent.velocity.y += gravity * delta
	FSM.parent.velocity.x = 0
	FSM.parent.move_and_slide()
	FSM.parent.flip_sprite(direction)
	return null

func _on_attack_timer_timeout():
	attacking = false
	
func _on_sword_hitbox_area_entered(area):
	if area.is_in_group("player_hurtbox"):
		area.owner.find_child("FSM").take_damage(sword_hitbox.damage)




