extends Area2D

export(int)  var id


func entered(_area):
	Global.emit_signal("say", id)
	queue_free()
