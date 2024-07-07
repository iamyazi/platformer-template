extends ProgressBar

@export var skelly: CharacterBody2D

func _ready():
	value = skelly.health

func _process(_delta):
	if value <= 0:
		visible = false
	value = skelly.health
