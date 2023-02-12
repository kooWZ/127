extends Node2D
onready var soil = $test1

#var soil = preload("res://TileMap/test1.tscn").instance()
var bottom_hitbox = preload("res://Box/Hitbox.tscn").instance()
#var collision_shape = CollisionShape2D.new()

func _ready():
#	add_child(soil)
	add_child(bottom_hitbox)
	var rect = soil.get_used_rect()
	var bounds = Rect2(
		rect.position.x * soil.cell_size.x,
		rect.position.y * soil.cell_size.y,
		rect.size.x * soil.cell_size.x,
		rect.size.y * soil.cell_size.y
	)
	
	
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(bounds.size.x / 2, soil.cell_size.y / 2)
	bottom_hitbox.get_node("CollisionShape2D").shape = shape
	bottom_hitbox.position = Vector2(
		bounds.position.x + bounds.size.x / 2,
		bounds.end.y + soil.cell_size.y / 2
	)
	bottom_hitbox.attack_type = "code"
#	save_world_screenshot()

func set_cellv(u: Vector2, id: int):
	soil.set_cellv(u, id)


func set_cell(x: int, y: int, id: int):
	soil.set_cell(x, y, id)
