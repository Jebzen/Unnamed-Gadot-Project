extends Node

@export var max_health = 1
var health: set = set_health, get = get_health

func _ready():
	# Initialize health or perform any setup needed when the node is ready
	health = max_health

func set_health(value):
	# This will set the health and clamp it between 0 and max_health
	health = clamp(value, 0, max_health) 
	if health <= 0:
		emit_signal("no_health")

func get_health():
	return health

signal no_health
