extends Area2D

export(String, FILE, "*.tscn") var path
signal enter(path)

func entered(_area):
	emit_signal("enter",path)

func _ready():
	connect("enter",get_tree().current_scene,"next_level")
