extends Control

func _on_Button_toggled(button_pressed):
	if button_pressed:
		Global.pause()
		$Label.text = "继续"
	else:
		Global.resume()
		$Label.text = "暂停"
