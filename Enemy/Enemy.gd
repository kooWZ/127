tool
extends KinematicBody2DWithCollisionShape2D

const gravrity := 2000

onready var sprite := $Sprite
onready var animation_player = $AnimationPlayer

func _on_VisibilityEnabler2D_viewport_entered(_viewport):
	if Global.first_meet_enemy:
		Global.first_meet_enemy = false
		
	var enabler = $VisibilityEnabler2D
	enabler.process_parent = false
	enabler.physics_process_parent = false
	enabler.pause_animations = false



func _on_Interactable_interact():
	var item := Inventory.active_item
	if not item or item != preload("res://Item/GrassShark.tres"):
		return

	Inventory.remove_item(item)
	queue_free()
