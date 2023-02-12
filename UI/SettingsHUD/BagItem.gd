extends TextureButton

signal toggle(button,stat)

func _on_BagItem_toggled(button_pressed):
	emit_signal("toggle",self,button_pressed)
