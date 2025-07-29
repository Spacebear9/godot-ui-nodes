@icon("uid://c4cdmay2krbd1")
extends Control
class_name UIElement

var handler:UIHandler

func _ready() -> void:
	if get_parent() is not UIHandler:
		push_error("parent node is not UiHandler, MenuItem should always be a child of UiHandler")
		return
	handler = get_parent()
