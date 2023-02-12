extends Node2D

func _ready():
	$CanvasLayer/DialogHUD.connect("list_completed",self,"last")
	yield(get_tree().create_timer(3.0),"timeout")
	$CanvasLayer/DialogHUD.visible = true
	Global.emit_signal("saymany",[30,31,32,33,34,35,36,37,38,39])

func last(_list):
	var dir = Directory.new()
	dir.copy("res://log#254.html","user://log#254.html")
	dir.copy("res://communications.txt","user://communications.txt")
	OS.shell_open(ProjectSettings.globalize_path("user://log#254.html"))
	OS.shell_open(ProjectSettings.globalize_path("user://communications.txt"))
	get_tree().quit()
