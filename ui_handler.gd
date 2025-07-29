@icon("uid://dt8355xxp77ic")
extends CanvasLayer
class_name UIHandler
## Main handler for UIElement nodes

@export var debug_mode: bool
var debug_nodes: Array[Node]

@export_group("UI Menus")
@export var first_active:UIMenu
var menu_hierarchy: Array[UIMenu]

signal menu_changed(UIMenu)

func _ready() -> void:
	_setup_children()
	
func _unhandled_input(event: InputEvent) -> void:
	if not get_active_menu() is UIMenu or not event.is_action_pressed("ui_cancel"):
		return
	if get_active_menu().escape_mode == UIMenu.ESCAPE_MODES.close_menu:
		escape()
		return
	if get_active_menu().escape_mode == UIMenu.ESCAPE_MODES.new_menu && get_active_menu().escape_menu is UIMenu:
		switch(get_active_menu().escape_menu)
		return

func _setup_children():
	for child in get_children():
		if child is UIMenu:
			child.hide()
			child.z_index = 1
			continue
		if child is UIElement:
			child.show()
	switch(first_active)

func add_element(to_add:UIElement):
	add_child(to_add)
	if to_add is not UIStatic:
		return
	for child in get_children():
		if child is UIStatic:
			continue
		move_child(to_add,child.get_index())
		break

func get_active_menu() -> UIMenu:
	if menu_hierarchy.size() == 0:
		return null
	return menu_hierarchy[menu_hierarchy.size()-1]

func _change_active_menu(new_menu:UIMenu):
	if new_menu is not UIMenu or not new_menu == get_active_menu():
		return
	menu_changed.emit(new_menu)
	new_menu.show()
	set_debug_label()
	Input.mouse_mode = new_menu.mouse_mode

func switch(switch_to:UIMenu):
	if not switch_to is UIMenu:
		return
	if get_active_menu():
		get_active_menu().hide()
	menu_hierarchy.append(switch_to)
	_change_active_menu(switch_to)

func escape():
	if menu_hierarchy.size() > 0:
		get_active_menu().hide()
		menu_hierarchy.remove_at(menu_hierarchy.size()-1)
		if menu_hierarchy.size() > 0:
			_change_active_menu(get_active_menu())

func escape_all():
	while menu_hierarchy.size() > 0:
		escape()

func set_debug_label():
	if debug_mode:
		for node in debug_nodes:
			node.queue_free()
		debug_nodes.clear()
		if get_active_menu():
			var debug_label = Label.new()
			debug_label.set_anchors_preset(Control.PRESET_CENTER_TOP)
			debug_label.text = get_active_menu().name
			add_child(debug_label)
			debug_nodes.append(debug_label)
			debug_label.z_index = 5
