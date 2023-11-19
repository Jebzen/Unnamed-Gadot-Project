extends Area2D

@export var show_hit = true

const HitEffect = preload("res://Effects/hit_effect.tscn")

var invincible: set = set_invincible

@onready var timer = $Timer

signal invincibility_started
signal invincibility_ended

func _ready():
	invincible = false
	
func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func get_invincible():
	return invincible
	
func start_invincibility(duration):
	#emit_signal("invincibility_started")
	self.set_invincible(true)
	timer.start(duration)

func create_hit_effect():
	var effect = HitEffect.instantiate()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func _on_timer_timeout():
	#emit_signal("invincibility_ended")
	self.set_invincible(false)

func _on_invincibility_started():
	set_deferred("monitoring", false)

func _on_invincibility_ended():
	set_deferred("monitoring", true)
