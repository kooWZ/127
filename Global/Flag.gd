extends Node
signal changed
var _flags := []


func has(flag: String) -> bool:
	return flag in _flags


func add(flag: String) -> void:
	if flag in _flags:
		return
	_flags.append(flag)
	emit_signal("changed")


func to_dict() -> Dictionary:
	return { flags=_flags }


func from_dict(dict: Dictionary) -> void:
	_flags = dict.flags
	emit_signal("changed")


func reset() -> void:
	_flags.clear()
	emit_signal("changed")
