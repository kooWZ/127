extends Area2D

export(Array, int) var ids


func entered(_area):
	Global.emit_signal("saymany", ids)
	queue_free()
