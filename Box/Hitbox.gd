extends Area2DWithCollisionShape2D
class_name Hitbox
signal hit

export(String) var attack_type = ""


func _on_Hitbox_area_entered(hurtbox):
	emit_signal("hit")
	hurtbox.emit_signal("hurt", self)
	
