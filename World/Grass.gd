extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

func create_grass_effect():
	var grassEffect = GrassEffect.instantiate()
	var worldScene = get_tree().current_scene
	worldScene.add_child(grassEffect)
	grassEffect.global_position = global_position
	
func _on_hurtbox_area_entered(_area):
	create_grass_effect()
	queue_free()
