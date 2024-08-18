extends Control


@onready var button_grid = $PanelContainer/VBoxContainer/GridContainer


func _ready():
	for level in range(len(Globals.Levels)):
		var button = Button.new()
		button.text = "Level " + str(level+1)
		button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		button_grid.add_child(button)
		button.pressed.connect(Callable(button_pressed).bind(level))


func button_pressed(level):
	get_tree().change_scene_to_file(Globals.Levels[level])
