tool
extends Node2D
const cell_size := Vector2(64, 64)


onready var baby_world = $BabyWorld

export(String) var world_name

func clear_tile(u: Vector2, v: Vector2):
	var direction := u.direction_to(v) * 0.4
	v = v + 2 * direction
	if u.x < v.x:
		while u.x < v.x:
			baby_world.set_cellv(u, -1)
			u += direction
	else:
		while u.x > v.x:
			baby_world.set_cellv(u, -1)
			u += direction


var width := 1024 * 5
var height := 6400


func _ready():
	for i in round(width / cell_size.x):
		for k in round(height / cell_size.y):
			baby_world.set_cell(i, k, 0)
	
	generate_by_line()
	var scene = PackedScene.new()
	scene.pack(baby_world)
	ResourceSaver.save("res://World/%s.tscn" % world_name, scene)



func generate_by_line():
	for child in get_children():
		if child is Line2D:
			var points = child.points
			for i in points:
				i.x /= cell_size.x
				i.y /= cell_size.y
			for i in points.size() - 1:
				draw_blank(points[i] / cell_size.x, points[i + 1] / cell_size.x)



func draw_blank(u, v):
	clear_tile(u, v)
	var t := [0.2, 0.5, 0.8, 1.2, 1.5 ]
	for i in t:
		var offset := Vector2(-i, i)
		clear_tile(u + offset, v + offset)
		clear_tile(u - offset, v - offset)
