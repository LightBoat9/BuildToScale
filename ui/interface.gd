extends CanvasLayer


const PropButton = preload("res://ui/prop_button.tscn")

@export var props = {
	Globals.PropType.BASIC_BLOCK: 0,
	Globals.PropType.CIRCLE: 0,
	Globals.PropType.QUICK_BLOCK: 0,
	Globals.PropType.DELAY_BLOCK: 0
}

@export var infinite = false
@onready var prop_button_container = $Control/PropContainer
@onready var prop_button_box = $Control/PropContainer/VBoxContainer
@onready var level_complete_popup = $Control/LevelCompletePopup
@onready var buttons = $Control/Buttons
@onready var level_label = $Control/HBoxContainer/PanelContainer/Label

var is_reset = false

var force_show_button = {
	Globals.PropType.BASIC_BLOCK: false,
	Globals.PropType.CIRCLE: false,
	Globals.PropType.QUICK_BLOCK: false,
	Globals.PropType.DELAY_BLOCK: false
}

func _init():
	correct_props()
	
func correct_props():
	for type in Globals.PropType.values():
		if not props.has(type):
			props[type] = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_reset:
		$AudioClear.play()
	else:
		$AudioPlay.play()
		
	level_label.text = "Level " + str(Globals.Levels.find(get_tree().get_first_node_in_group("top_level").scene_file_path) + 1)
	
	correct_props()
	visible = true
	for type in Globals.PropType.values():
		if infinite or props[type] > 0 or force_show_button[type]:
			var instance = PropButton.instantiate()
			instance.prop_count = props[type] if not infinite else 99
			instance.prop_type = type
			prop_button_box.add_child(instance)
		
	if prop_button_box.get_child_count() > 0:
		prop_button_box.get_child(0).grab_focus()


func _on_reset_button_pressed():
	reset()
	
func reset(autoplay=false, place_props=true):
	var current_props = get_tree().get_nodes_in_group("props")
	for prop in current_props:
		prop.get_parent().remove_child(prop)
		
	var current_scene = load(get_tree().current_scene.scene_file_path).instantiate()
	
	if place_props:
		for prop in current_props:
			var index = Globals.PropScenePaths.find(prop.scene_file_path)
			var new_instance = Globals.PropScene[index].instantiate()
			new_instance.global_position = prop.original_position
			
			current_scene.add_child(new_instance)
	
	var interface = current_scene.get_node("Interface")
	interface.is_reset = not autoplay
	interface.correct_props()
	if place_props:
		for prop in current_props:
			var id = Globals.PropScenePaths.find(prop.scene_file_path)
			interface.props[id] -= 1
			interface.force_show_button[id] = true
	
	var top_level = get_tree().root.get_child(get_tree().root.get_child_count()-1)
	get_tree().root.add_child(current_scene)
	
	get_tree().root.remove_child(top_level)
	top_level.queue_free()
	
	current_scene.get_tree().current_scene = current_scene
	
	if autoplay and len(current_scene.get_tree().get_nodes_in_group("props")) > 0:
		current_scene.get_tree().set_group("top_level", "is_active", true)


func _on_go_button_pressed():
	if len(get_tree().get_nodes_in_group("props")) > 0:
		get_tree().set_group("top_level", "is_active", true)
	
	
func add_prop(index):
	for button in prop_button_box.get_children():
		if button.prop_type == index:
			button.prop_count += 1
	
	
func complete_level():
	get_tree().paused = true
	buttons.visible = false
	prop_button_container.visible = false
	
	await get_tree().create_timer(1.0).timeout
	level_complete_popup.visible = true
	
	
func _on_replay_level_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_level_select_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(Globals.MainMenu)


func _on_next_level_button_pressed():
	get_tree().paused = false
	var current = Globals.Levels.find(get_tree().get_first_node_in_group("top_level").scene_file_path)
	if current+1 < len(Globals.Levels):
		get_tree().change_scene_to_file(Globals.Levels[current+1])
	else:
		_on_main_menu_pressed()


func _on_clear_pressed():
	reset(false, false)


func _on_replay_button_pressed():
	reset(true)


func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(Globals.MainMenu)
