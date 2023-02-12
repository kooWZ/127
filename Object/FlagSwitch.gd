extends Node2D
class_name FlagSwitch

export(String) var flag

var default_node: Node2D
var switch_node: Node2D


func _ready():
	var count := get_child_count()
	if count > 0:
		default_node = get_child(0)
	if count > 1:
		switch_node = get_child(1)
	
	Flag.connect("changed", self, "_update_nodes")
	_update_nodes()


func _update_nodes():
	var exist = Flag.has(_get_flag())
	if default_node:
		default_node.visible = not exist
	if switch_node:
		switch_node.visible = exist

func _get_flag() -> String:
	return flag
