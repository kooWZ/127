extends Button

signal touch_fish

func _on_TouchFish_pressed():
	emit_signal("touch_fish")
	print("test")
