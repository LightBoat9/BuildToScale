extends Button



func _ready():
	set_pressed_no_signal(GlobalAudio.is_playing("BackgroundMusic"))


func _on_toggled(toggled_on):
	if toggled_on:
		GlobalAudio.play("BackgroundMusic")
	else:
		GlobalAudio.stop("BackgroundMusic")
