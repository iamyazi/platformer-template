class_name Player
extends CharacterBody2D

@export var animations: AnimationPlayer
@export var collision_shape: CollisionShape2D
@export var attack_state: State
@export var slide_state: State
@export var death_state: State

@onready var state_machine = $FSM
@onready var direction = 0
@export var health: float

const RUN_SPEED: float = 200.0
const SLIDE_SPEED: float = 300.00
const JUMP_VELOCITY: float = -450.0

func _ready() -> void:
	# sprite.material.set_shader_parameter("hit-flash-shader", true)
	state_machine.init()

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
