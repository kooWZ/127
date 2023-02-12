extends Node2D

export(float) var half_cycle_time = 1.0
export(float) var delay_time = 0.08

onready var path_follow_2d = $Path2D/PathFollow2D

func _ready():
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.set_loops()
	tween.tween_property(path_follow_2d, "unit_offset", 1.0, half_cycle_time).from(0.0)
	tween.tween_interval(delay_time)
	tween.tween_property(path_follow_2d, "unit_offset", 0.0, half_cycle_time).from(1.0)
	tween.tween_interval(delay_time)
