tool
extends Node2D
signal touched(item)
export(Resource) var item
var id


func _ready():
	$Sprite.texture = item.scene_texture
	connect("touched",get_tree().current_scene,"pop_message")
	get_tree().current_scene.item_count +=1
	id = get_tree().current_scene.item_count 
	print(id)
	

func entered(_area):
	emit_signal("touched",self)
	print(id)

