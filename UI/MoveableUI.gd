extends Control

var dragging = false
var offset
onready var DragSection = find_node("DragSection")

func _input(event):
	if event is InputEventMouseButton:
		print("input1")
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("input2")
			if inside():
				dragging = true
				offset = get_global_mouse_position() - rect_global_position
			else:
				dragging = false
		else:
			dragging = false

func _ready():
	print(DragSection)

func _process(delta):
	if dragging:
		rect_global_position = get_global_mouse_position() - offset

func inside():
	print("inside")
	if get_global_mouse_position().x >= DragSection.rect_global_position.x and get_global_mouse_position().y >= DragSection.rect_global_position.y and get_global_mouse_position().x <= DragSection.rect_global_position.x+DragSection.rect_size.x and get_global_mouse_position().y <= DragSection.rect_global_position.y+DragSection.rect_size.y:
		print("true")
		return true
	else:
		print("false")
		return false
