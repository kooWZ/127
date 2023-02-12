extends Position2D

export var scene: PackedScene
export var interval: float = 1.0
export var num := 3

onready var timer = $Timer

var spawned_num := 0

func _ready():
	timer.wait_time = interval


func start() -> void:
	if scene:
		timer.start()


func _on_Timer_timeout():
	spawned_num += 1
	if spawned_num > num:
		timer.stop()
		return
	var enemy: Node2D = scene.instance()
	get_parent().add_child(enemy)
	for i in range(1, 6):
		enemy.global_position = get_node("Position2D%d" % i).global_position
