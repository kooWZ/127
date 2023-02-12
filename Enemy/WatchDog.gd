#tool
extends "res://Enemy/Enemy.gd"

export(NodePath) var node1
export(NodePath) var node2
export(NodePath) var node3
export(NodePath) var node4
export(NodePath) var node5

#export(int) var rebulid_num = 0 setget set_rebilid_num
export(float) var interval = 10.0 
onready var timer = $Timer

var node_path := []
var node := []
func _ready():
	animation_player.play("Idle")
	timer.wait_time = interval
	timer.start()
	pass


#func set_rebilid_num(v: int):
#	rebulid_num = v
#	node_path.resize(v)
#	pass



#func _get_property_list():
#	var properties := []
#	for i in rebulid_num:
#		properties.append({
#			name="node_path/" + str(i),
#			type=TYPE_NODE_PATH,
#			usage=PROPERTY_USAGE_EDITOR,
#		})
#	return properties
#
#
#func _get(property):
#	if property.begins_with("node_path/"):
#		property = property.trim_prefix("node_path/")
#		var index := property as int
#		return node_path[index] 
#
#	return null
#
#
#func _set(property, value):
#	if property.begins_with("node_path/"):
#		property = property.trim_prefix("node_path/")
#		var index := property as int
#		node[index] = value
#		return true
#
#	return false


func _on_Timer_timeout():
	check(node1)
	check(node2)
	check(node3)
	check(node4)
	check(node5)
#	node.clear()
#	for i in node_path:
#		node.append(get_node(i))
#	if node.empty():
#		print("empty")
#		return
#	for i in rebulid_num:
#		node.append(get_node(node_path[i]))
#	for i in node_path:
#		if i.is_dead:
#			i.rebulid()

func check(path):
	if not path:
		return
	var n = get_node(path)
	if n.is_dead:
		n.rebulid()
