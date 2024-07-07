extends FiniteStateMachine

@export var idle_state: State
@export var run_state: State
@export var jump_state: State
@export var fall_state: State
@export var attack_state: State
@export var slide_state: State
@export var take_damage_state: State
@export var death_state: State

@export var sprite: Sprite2D

@export var animation_player: AnimationPlayer
@export var collision_shape: CollisionShape2D

@onready var sprite_scale = sprite.scale.x

var direction: float
var damage_taken: float

func process_input(event: InputEvent) -> State:
	direction = Input.get_axis("left", "right")
	super(event)
	return

func process_frame(delta: float) -> State:
	super(delta)
	return
	
func process_physics(delta: float) -> State:
	flip_sprite()
	super(delta)
	return

func flip_sprite() -> void:
	if current_state not in [attack_state, slide_state, death_state]:
		if direction > 0:
			sprite.scale.x = sprite_scale
		elif direction < 0:
			sprite.scale.x = -sprite_scale

func take_damage(damage: float) -> void:
	damage_taken = damage
	change_state(take_damage_state)

