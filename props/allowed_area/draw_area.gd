extends Node2D


func _draw():
	if not Engine.is_editor_hint():
		var mouse_position = ((get_local_mouse_position() - Vector2(8, 8)) / Vector2(8, 8)).round() * Vector2(8, 8)
		if Rect2(Vector2(), (get_parent().area * Vector2(8, 8))-Vector2(8, 8)).has_point(mouse_position):
			draw_texture(get_viewport().gui_get_focus_owner().get_prop_icon(), mouse_position, Color("fc779064") if get_parent().prop_at_position(to_global(mouse_position) + Vector2(8, 8)) else Color(1, 1, 1, 0.5))
