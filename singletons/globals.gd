class_name Globals
extends Object


enum PropType {
	BASIC_BLOCK,
	CIRCLE,
	QUICK_BLOCK,
	DELAY_BLOCK
}
	
const PropScenePaths = [
	"res://props/basic_block/basic_block.tscn",
	"res://props/circle_block/circle_block.tscn",
	"res://props/quick_block/quick_block.tscn",
	"res://props/delay_block/delay_block.tscn"
]
	
	
const PropScene = {
	Globals.PropType.BASIC_BLOCK: preload(PropScenePaths[Globals.PropType.BASIC_BLOCK]),
	Globals.PropType.CIRCLE: preload(PropScenePaths[Globals.PropType.CIRCLE]),
	Globals.PropType.QUICK_BLOCK: preload(PropScenePaths[Globals.PropType.QUICK_BLOCK]),
	Globals.PropType.DELAY_BLOCK: preload(PropScenePaths[Globals.PropType.DELAY_BLOCK]),
}

const PropIcon = {
	Globals.PropType.BASIC_BLOCK: preload("res://props/basic_block/basic_block.png"),
	Globals.PropType.CIRCLE: preload("res://props/circle_block/circle_block.png"),
	Globals.PropType.QUICK_BLOCK: preload("res://props/quick_block/quick_block.png"),
	Globals.PropType.DELAY_BLOCK: preload("res://props/delay_block/delay_block.png")
}

const PropDescription = {
	Globals.PropType.BASIC_BLOCK: "Slowly doubles in size",
	Globals.PropType.CIRCLE: "Slowly doubles in size, able to roll",
	Globals.PropType.QUICK_BLOCK: "Rapidly doubles in size",
	Globals.PropType.DELAY_BLOCK: "Expands large after a short delay"
}

const Levels = [
	"res://levels/level_1.tscn",
	"res://levels/level_2.tscn",
	"res://levels/level_3.tscn",
	"res://levels/level_4.tscn",
	"res://levels/level_5.tscn",
	"res://levels/level_6.tscn",
	"res://levels/level_7.tscn",
	"res://levels/level_8.tscn",
	"res://levels/level_9.tscn",
	"res://levels/level_10.tscn",
	"res://levels/level_11.tscn",
	"res://levels/level_12.tscn",
	"res://levels/level_13.tscn"
]

const MainMenu = "res://ui/main_menu/main_menu.tscn"
