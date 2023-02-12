
extends FlagSwitch

export(String) var id setget set_id
onready var interactable = $Beforesprite/Interactable

func _ready():
	
	interactable.needed_item = load("res://Item/RSAKey_%s.tres" % id)
	pass


func _get_flag() -> String:
	return flag + id


func _on_Interactable_interact():
	print("d")
	var item := Inventory.get_current_item()
	if not item or item != interactable.needed_item:
		return
	Flag.add(_get_flag())
	Inventory.remove_item(item)


func  set_id(v):
	id = v
