extends Area2D

signal change_music


func _on_audio_body_entered(_body):
	emit_signal("change_music")
	queue_free()
