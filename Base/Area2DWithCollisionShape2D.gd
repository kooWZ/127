tool
extends Area2D
class_name Area2DWithCollisionShape2D

# 失败了, 不要动, 也不要修改继承自 ..WithCollisionShape2D 的节点的类型
#export(CircleShape2D) var shape setget set_shape
#func set_shape(v: CircleShape2D):
#	shape = v
#	var s := Sprite.new()
#	s.texture = preload("res://Asset/PNG/Tiles/platformPack_tile009.png")
#	s.scale = Vector2(v.radius / s.texture.get_size().x, v.radius / s.texture.get_size().x)
#	add_child(s)
#	$CollisionShape2D.shape = shape
