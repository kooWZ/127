extends "res://Enemy/Enemy.gd"

export(float, 0.0, 5.0) var interval = 3.0
onready var spawner = $Spawner
onready var sensor = $Sensor
onready var timer = $Timer

func _ready():
	animation_player.play("Idle")
	pass


#func _on_Sensor_area_entered(_player):
#	spawner.start()
#	sensor.set_deferred("monitoring", false)
#	animation_player.play("Active")
#
#
#func _on_Sensor_area_exited(_player):
#	timer.start()
#	animation_player.play("Idle")

func _on_Timer_timeout():
	sensor.monitoring = true


func _on_Sensor_body_entered(body):
	spawner.start()
	sensor.set_deferred("monitoring", false)
	animation_player.play("Active")


func _on_Sensor_body_exited(body):
	timer.start()
	animation_player.play("Idle")
