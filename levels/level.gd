extends Node2D


var is_active = false:
	set(value):
		is_active = value
		get_tree().set_group("props", "freeze", false)
		get_tree().set_group("allowed_areas", "visible", false)
