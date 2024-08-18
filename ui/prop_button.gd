extends Button
	
	
var prop_count = 0:
	set(value):
		prop_count = value
		text = "X" + str(prop_count)
	
	
var prop_type = Globals.PropType.BASIC_BLOCK:
	set(value):
		prop_type = value
		icon = Globals.PropIcon[prop_type]
		tooltip_text = Globals.PropDescription[prop_type]
	
	
func get_prop_scene():
	return Globals.PropScene[prop_type]
	
	
func get_prop_icon():
	return Globals.PropIcon[prop_type]
