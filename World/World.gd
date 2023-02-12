extends Node2D


func _ready():
	pass


func instance_tile(tilemap: TileMap, tile_name: String, scene: PackedScene):
	var id = tilemap.tile_set.find_tile_by_name(tile_name)
	
	assert(id != -1)
	
	for pos in tilemap.get_used_cells_by_id(id):
		var node =  scene.instance()
		tilemap.add_child(node)
		node.position = tilemap.map_to_world(pos) + tilemap.cell_size / 2
		tilemap.set_cellv(pos, -1)
