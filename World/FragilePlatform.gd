extends KinematicBody2D

export(float) var delay = 1.0
onready var timer = $Timer

func _ready():
	timer.wait_time = delay
	


func _on_Hurtbox_hurt(hitbox: Hitbox):
	if hitbox.attack_type != "tread":
		return
	var sm := ShaderMaterial.new()
	sm.shader = preload("res://Shader/BlinkingTile.shader")
	$Sprite.material = sm
	var t := create_tween()
	t.tween_interval(delay)
	t.tween_callback(self, "queue_free")


func _on_Timer_timeout():
	var sm := ShaderMaterial.new()
	sm.shader = preload("res://Shader/ColorBlock.tres")
	$Sprite.material = sm
	var t := create_tween()
	t.tween_interval(0.1)
	t.tween_callback(self, "queue_free")
#	print("平台碎裂动画未完成")
