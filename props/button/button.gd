extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	if body != self:
		$AudioWin.play()
		$Sprite2D.frame = 1
		get_tree().call_group("interface", "complete_level")
