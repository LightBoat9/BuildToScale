@tool
extends Node2D


@export var color: Color = Color("25868b64")
@export var outline: Color = Color("4caf6e")
@export var area: Vector2 = Vector2(4, 4):
	set(value):
		area = value
		queue_redraw()
		if draw_area:
			draw_area.queue_redraw()
		
		
@onready var draw_area = $DrawArea


func _process(delta):
	queue_redraw()
		
	if draw_area:
		draw_area.queue_redraw()
	
	if Engine.is_editor_hint() or get_tree().get_first_node_in_group("top_level").is_active:
		return
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_position = ((get_local_mouse_position() - Vector2(8, 8)) / Vector2(8, 8)).round() * Vector2(8, 8)
		if Rect2(Vector2(), (area * Vector2(8, 8))-Vector2(8, 8)).has_point(mouse_position):
			if not prop_at_position(to_global(mouse_position + Vector2(8, 8))) and get_viewport().gui_get_focus_owner().prop_count > 0:
				$AudioPlay.play()
				get_viewport().gui_get_focus_owner().prop_count -= 1
				var instance = get_viewport().gui_get_focus_owner().get_prop_scene().instantiate()
				instance.global_position = to_global(mouse_position + Vector2(8, 8))
				get_parent().add_child(instance)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var mouse_position = ((get_local_mouse_position() - Vector2(8, 8)) / Vector2(8, 8)).round() * Vector2(8, 8)
		if Rect2(Vector2(), (area * Vector2(8, 8))-Vector2(8, 8)).has_point(mouse_position):
			var prop = prop_at_position(to_global(mouse_position + Vector2(8, 8)))
			if prop:
				get_tree().get_first_node_in_group("interface").add_prop(Globals.PropScenePaths.find(prop.scene_file_path))
				prop.queue_free()


func _draw():
	draw_rect(Rect2(Vector2(), area * Vector2(8, 8)), color, true)
	draw_rect(Rect2(Vector2(0.5, 0.5), (area * Vector2(8, 8))-Vector2(1, 1)), outline, false, 1, false)
	
	
func prop_at_position(pos, distance=16):
	for prop in get_tree().get_nodes_in_group("props"):
		if prop.global_position.distance_to(pos) < distance:
			return prop
	return null
