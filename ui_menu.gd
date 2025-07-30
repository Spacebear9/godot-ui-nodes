@icon("uid://d368tvfg5ll8b")
extends UIElement
class_name UIMenu

@export_group("Menu Settings")
@export var mouse_mode:Input.MouseMode
## Controls what happens when ui_cancel is pressed[br][br]
## [b]close_menu[/b]: pressing ui_cancel will close this menu, and show the previous menu in the queue[br]
## [b]new_menu[/b]: pressing ui_cancel will open a new [b]UIMenu[/b] specified in escape_menu[br]
## [b]exit_app[/b]: pressing ui_cancel will quit the application[br]
## [b]disabled[/b]: disable menu escaping
@export var escape_mode = ESCAPE_MODES.close_menu
@export var escape_menu:UIMenu
enum ESCAPE_MODES{
		close_menu,
		new_menu,
		exit_app,
		disabled
	}

func switch_to():
	handler.switch(self)
