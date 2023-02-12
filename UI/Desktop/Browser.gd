extends Button

signal browser_button

func _on_Browser_pressed():
	emit_signal("browser_button")
