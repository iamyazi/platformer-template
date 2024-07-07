class_name Enemy_Skeleton
extends CharacterBody2D

@export var attack_state: State

@export var move_speed: float
@export var health: float

@onready var player: CharacterBody2D = $"../Player"
@onready var state_machine = $FSM
@onready var sprite = $AnimatedSprite2D

signal took_damage

func _ready() -> void:
	state_machine.init()

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
func flip_sprite(direction) -> void:
	if state_machine.current_state not in [attack_state]:
		if direction > 0:
			sprite.scale.x = 1.2
		elif direction < 0:
			sprite.scale.x = -1.2
