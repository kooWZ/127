extends FlagSwitch



func _get_flag() -> String:
	return flag + name


func _on_Interactable_interact():
	var item := Inventory.active_item
	if not item or item != preload("res://Item/OriginalBullet.tres"):
		return
	Flag.add(_get_flag())
	Inventory.remove_item(item)
