extends FiniteStateMachine

@export var idle_state: State
@export var walk_towards_player_state: State
@export var take_damage_state: State
@export var attack_state: State
@export var death_state: State

@export var animated_sprite: AnimatedSprite2D
@export var animation_player: AnimationPlayer

var hit: bool
var damage_taken: float
var player_in_attack_range: bool
var player_in_walk_range: bool
var can_attack: bool = true

func _on_attack_detection_body_entered(body):
	if body.is_in_group('player'):
		player_in_attack_range = true

func _on_attack_detection_body_exited(body):
	if body.is_in_group('player'):
		player_in_attack_range = false

func _on_walk_detection_body_entered(body):
	if body.is_in_group('player'):
		player_in_walk_range = true

func _on_walk_detection_body_exited(body):
	if body.is_in_group('player'):
		player_in_walk_range = false

func take_damage(damage: float) -> void:
	damage_taken = damage
	change_state($Take_Damage)

func _on_cd_timer_timeout():
	can_attack = true

func change_state(new_state: State) -> void:
	super(new_state)
	print(new_state)
