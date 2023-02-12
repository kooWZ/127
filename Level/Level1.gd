extends "res://Level/BaseLevel.gd"

var opening := false


func _ready():
	$CanvasLayer/Main/GameViewContainer/GameViewport/BabyWorld/ChangeBGM.connect("change_music",self,"change_music")
	$CanvasLayer/DialogHUD.connect("list_completed",self,"on_show_list_completed")
	$Tween3.interpolate_property($BGM/Audio1,"volume_db",-80,-20,3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween3.start()
	Global.emit_signal("saymany",[0,1,2,3,4,5,6,7,8,9,10])
	
	
func change_music():
	$Tween.interpolate_property($BGM/Audio1,"volume_db",-20,-80,3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Tween_tween_completed(_object, _key):
	$BGM/Audio1.playing = false
	$BGM/Audio2.playing = true
	$Tween2.interpolate_property($BGM/Audio2,"volume_db",-80,-18,3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween2.start()


func change_main_hidden():
	if Global.first_time_open:
		Global.emit_signal("saymany",[11,12])
		opening = true
		first_time_open_animation()
		return
	if opening:
		return
	$CanvasLayer/Main.visible = not $CanvasLayer/Main.visible
	$CanvasLayer/SettingsHUD/MinimapViewContainer.visible = $CanvasLayer/Main.visible


func first_time_open_animation():
	$CanvasLayer/Main.visible = true
	$CanvasLayer/Main/Window.visible = false
	$CanvasLayer/Main/GameViewContainer.visible = false
	$CanvasLayer/Main/Load1.visible = true
	yield(get_tree().create_timer(0.5),"timeout")
	$CanvasLayer/Main/Load1.visible = false
	$CanvasLayer/Main/Window.visible = true
	$CanvasLayer/Main/Load2.visible = true
	yield(get_tree().create_timer(0.5),"timeout")
	$CanvasLayer/Main/Load2.visible = false
	$CanvasLayer/Main/Load3.visible = true
	


func on_show_list_completed(list):
	if list == [11,12]:
		$CanvasLayer/Main/Load1.visible = false
		$CanvasLayer/Main/Load2.visible = false
		$CanvasLayer/Main/Load3.visible = false
		$CanvasLayer/Main/GameViewContainer.visible = true
		$CanvasLayer/SettingsHUD/MinimapViewContainer.visible = true
		Global.first_time_open = false
		opening = false
		Global.emit_signal("saymany",[13,14,15,16,17])
	elif list == [24,25]:
		$CanvasLayer/pop.visible = true
		

func next_level(path):
	$CanvasLayer/pop/No.text = "No"
	$CanvasLayer/pop/Yes.text = "Yes"
	$CanvasLayer/pop/label.text = "确定进入下一关吗？"
	Global.emit_signal("saymany",[24,25])
	popmode = POPMODE.DOOR
	next_path = path
	
	
			
