extends Node

@export var max_health = 1: set = set_max_health
var health = max_health: set = set_health

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func _ready():
	#Initialize health or perform any setup needed when the node is ready
	self.health = max_health

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)
	
func set_health(value):
	# This will set the health and clamp it between 0 and max_health
	health = clamp(value, 0, max_health) 
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

