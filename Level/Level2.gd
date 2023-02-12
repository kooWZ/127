extends "res://Level/BaseLevel.gd"


func _ready():
	$Tween.interpolate_property($BGM/Audio1,"volume_db",-40,-12,3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	Global.emit_signal("saymany",[26,27,28,29])

	



