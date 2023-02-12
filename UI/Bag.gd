extends Control



func _ready():
	$Count.text = "Collected:\n%d/10"%Inventory._item_count
	Inventory.connect("added",self,"added")


func added():
	$Count.text = "Collected:\n%d/10"%Inventory._item_count


