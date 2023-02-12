extends Area2D

onready var sprite = $Sprite
onready var audio_stream_player = $AudioStreamPlayer


func _ready():
	var float_tween := create_tween()
	float_tween.set_loops()
	float_tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	float_tween.tween_property(sprite, "position", Vector2(0, 10), 0.4).from(Vector2(0, -10))
	float_tween.tween_property(sprite, "position", Vector2(0, -10), 0.4).from(Vector2(0, 10))


func _on_Jewel_body_entered(_player):
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE).set_parallel()
	tween.tween_property(sprite, "modulate:a", 0.0, 0.2)
	tween.tween_property(sprite, "position", Vector2(0, -20), 0.2)
	yield(audio_stream_player, "finished")
	yield(tween, "finished")
	queue_free()
