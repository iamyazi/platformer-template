extends ProgressBar

@export var player: CharacterBody2D

func _ready():
	value = player.health

func _process(_delta):
	if value <= 0:
		visible = false
	value = player.health
