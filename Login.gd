extends Node2D

onready var animator = $AnimationPlayer
onready var color = $ColorRect


func change_scene():
	color.show()
	animator.play("anim")
	yield(animator, "animation_finished")
	$LOGO.visible = false
	$Polaris1.visible = true
	animator.play_backwards("anim")
	yield(animator, "animation_finished")
	color.hide()

func _ready():
	OS.center_window()
	yield(get_tree().create_timer(2.0),"timeout")
	change_scene()
	yield(get_tree().create_timer(2.0),"timeout")
	$Polaris1.visible = false
	$Polaris2.visible = true
	$Edit1.visible = true
	$Edit2.visible = true
	yield(get_tree().create_timer(0.2),"timeout")
	$Edit1.text = "2"
	yield(get_tree().create_timer(0.2),"timeout")
	$Edit1.text = "25"
	yield(get_tree().create_timer(0.2),"timeout")
	$Edit1.text = "254"
	

func _on_Edit2_text_entered(new_text):
	if new_text!="":
		next_scene()

func next_scene():
	Global.change_scene("res://Level/Level1.tscn")
