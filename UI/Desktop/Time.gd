extends Label


func _process(_delta):
	text = Time.get_datetime_string_from_system(false, true)
