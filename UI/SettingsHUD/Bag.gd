extends GridContainer

export var length = 3
var currentButton = null
var dic = {}
var BagItem = preload("res://UI/SettingsHUD/BagItem.tscn")


func changed():
	dic = {}
	get_tree().call_group("bagitem", "queue_free")
	for item in Inventory._items:
		var bagitem = BagItem.instance()
		bagitem.texture_normal = item.prop_texture
		add_child(bagitem)
		dic[bagitem] = item
		bagitem.connect("toggle",self,"pressed")

func added():
	var item = Inventory._items[0]
	var bagitem = BagItem.instance()
	bagitem.texture_normal = item.prop_texture
	add_child(bagitem)

func _ready():
	columns = length
	#Inventory.connect("changed",self,"changed")
	Inventory.connect("added",self,"added")

