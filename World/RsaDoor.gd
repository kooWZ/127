extends "res://Enemy/Enemy.gd"

export var index: int

func _ready():
	pass


func _on_Hurtbox_hurt(hitbox):
	if hitbox.attack_type != "RSA_key" + str(index):
		return
	
	print_debug("未设置 RSA 门打开/销毁动画")
	queue_free()
