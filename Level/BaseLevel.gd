extends Node2D

enum POPMODE  {ITEM,DOOR}

var item_count = 0
var curritem
var popmode = POPMODE.ITEM
var next_path

func _ready():
	$CanvasLayer/Desktop/TouchFish.connect("touch_fish",$CanvasLayer/DialogHUD,"touch_fished")
	$CanvasLayer/Desktop/Browser.connect("browser_button",self,"change_main_hidden")
	$CanvasLayer/SettingsHUD/MinimapViewContainer/MinimapViewport.world_2d = $CanvasLayer/Main/GameViewContainer/GameViewport.world_2d
	$CanvasLayer/pop/Yes.connect("pressed",self,"yes")
	$CanvasLayer/pop/No.connect("pressed",self,"no")
	$CanvasLayer/pop/No2.connect("pressed",self,"no")
	
func change_main_hidden():
	$Main.visible = not $Main.visible
	$SettingsHUD/MinimapViewContainer.visible = $Main.visible

func pop_message(item):
	$CanvasLayer/pop/No.text = "忽略"
	$CanvasLayer/pop/Yes.text = "保留"
	popmode = POPMODE.ITEM
	curritem = item
	$CanvasLayer/pop.visible = true
	$CanvasLayer/pop/label.text = Dialogs.level1_items[curritem.id-1]
	if Inventory._item_count >=10:
		$CanvasLayer/pop/Yes.disabled = true
	else:
		$CanvasLayer/pop/Yes.disabled = false
	Global.pause_with_bgm()
	

func next_level(path):
	$CanvasLayer/pop/No.text = "No"
	$CanvasLayer/pop/Yes.text = "Yes"
	popmode = POPMODE.DOOR
	$CanvasLayer/pop.visible = true
	$CanvasLayer/pop/label.text = "确定进入下一关吗？"
	next_path = path
	
	
func no():
	if popmode == POPMODE.ITEM:
		$CanvasLayer/pop.visible = false
		Global.resume_with_bgm()
	else:
		$CanvasLayer/pop.visible = false

func yes():
	if popmode == POPMODE.ITEM:
		$CanvasLayer/pop.visible = false
		Inventory.add_item(curritem)
		curritem.queue_free()
		Global.resume_with_bgm()
	else:
		Global.change_scene(next_path)


