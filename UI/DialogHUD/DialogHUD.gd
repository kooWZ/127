extends "res://UI/MoveableUI.gd"
signal list_completed(list)
var showid = -1
var is_showing := false
var currentDialog := 0
var currentMaxDialog := 0
var _text = ""
var _speed = 20
var idlist = []
var showlist = []
var changing_window := false

func _ready():
	Global.connect("say",self,"show_by_id")
	Global.connect("saymany",self,"showManyText")
	randomize()


func show_by_id(id):
	showText(Dialogs.npc[id])
	idlist.append(id)


func showText(text,speed = 20,new = true):
	while is_showing:
		yield(get_tree().create_timer(2), "timeout")
	_speed = speed
	is_showing = true
	_text = text
	if showid == -1 or showid == 0:
		
		show_window(true)
	else:
		update_label_text()
	currentDialog += 1
	if new:
		currentMaxDialog += 1


func update_label_text():
	$anim.play("anim")
	$NPCLabel.text = ""
	var length = _text.length()
	for i in range(length):
		if is_showing:
			$NPCLabel.text = $NPCLabel.text + _text[i]
			yield(get_tree().create_timer(1.0/_speed), "timeout")
		else:
			$NPCLabel.text = _text
			break
	showFinished()


func _on_JumpButton_pressed():
	if is_showing:
		is_showing = false
	elif showid != -1:
		if  showid != showlist.size() -1:
			showid += 1
			show_by_id(showlist[showid])
		elif showid == showlist.size() -1:
			Global.resume_with_bgm()
			showid = -1
			show_window(false)
			$anim.animation = "idle"
			$anim.stop()
			emit_signal("list_completed",showlist)


func showManyText(arr):
	showlist = arr
	showid = 0
	Global.pause_with_bgm()
	show_by_id(showlist[showid])
	

func showFinished():
	if showid == -1:
		Global.resume_with_bgm()
		show_window(false)
		$anim.animation = "idle"
		$anim.stop()
	else:
		is_showing = false
	if currentDialog>1:
		$PreviousButton.disabled = false
	else:
		$PreviousButton.disabled = true
	if currentDialog < currentMaxDialog:
		$NextButton.disabled = false
	else:
		$NextButton.disabled = true



func touch_fished():
	if not is_showing:
		if Global.first_time_open:
			showText(Dialogs.wrong_icon,15,false)
		else:
			showText(Dialogs.fishlist[randi() % Dialogs.fishlist.size()],15,false)


func show_previous():
	if not is_showing:
		currentDialog -= 2
		showText(Dialogs.npc[idlist[currentDialog]],20,false)


func show_next():
	if not is_showing:
		#currentDialog -= 2
		showText(Dialogs.npc[idlist[currentDialog]],20,false)


func show_window(show):
	while changing_window:
		yield(get_tree().create_timer(1.0),'timeout')
	changing_window = true
	if show:
		$Tween4Window.interpolate_property($Window1,"margin_top",333,0,0.3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween4Window.start()
	else:
		show_npc(false)


func show_npc(show):
	if show:
		$Tween4NPC.interpolate_property($NPC,"modulate",Color(1,1,1,0),Color(1,1,1,1),0.2,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween4NPC.start()
	else:
		$Tween4NPC.interpolate_property($NPC,"modulate",Color(1,1,1,1),Color(1,1,1,0),0.2,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween4NPC.start()

func _on_Window_tween_completed(_object, _key):
	if $Window1.margin_top==0:
		show_npc(true)
	else:
		changing_window = false
		is_showing = false

func _on_NPC_tween_completed(_object, _key):
	if $NPC.modulate.a>0.5:
		changing_window = false
		update_label_text()
	else:
		$Tween4Window.interpolate_property($Window1,"margin_top",0,333,0.3,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		$Tween4Window.start()
		
		
