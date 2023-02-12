extends Node

signal changed
signal added
var active_item: Item
var _item_count = 0
var _items := []
var _current_item_index := -1


func get_item_count() -> int:
	return _items.size()


func get_current_item() -> Item:
	if _current_item_index == -1:
		return null
	return _items[_current_item_index]


func add_item(item: Item):
	if _item_count == 0:
		Global.emit_signal("say",23)
	if not (item in _items):
		_items.append(item)
#	_current_item_index = _items.size() - 1
	_item_count += 1
	emit_signal("added")


func remove_item(item: Item):
	var index := _items.find(item)
	if index == -1:
		return
	_items.remove(index)
	if _current_item_index >= _items.size():
		_current_item_index = 0 if _items else -1
	emit_signal("changed")


func select_next():
	if _current_item_index == -1:
		return
	_current_item_index = (_current_item_index + 1) % _items.size()
	emit_signal("changed")


func select_prev():
	if _current_item_index == -1:
		return
	_current_item_index = (_current_item_index - 1 + _items.size()) % _items.size()
	emit_signal("changed")


func to_dict() -> Dictionary:
	var names := []
	for item in _items:
		var path := item.resource_path as String
		names.append(path.get_file().get_basename())
	return {
		items=names,
		current_item_index=_current_item_index,
	}


func from_dict(dict: Dictionary) -> void:
	_current_item_index = dict.current_item_index
	_items.clear()
	for name in dict.items:
		_items.append(load("res://items/%s.tres" % name))
	emit_signal("changed")


func reset() -> void:
	_current_item_index = -1
	_items.clear()
	emit_signal("changed")
