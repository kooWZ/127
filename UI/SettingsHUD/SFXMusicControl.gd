extends TextureButton

func _ready():
	self.pressed = Global.get_sfx_mute()

func _on_FxMusicControl_toggled(_button_pressed):
	Global.switchover_sfx()
